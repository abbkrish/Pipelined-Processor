import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module comparator #(parameter width = 9)
(
	input [width-1:0] a, b,
	output logic f
);

assign f = a == b;

endmodule: comparator