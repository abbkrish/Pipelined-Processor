import lc3b_types::*;

module addr_splitter
(
	input lc3b_word mem_address,
	output lc3b_L1_tag tag,
	output lc3b_L1_index set,
	output lc3b_L1_offset offset,
	output logic last_bit
);

assign tag = mem_address[15:7];
assign set = mem_address[6:4];
assign offset = mem_address[3:1];
assign last_bit = mem_address[0];

endmodule: addr_splitter