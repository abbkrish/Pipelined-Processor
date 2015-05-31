

import lc3b_types::*;

module EX_MEM_register (

	input clk,
	input load,
	input lc3b_control_word control_word_ID_EX,
	input lc3b_word icache_rdata_ID_EX,
	input lc3b_word pc_out_ID_EX,
	output lc3b_word pc_out_EX_MEM,
	input lc3b_offset11 offset11_ID_EX,
   input lc3b_trapvect8 tv8_ID_EX,	
	input lc3b_offset9 offset9_ID_EX, 
	input branch_enable,
	input lc3b_word br_add_out,
	input lc3b_word alu_out,
	input lc3b_word sr1_out,
	input lc3b_reg dest_ID_EX,
	output lc3b_control_word control_word_EX_MEM_to_ID_EX,
   output lc3b_word br_add_out_EX_MEM,
	output lc3b_word alu_out_EX_MEM,
	output lc3b_imm4 imm4_EX_MEM,
	output lc3b_trapvect8 tv8_EX_MEM,
	output lc3b_offset11 offset11_EX_MEM, 
	output lc3b_offset9 offset9_EX_MEM, 
	output	lc3b_reg dest_EX_MEM,
	output lc3b_reg dest_EX_MEM_to_ID_EX,
	output lc3b_word sr1_out_EX_MEM_to_ID_EX,
	output lc3b_control_word control_word_EX_MEM,
	output logic[1:0] mem_byte_enable_EX_MEM,//FOr stb change this.
	output lc3b_word icache_rdata_EX_MEM,
	output lc3b_word mem_wdata 

);

lc3b_word mem_wdata_intermediate;
lc3b_word br_add_out_intermediate;
lc3b_word alu_out_intermediate;
lc3b_reg dest_intermediate;
lc3b_control_word  control_word_intermediate;
lc3b_offset9 offset9_intermediate;
lc3b_offset11 offset11_intermediate;
lc3b_imm4 imm4_intermediate;
lc3b_word pc_intermediate;


initial 
begin
	mem_wdata_intermediate = 16'b0;
	br_add_out_intermediate=16'b0;
	alu_out_intermediate=16'b0;
	dest_intermediate=3'b0;
	control_word_intermediate = 0;
	offset9_intermediate =0;
	offset11_intermediate = 0;
	pc_intermediate = 0;
	imm4_intermediate = 0;
	control_word_EX_MEM_to_ID_EX = 0;
	mem_byte_enable_EX_MEM = 2'b11;

end

always_ff @(posedge clk)
begin
	 if (load)
    begin
      mem_wdata_intermediate = sr1_out; //D :  TODO: feed in mem_rdata ??? shold be sr1_out or alu out???
	//	if (control_word_EX_MEM.opcode == op_stb)
	//			mem_wdata_intermediate = {8'b0,sr1_out[7:0]};
		/*if (control_word_ID_EX.opcode == op_stb)
		begin
			if (alu_out[0] == 1)
			begin
				mem_wdata_intermediate = {sr1_out[7:0],8'b0};
			end
			else
			begin
			mem_wdata_intermediate = {8'b0,sr1_out[7:0]};
			end
		end*/

		br_add_out_intermediate = br_add_out;
		alu_out_intermediate = alu_out;
		offset9_intermediate = offset9_ID_EX;
		offset11_intermediate = offset11_ID_EX;
		imm4_intermediate = offset11_ID_EX[3:0];
		icache_rdata_EX_MEM = icache_rdata_ID_EX;
		tv8_EX_MEM = tv8_ID_EX;
		pc_intermediate = pc_out_ID_EX;
		control_word_intermediate = control_word_ID_EX;
		control_word_EX_MEM_to_ID_EX = 0;
		if (branch_enable && control_word_intermediate.opcode ==op_br)  
			begin
				control_word_intermediate.pcmux_sel = 1;
				control_word_intermediate.load_pc = 1;
				control_word_intermediate.brmux_sel = 0;//i know default is 0 but just to emphasize that this is for branch taken
			end
	 if (control_word_intermediate.opcode == op_jmp)
		begin
			control_word_intermediate.pcmux_sel = 2;
			control_word_intermediate.load_pc = 1;
		end
		if (control_word_intermediate.opcode == op_ldi || control_word_intermediate.opcode == op_sti)
		begin
				control_word_EX_MEM_to_ID_EX = control_word_intermediate;//send this back to ID_EX for the next mem_read
				if (control_word_intermediate.opcode == op_ldi)
					control_word_EX_MEM_to_ID_EX.opcode = op_ldr;
				if (control_word_intermediate.opcode == op_sti)
				begin
					control_word_EX_MEM_to_ID_EX.opcode = op_str; //????? You first do an LDR, then an STR in an STI
					control_word_intermediate.mem_read = 1;
					control_word_intermediate.mem_write = 0;
				end
				control_word_EX_MEM_to_ID_EX.aluop = alu_pass;
				//might have to stall in ID_EX while waiting for the memory
				//control_word_EX_MEM_to_ID_EX.mem_read = 1;// for STI ???????D: Why don't you just put this into the str loop?
				control_word_EX_MEM_to_ID_EX.alu_amux_sel = 4;
				dest_EX_MEM_to_ID_EX = dest_ID_EX;
				sr1_out_EX_MEM_to_ID_EX = sr1_out;
		end
		if (control_word_intermediate.opcode != op_br)
			dest_intermediate = dest_ID_EX;
		if (control_word_intermediate.opcode == op_stb)
			begin
				if (alu_out[0] == 1)
				begin
					mem_wdata_intermediate = {sr1_out[7:0],8'b0};
					mem_byte_enable_EX_MEM = 2'b10;
						
				end
				else
				begin
					mem_byte_enable_EX_MEM = 2'b01;
					
					end
			end
			else
			begin
				mem_byte_enable_EX_MEM = 2'b11;
			end
		

			
    end
end

always_comb
begin
	   mem_wdata = mem_wdata_intermediate; //D :  TODO: feed in mem_rdata ??? shold be sr1_out or alu out???
		
		br_add_out_EX_MEM = br_add_out_intermediate;
		alu_out_EX_MEM = alu_out_intermediate;
		imm4_EX_MEM = imm4_intermediate;
		offset9_EX_MEM = offset9_intermediate;
		offset11_EX_MEM = offset11_intermediate;
		pc_out_EX_MEM = pc_intermediate;
		control_word_EX_MEM = control_word_intermediate;
		dest_EX_MEM = dest_intermediate;
	
end

endmodule: EX_MEM_register