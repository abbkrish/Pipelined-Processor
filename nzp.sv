module nzp (input logic Clk, Reset, load_nzp,
				input logic [15:0] bus_data, 
				output logic N, Z, P);
				
		always @(posedge Clk or posedge Reset)
		begin
			if (Reset)
			begin 
				N <= 1'b0;
				Z <= 1'b0;
				P <= 1'b0;
			end
			else if (load_nzp)
			begin
				if (bus_data < 16'h0000)
				begin
					N <= 1'b1;
					Z <= 1'b0;
					P <= 1'b0;
				end
				else if (bus_data == 16'h0000)
				begin
					N <= 1'b0;
					Z <= 1'b1;
					P <= 1'b0;
				end
				else
				begin
					N <= 1'b0;
					Z <= 1'b0;
					P <= 1'b1;
				end
			end
		end
		
endmodule 