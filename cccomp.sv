import lc3b_types::*;

module cccomp (

		input lc3b_reg a,
		input lc3b_nzp cc,
		output logic branch_enable
);

	always_comb
	begin
		if ((a[2] == 1'b1 && cc[2] == 1'b1))
			branch_enable = 1;
		else if (a[1] == 1'b1 && cc[1] == 1'b1)
			branch_enable = 1;
		else if (a[0] == 1'b1 && cc[0] == 1'b1)
			branch_enable = 1;
		else 
			branch_enable = 0;
	end
		/*
		if (a < 3'b000)
		begin
			if (cc == 3'b100 || cc == 3'b101 || cc == 3'b110 || cc == 3'b111)
				branch_enable = 1;
			else	
				branch_enable = 0;
		end
		else if (a == 3'b000)
		begin 
			if (cc == 3'b011 || cc == 3'b111 || cc == 3'b010 || cc == 3'b110) //Z = 1, NZP 
				branch_enable = 1;
			else
				branch_enable = 0;		
		end
		else 
		begin
			if (cc == 3'b001 || cc == 3'b101 || cc == 3'b011 || cc == 3'b111) //P = 1, NZP, 
				branch_enable = 1;
			else 
				branch_enable = 0;
		end
	end
	*/
	
	
endmodule	