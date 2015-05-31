import lc3b_types::*;

module br_add(

	input lc3b_word brmux_out,
	input lc3b_word pc_out,
	output lc3b_word br_add
	);
	
	assign br_add = brmux_out + pc_out;
	
	endmodule: br_add
	
	