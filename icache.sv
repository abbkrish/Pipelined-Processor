import lc3b_types::*;

module icache
(
	input clk,
	
    input icache_read,
	input lc3b_word icache_address,
	output lc3b_word icache_rdata,
	output logic icache_resp,
	
	input L2_resp,
	input lc3b_L1_line L2_rdata,
	output logic L2_read,
	output lc3b_word L2_address
);

logic 	lru_dataout;

logic	hit_A, hit_B;

logic	valid_A_dataout, valid_B_dataout;
logic	valid_A_write, valid_B_write;
logic	valid_A_datain, valid_B_datain;

logic	tag_A_write, tag_B_write;

logic	data_A_write, data_B_write;

logic	lru_datain;
logic	lru_write;

logic pmemaddressmux_sel;

// *CONVENTION*: B is MSB, A is LSB
icache_datapath ICACHE_DATAPATH
(
	.*
);

icache_control ICACHE_CONTROL
(
	.*,
	.lru(lru_dataout)
);

endmodule: icache