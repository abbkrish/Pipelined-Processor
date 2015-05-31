import lc3b_types::*;

module dcache
(
	input clk,
	
    input dcache_read,
    input dcache_write,
    input lc3b_mem_wmask mem_byte_enable,
	input lc3b_word dcache_address,
    input lc3b_word dcache_wdata,
	output lc3b_word dcache_rdata,
	output logic dcache_resp,
	
	input L2_resp,
	input lc3b_L1_line L2_rdata,
	output logic L2_read,
	output logic L2_write,
	output lc3b_word L2_address,
	output lc3b_L1_line L2_wdata
);

logic 	lru_dataout;

logic	hit_A, hit_B;

logic	valid_A_dataout, valid_B_dataout;
logic	valid_A_write, valid_B_write;
logic	valid_A_datain, valid_B_datain;

logic	dirty_A_dataout, dirty_B_dataout;
logic	dirty_A_write, dirty_B_write;
logic	dirty_A_datain, dirty_B_datain;

logic	tag_A_write, tag_B_write;

logic	data_A_write, data_B_write;

logic	lru_datain;
logic	lru_write;

logic replacemux_sel;

logic pmemaddressmux_sel;

// *CONVENTION*: B is MSB, A is LSB
dcache_datapath DCACHE_DATAPATH
(
	.*,
	.data_A_write_ctrl(data_A_write),
	.data_B_write_ctrl(data_B_write)
);

dcache_control DCACHE_CONTROL
(
	.*,
	.lru(lru_dataout)
);

endmodule: dcache