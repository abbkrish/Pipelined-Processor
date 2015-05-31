import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module data_selector
(
	input a, b,
	output logic f
);

always_comb
begin
	f = 1'b0;
	if (a)
		f = 1'b1;
	else if (b)
		f = 1'b0;
end

endmodule: data_selector