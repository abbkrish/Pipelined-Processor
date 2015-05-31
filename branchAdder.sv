import lc3b_types::*;
module branchAdder #(parameter width = 16)
(
	input [width-1:0] pc,
	input [width-1:0] offset,
	
	output lc3b_word targetAddr
);

always_comb

begin

targetAddr = pc + offset;

end

endmodule : branchAdder
