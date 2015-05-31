import lc3b_types::*;

module shift #(parameter width = 16)
(
	input [width -1: 0] in,
	input lc3b_imm4 imm4,
	input lc3b_shf status,
	output lc3b_word out
);


always_comb
	begin
		if (status[0] == 0)
			out = in << imm4;
		else 
			if (status[1] == 0)
				out = in >> imm4;
			else
				out = $signed(in) >>> imm4; //didn't work without $signed, for some reason
	end

	endmodule
	
	