import lc3b_types::*;

module zeroext #(parameter width = 8) 
(
	input [width - 1: 0] in,
	output lc3b_word out
);


assign out = $unsigned(in);

endmodule 