import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module icache_datapath
(
	input clk,
	
	output logic hit_A, hit_B,
		
	input valid_A_write, valid_B_write,
	input tag_A_write, tag_B_write,
	input data_A_write, data_B_write,
	input lru_write,
	
	input valid_A_datain, valid_B_datain,
	input lru_datain,
	
	output logic valid_A_dataout, valid_B_dataout,
	output logic lru_dataout,
	
	input lc3b_word icache_address,

	input lc3b_L1_line L2_rdata,
	
	output lc3b_word icache_rdata,
	
	output lc3b_word L2_address
);

assign L2_address = icache_address;

typedef logic [2:0] lc3b_L1_index;
typedef logic [8:0] lc3b_L1_tag;

lc3b_L1_tag tag;
lc3b_L1_index set;
lc3b_L1_offset offset;
logic last_bit;

lc3b_L1_tag tag_A_dataout, tag_B_dataout;
lc3b_L1_line data_A_dataout, data_B_dataout;
lc3b_L1_line data_A_datain, data_B_datain;
lc3b_L1_line readdatamux_out;
logic dataselector_out;

logic comp_A_out, comp_B_out;

assign hit_A = valid_A_dataout && comp_A_out;
assign hit_B = valid_B_dataout && comp_B_out;
	
assign data_A_datain = L2_rdata;
assign data_B_datain = L2_rdata;
	
addr_splitter ADDR_SPLITTER
(
	.mem_address(icache_address),
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
	.out(icache_rdata)
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

endmodule: icache_datapath