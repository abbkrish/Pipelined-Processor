import lc3b_types::*;



module ID_EX_register (

	input clk,
	input load,
	input lc3b_word pc_out_IF_ID,
	input lc3b_word icache_rdata_IF_ID,
	input lc3b_word icache_rdata_EX_MEM,//A this is to check if the previous instruction destination is required by the current instruction.
	input lc3b_word icache_rdata_MEM_WB,//A this is to check if the previous instruction destination is required by the current instruction.
	input lc3b_control_word control_word_EX_MEM_to_ID_EX,
	input lc3b_reg dest_EX_MEM_to_ID_EX,
	input lc3b_word sr1_out_EX_MEM_to_ID_EX,
	input lc3b_word sr1_out,
	input lc3b_word sr2_out,
	input lc3b_word op2_out,
	input lc3b_reg dest_IF_ID,
	input lc3b_offset11 offset11,
	input lc3b_trapvect8 tv8,
	input lc3b_control_word control_word,
	input branch_enable,//maybe ?? //D see my comments in datapath file
	output lc3b_word sr1_out_ID_EX,
	output lc3b_word sr2_out_ID_EX,
	output lc3b_reg dest_ID_EX,
	output lc3b_word op2_out_ID_EX,
	output lc3b_offset11 offset11_ID_EX, //D need these outputs at this stage to do branch adding
	output lc3b_offset9 offset9_ID_EX, //D
	output lc3b_offset6 offset6_ID_EX,
	output lc3b_imm4 imm4_ID_EX,
	output lc3b_trapvect8 tv8_ID_EX,
	output lc3b_control_word control_word_ID_EX,
	output lc3b_word icache_rdata_ID_EX,
	output logic branch_enable_ID_EX,
	output lc3b_word pc_out_ID_EX

);
lc3b_word sr1_out_int;
lc3b_word sr2_out_int ;
lc3b_word op2_out_int;
lc3b_imm4 imm4_int;
logic branch_enable_int ;
lc3b_control_word control_word_int;
lc3b_word pc_out_int;
lc3b_offset11 offset11_int;
lc3b_offset9 offset9_int;
lc3b_offset6 offset6_int;
lc3b_reg dest_int; //D Need to carry dest along the stages
lc3b_opcode opcode;
logic forwarding_done;
logic done_ldi_sti = 0;// to ensure it doesnt get stuck in the IDEX register

always_ff @(posedge clk)
begin
	if (load)
	begin
		sr1_out_int = sr1_out;
		sr2_out_int = sr2_out;
		op2_out_int = op2_out;
		branch_enable_int = branch_enable;
		icache_rdata_ID_EX = icache_rdata_IF_ID;
		tv8_ID_EX = tv8;
		control_word_int = control_word;
		//A To ensure that the next LDI/STI instruction doesnt by-pass line 73
		if ((control_word_int.opcode == op_ldi || control_word_int.opcode == op_sti) && control_word_EX_MEM_to_ID_EX.opcode != op_ldr ) //D: ?????????why do you check if it's not LDR?
			done_ldi_sti = 0;  //???????? should this really be 0?
		pc_out_int = pc_out_IF_ID;
		offset11_int = offset11;
		offset9_int = offset11[8:0]; 
		offset6_int = offset11[5:0];
		imm4_int = offset11[3:0];
		dest_int = dest_IF_ID; //D Need to carry dest along the stages
		if ((control_word_EX_MEM_to_ID_EX.opcode == op_ldr || control_word_EX_MEM_to_ID_EX.opcode == op_str)/*????????won't always be an ldr*/&& done_ldi_sti != 1)//A need done_ldi to ensure that the next control word in the pipeline is loaded//?????? ok this is just confusing
		begin
			if (control_word_EX_MEM_to_ID_EX.opcode == op_str)
				control_word_int.mem_read = 0;
			control_word_int = control_word_EX_MEM_to_ID_EX;
			dest_int = dest_EX_MEM_to_ID_EX;
			sr1_out_int = sr1_out_EX_MEM_to_ID_EX;
			done_ldi_sti = 1;
		end
		
	end
	
end

always_comb
begin
	// not sure. Does anything go here?
	
	forwarding_done = 0;
	sr1_out_ID_EX = sr1_out_int;
	sr2_out_ID_EX = sr2_out_int;
	op2_out_ID_EX = op2_out_int;
	branch_enable_ID_EX = branch_enable_int;
	control_word_ID_EX = control_word_int;
	opcode = lc3b_opcode'(icache_rdata_EX_MEM[15:12]);
	
	//Check the forwarding conditions ID_EX and EX_MEM - Check these two conditions first- This has priority over the next set of 2 instructions ( This is for a corner case)
	/*if (icache_rdata_ID_EX[8:6] == icache_rdata_EX_MEM[11:9] && icache_rdata_EX_MEM != 0 && icache_rdata_ID_EX != 0  && control_word_EX_MEM_to_ID_EX.opcode != op_ldr  ) //src1 == dest
		begin
			control_word_ID_EX.alu_amux_sel = 1;
			forwarding_done = 1;
		end
	if (icache_rdata_ID_EX[2:0] == icache_rdata_EX_MEM[11:9] && icache_rdata_EX_MEM != 0 && icache_rdata_ID_EX != 0 && control_word_EX_MEM_to_ID_EX.opcode != op_ldr  ) //src2 == dest 
		begin
			control_word_ID_EX.alu_bmux_sel = 2;
			forwarding_done = 1;
		end
		
	//Check the forwarding conditions ID_EX and MEM_WB
   if (icache_rdata_ID_EX[8:6] == icache_rdata_MEM_WB[11:9] && icache_rdata_MEM_WB != 0 && icache_rdata_ID_EX != 0  && forwarding_done == 0 && control_word_EX_MEM_to_ID_EX.opcode != op_ldr  ) //src1 == dest
		control_word_ID_EX.alu_amux_sel = 3;
	if (icache_rdata_ID_EX[2:0] == icache_rdata_MEM_WB[11:9] && icache_rdata_MEM_WB != 0 && icache_rdata_ID_EX != 0  && forwarding_done == 0 && control_word_EX_MEM_to_ID_EX.opcode != op_ldr  ) //src2 == dest 
		control_word_ID_EX.alu_bmux_sel = 3;
*/
	
	
	pc_out_ID_EX = pc_out_int;
	offset11_ID_EX = offset11_int;
	offset9_ID_EX = offset9_int;
	offset6_ID_EX = offset6_int;
	imm4_ID_EX = imm4_int;
	dest_ID_EX = dest_int; 
end

endmodule
