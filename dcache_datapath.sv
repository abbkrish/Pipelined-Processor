import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module dcache_datapath
(
	input clk,
	
	output logic hit_A, hit_B,
		
	input valid_A_write, valid_B_write,
	input dirty_A_write, dirty_B_write,
	input tag_A_write, tag_B_write,
	input data_A_write_ctrl, data_B_write_ctrl,
	input lru_write,
	
	input valid_A_datain, valid_B_datain,
	input dirty_A_datain, dirty_B_datain,
	input lru_datain,
	
	output logic valid_A_dataout, valid_B_dataout,
	output logic dirty_A_dataout, dirty_B_dataout,
	output logic lru_dataout,
	
	input lc3b_word dcache_address,
	input lc3b_word dcache_wdata,
	input lc3b_mem_wmask mem_byte_enable,
	// maybe not?
	input dcache_write,
	
	input pmemaddressmux_sel,
	input lc3b_L1_line L2_rdata,
	
	input replacemux_sel,
	
	output lc3b_word dcache_rdata,
	output lc3b_L1_line L2_wdata,
	
	output lc3b_word L2_address
);

lc3b_L1_tag tag;
lc3b_L1_index set;
lc3b_L1_offset offset;
logic last_bit;

lc3b_L1_tag tag_A_dataout, tag_B_dataout;
lc3b_L1_line data_A_dataout, data_B_dataout;
lc3b_L1_line data_A_datain, data_B_datain;
lc3b_L1_line readdatamux_out;
lc3b_L1_line wordreplacer_out;
lc3b_L1_line writebackmux_out;
lc3b_L1_line replacemux_out;
logic dataselector_out;
logic data_A_write, data_B_write;

logic comp_A_out, comp_B_out;
logic data_A_write_hit, data_B_write_hit;

lc3b_word writeback_address;

lc3b_L1_line word_replacer_A_out, word_replacer_B_out;

assign hit_A = valid_A_dataout && comp_A_out;
assign hit_B = valid_B_dataout && comp_B_out;

assign data_A_write_hit = dcache_write && hit_A;
assign data_B_write_hit = dcache_write && hit_B;
assign data_A_write = data_A_write_hit || data_A_write_ctrl;
assign data_B_write = data_B_write_hit || data_B_write_ctrl;

assign data_A_datain = replacemux_out;
assign data_B_datain = replacemux_out;

mux2 wb_addrmux
(
	.sel(lru_dataout),
	.a({tag_B_dataout, set, offset, last_bit}),
	.b({tag_A_dataout, set, offset, last_bit}),
	.f(writeback_address)
);
	
addr_splitter ADDR_SPLITTER
(
	.mem_address(dcache_address),
	.tag(tag),
	.set(set),
	.offset(offset),
	.last_bit(last_bit)
);

array #(.width(1)) VALID_A
(
	.clk(clk),
	.write(valid_A_write),
	.index(set),
	.datain(valid_A_datain),
	.dataout(valid_A_dataout)
);

array #(.width(1)) VALID_B
(
	.clk(clk),
	.write(valid_B_write),
	.index(set),
	.datain(valid_B_datain),
	.dataout(valid_B_dataout)
);

array #(.width(1)) DIRTY_A
(
	.clk(clk),
	.write(dirty_A_write),
	.index(set),
	.datain(dirty_A_datain),
	.dataout(dirty_A_dataout)
);

array #(.width(1)) DIRTY_B
(
	.clk(clk),
	.write(dirty_B_write),
	.index(set),
	.datain(dirty_B_datain),
	.dataout(dirty_B_dataout)
);

array #(.width(1)) LRU
(
	.clk(clk),
	.write(lru_write),
	.index(set),
	.datain(lru_datain),
	.dataout(lru_dataout)
);

array #(.width(9)) TAG_A
(
	.clk(clk),
	.write(tag_A_write),
	.index(set),
	.datain(tag),
	.dataout(tag_A_dataout)
);

array #(.width(9)) TAG_B
(
	.clk(clk),
	.write(tag_B_write),
	.index(set),
	.datain(tag),
	.dataout(tag_B_dataout)
);

array #(.width(128)) DATA_A
(
	.clk(clk),
	.write(data_A_write),
	.index(set),
	.datain(data_A_datain),
	.dataout(data_A_dataout)
);

array #(.width(128)) DATA_B
(
	.clk(clk),
	.write(data_B_write),
	.index(set),
	.datain(data_B_datain),
	.dataout(data_B_dataout)
);

data_selector DATA_SELECTOR
(
	.a(hit_A),
	.b(hit_B),
	.f(dataselector_out)
);

mux2 #(.width(128)) readdatamux
(
	.sel(dataselector_out),
	.a(data_B_dataout),
	.b(data_A_dataout),
	.f(readdatamux_out)
);

mux8 #(.width(16)) wordmux
(
	.sel(offset),
	.a(readdatamux_out[15:0]),
	.b(readdatamux_out[31:16]),
	.c(readdatamux_out[47:32]),
	.d(readdatamux_out[63:48]),
	.e(readdatamux_out[79:64]),
	.f(readdatamux_out[95:80]),
	.g(readdatamux_out[111:96]),
	.h(readdatamux_out[127:112]),
	.out(dcache_rdata)
);

word_replacer WORD_REPLACER
(
	.mem_address(dcache_address),
	.byte_enable(mem_byte_enable),
	.data_block(readdatamux_out),
	.data_word(dcache_wdata),
	.enable(dcache_write),
	.data_out(wordreplacer_out)
);

mux2 #(.width(128)) replacemux
(
	.sel(replacemux_sel),
	.a(L2_rdata),
	.b(wordreplacer_out),
	.f(replacemux_out)
);

mux2 #(.width(128)) writebackmux
(
	.sel(lru_dataout),
	.a(data_B_dataout),
	.b(data_A_dataout),
	.f(L2_wdata)
);

mux2 #(.width(16)) pmemaddressmux
(
	.sel(pmemaddressmux_sel),
	.a(dcache_address),
	.b(writeback_address),
	.f(L2_address)
);

comparator COMP_A
(
	.a(tag),
	.b(tag_A_dataout),
	.f(comp_A_out)
);

comparator COMP_B
(
	.a(tag),
	.b(tag_B_dataout),
	.f(comp_B_out)
);

endmodule: dcache_datapath