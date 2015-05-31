import lc3b_types::*;

module control_rom (

input lc3b_opcode opcode, 
output lc3b_control_word control_word,
input logic immediate_bit, // for checking if it is AND or ADD immediate//also bit 5 for SHF
input logic d_bit_shf, 
input logic jsr_bit //for JSR and JSRR 
);



	
always_comb
begin
	control_word.opcode = opcode;
	control_word.load_cc = 1'b0;
	control_word.load_regfile = 1'b0;
	
	control_word.load_pc = 1'b1;
	control_word.load_IF_ID = 1'b1; //D: for future checkpoints, set all but if_Id to 0 and set them to one a the next stage to prevent stalling.
	control_word.load_ID_EX = 1'b1;
	control_word.load_EX_MEM = 1'b1;
	control_word.load_MEM_WB = 1'b1;
	
	control_word.brmux_sel= 2'b00;
	control_word.pcmux_sel = 3'b000;
	control_word.regfilemux_sel = 2'b00;
	control_word.storemux_sel = 2'b00;
	control_word.src2mux_sel = 2'b00;
	control_word.alu_bmux_sel = 2'b00;
	control_word.alu_amux_sel = 3'b000;
	control_word.mem_read = 1'b0;
	control_word.wbmux_sel = 1'b0;
	control_word.mem_write = 1'b0;
	control_word.memAddr_mux_sel=1'b0;
	control_word.bit_A_shf = 1'b0;
	control_word.bit_D_shf = 1'b0;
	control_word.aluop = alu_add;
	control_word.op2_sel = 2'b00;

	case (opcode)
		op_add: begin
													//TODO: need to add case for immediate add
			control_word.aluop = alu_add;
			control_word.load_regfile = 1;
			control_word.load_cc = 1;
			if (immediate_bit)
				begin
					control_word.op2_sel = 2;
					control_word.alu_bmux_sel = 1;
				end
			
		end
		
		op_and: begin
			
			control_word.aluop = alu_and;
			control_word.load_regfile = 1;
			control_word.load_cc = 1;
			if (immediate_bit)
				begin
					control_word.op2_sel = 2;
					control_word.alu_bmux_sel = 1;
				end

		end
		
		op_not: begin
		
			control_word.aluop = alu_not;
			control_word.load_regfile = 1;
			control_word.load_cc = 1;
			control_word.op2_sel = 0;
		end
		op_br: begin
			//seems like we have to change the control word during the movement through the pipeline. 
			control_word.pcmux_sel = 2'b00;
		end
		
		op_ldr: begin
		
			control_word.op2_sel = 5;
			control_word.mem_read = 1;
			control_word.load_cc = 1;
			control_word.wbmux_sel = 1;
			control_word.alu_bmux_sel=1;
			control_word.load_regfile = 1;
		end
		
		op_str: begin
		
				control_word.op2_sel = 5;
				control_word.alu_bmux_sel = 1;
				control_word.alu_amux_sel = 2;
				control_word.mem_write = 1;
				control_word.load_cc = 1;
				control_word.storemux_sel = 1;
				control_word.src2mux_sel = 1;
				control_word.alu_amux_sel = 2;
		
		end
		
		op_jmp: begin
		
			control_word.aluop = alu_pass;
			
		
		end
		
		op_lea: begin
		
			control_word.aluop = alu_pass;
			control_word.load_cc = 1;
			control_word.load_regfile = 1;

		
		end
		
		op_jsr: begin//A have to check how data hazards will work with this op 
		
			control_word.load_regfile = 1;
			control_word.storemux_sel = 2;
			control_word.regfilemux_sel = 2;
			
			if (jsr_bit == 1) //A JSR
				begin
					control_word.brmux_sel = 1;
					control_word.pcmux_sel = 1;
				end
			else //A JSRR
				begin
				control_word.storemux_sel = 0; //cuz sr1 comes out of here
					control_word.pcmux_sel = 2;
					control_word.aluop = alu_pass; //alu_out = sr1_out
				end
			
		end
		
		op_trap: begin
		
				control_word.load_regfile = 1;
				control_word.storemux_sel = 2;
				control_word.regfilemux_sel = 2;
				control_word.op2_sel = 6;
				control_word.alu_amux_sel = 4;
				control_word.alu_bmux_sel = 1;
				control_word.pcmux_sel = 3;
				control_word.aluop = alu_trap;
				control_word.mem_read = 1;
				control_word.wbmux_sel = 1;
		
		end
		
		op_ldi: begin
		
			control_word.op2_sel = 5;
			control_word.mem_read = 1;
			control_word.load_cc = 1;
			control_word.wbmux_sel = 1;
			control_word.alu_bmux_sel=1;
			control_word.load_regfile = 1;
		
		end
		
		op_shf: begin
		
			control_word.aluop = alu_pass;
			control_word.load_cc = 1;
			control_word.load_regfile = 1;
			control_word.bit_A_shf = immediate_bit;
			control_word.bit_D_shf = d_bit_shf;
		
		end
		
		op_stb: begin
		
				control_word.op2_sel = 3;
				control_word.alu_bmux_sel = 1;
				control_word.alu_amux_sel = 2;
				control_word.mem_write = 1;
				control_word.load_cc = 1;
				control_word.storemux_sel = 1;
				control_word.src2mux_sel = 1;
				control_word.alu_amux_sel = 2;
		
		end
		
		op_ldb: begin
		
			
			control_word.op2_sel = 3;
			control_word.mem_read = 1;
			control_word.load_cc = 1;
			control_word.wbmux_sel = 1;
			control_word.alu_bmux_sel=1;
			control_word.load_regfile = 1;
		
		end
		
		op_sti: begin
		
				control_word.op2_sel = 5;
				control_word.alu_bmux_sel = 1;
				control_word.alu_amux_sel = 2;
				control_word.mem_write = 1;
				control_word.load_cc = 1;
				control_word.storemux_sel = 1;
				control_word.src2mux_sel = 1;
				control_word.alu_amux_sel = 2;
		
		end
		
		default: begin
			control_word = 0;
			
		end
	//
	endcase
end
endmodule:control_rom