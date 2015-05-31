import lc3b_types::*;

module pipeline_datapath (
/* B: commented some unnecessary stuff out here */
	input clk,
	input icache_resp,
	input lc3b_word icache_rdata,
	input lc3b_word dcache_rdata,
	output logic icache_read,
	//output logic mem_write_a,
	//output lc3b_word mem_wdata_a,
	output lc3b_word icache_address,
	//output lc3b_mem_wmask mem_byte_enable_a,
	input dcache_resp,
	output logic dcache_read,
	output logic dcache_write,
	output lc3b_word dcache_wdata,
	output lc3b_word dcache_address,
	output lc3b_mem_wmask mem_byte_enable // This is for dcache only

);



/*IF ID output data*/
lc3b_imm4 imm4;
lc3b_imm5 imm5;
lc3b_offset6 offset6;
lc3b_offset11 offset11;
lc3b_trapvect8 tv8;
lc3b_reg src1_IF_ID;
lc3b_reg src2_IF_ID;
lc3b_opcode opcode;
lc3b_word pc_out_IF_ID;
lc3b_word mem_wdata_IF_ID; //D unsure if needed
lc3b_word icache_rdata_IF_ID;
logic pc_mem_read;
logic immediate_bit;//AND and ADD immediate
logic jsr_bit; //for JSR and JSRR
/*IF ID output */

//StoreMux 
lc3b_reg r7 = 3'b111;
lc3b_reg storemux_out;

//SRC2 Mux
lc3b_reg src2mux_out;


//Control Rom Ouput
lc3b_control_word control_word;

//PCPlus2
lc3b_word pc_plus2_out;


//BRADD
lc3b_word br_add_out;
lc3b_word br_add_out_EX_MEM; //for coming out of EX_MEM reg

//PC
lc3b_word pc_out;


//TV8
lc3b_word tv8_int;

//PCMux
lc3b_word pcmux_out;

//GENCC
lc3b_nzp gencc_out;

//CC
lc3b_reg cc_out;
logic branch_enable;

//Regfilemux
lc3b_word regfilemux_out;

//Regfile
//lc3b_reg src2; //D remove cuzget src2 straight from IF_ID
lc3b_word sr1_out;
lc3b_word sr2_out;
lc3b_reg dest_IF_ID; //D see regfile for change explanation
lc3b_reg dest_ID_EX; 
lc3b_reg dest;

/*ID EX Register*/
lc3b_word pc_out_ID_EX;
lc3b_word sr1_out_ID_EX;
lc3b_word sr2_out_ID_EX;
lc3b_word op2_out_ID_EX;
lc3b_control_word control_word_ID_EX; //D only need out suffix when it was originally coming out of something (sr1_out is the sr1 output of the regfile) we can assume if it ends with a stage it came out of that reg
lc3b_word op2_out;
lc3b_offset11 offset11_ID_EX; //D offset outputs from ID-EX (need these outputs at this stage for brAdder)
lc3b_offset9 offset9_ID_EX; //D 
lc3b_offset6 offset6_ID_EX;
lc3b_word mem_wdata_ID_EX; //D unsure if needed
lc3b_word icache_rdata_ID_EX;
lc3b_trapvect8 tv8_ID_EX;
logic branch_enable_ID_EX;
lc3b_imm4 imm4_ID_EX;
/* ID EX*/

/* ALU muxes */
logic alu_amux_sel;
lc3b_word alu_amux_out;
logic [1:0] alu_bmux_sel;
lc3b_word alu_bmux_out;

/* ALU */
lc3b_word alu_out;
lc3b_aluop aluop;

/* Branch Mux */
logic [1:0] brmux_sel;
lc3b_word brmux_out;

/* ADJs */
lc3b_word adj11_out;
lc3b_word adj9_out;
lc3b_word adj6_out; //D

//TV 8
lc3b_word tv8_out; //should be a word to avoid connectivity issues

/*EX MEM Register*/
lc3b_word alu_out_EX_MEM; //what is this again? Please make it consistent with the current naming convention. -Brandon //D: I changed ex_memout to this because it's more descriptive
lc3b_reg dest_EX_MEM;
lc3b_word mem_wdata_EX_MEM; //D unsure if needed
lc3b_control_word control_word_EX_MEM;
lc3b_word pc_out_EX_MEM;
lc3b_offset9 offset9_EX_MEM;
lc3b_offset11 offset11_EX_MEM;
lc3b_word icache_rdata_EX_MEM;
lc3b_trapvect8 tv8_EX_MEM;
lc3b_imm4 imm4_EX_MEM;
lc3b_word sr1_out_EX_MEM_to_ID_EX;
logic [1:0] mem_byte_enable_EX_MEM;
/*EX MEM*/

//after EX MEM
logic load_MEM_WB;

/*Mem WB*/
lc3b_word alu_out_MEM_WB;
lc3b_reg dest_MEM_WB;
lc3b_control_word control_word_MEM_WB;
lc3b_word dcache_rdata_MEM_WB;
lc3b_word icache_rdata_MEM_WB;
lc3b_word pc_out_MEM_WB;
/*MEM WB*/ 

//wb mux
lc3b_word wbmux_out;

//for LDI instruction
lc3b_control_word control_word_EX_MEM_to_ID_EX;
lc3b_reg dest_EX_MEM_to_ID_EX;

//Sign Extend
lc3b_word sext5_out;
lc3b_word sext4_out;
lc3b_word sext6_out;

//SHF
lc3b_word shifted_sr1_out;

//MEM_BYTE_ENABLE's
//assign mem_byte_enable_a = 2'b11; //B: Don't need this since it's icache (we don't need to write bytes or anything like that.)
assign mem_byte_enable = mem_byte_enable_EX_MEM; //TODO: GET rid of this after the first checkpoint cuz shouldn't always be 11

//Stalling logic
logic not_stall;
logic load_EX_MEM;

/*
	mem_Address mux
	the mux determines which value is put into memory_address
	pc_plus2_out - pc_plus2_out
	alu_out_EX_MEM - alu_out
*/
/* Don't need this now that we have two ports
mux2 memAddr_mux
(
	.sel(control_word.memAddr_mux_sel),
	.a(pc_plus2_out),
	.b(alu_out_EX_MEM),
	.f(mem_address)
);*/

/*PC Mux
Input: pmuxsel from Control word
Output: pcmux_out to PC 
*/
mux8 pcmux (
	 .sel(control_word_EX_MEM.pcmux_sel),
    .a(pc_plus2_out),
    .b(br_add_out),
	 .c(alu_out_EX_MEM),//A For jmp and RET set alu_op = alu_pass so alu_out = sr1_out //A Also for JSRR
	 .d(dcache_rdata), //TODO: Used for trap, please check late, D:checked, lets see if it works
	 .e(pc_out),//for LDI send it twice (2 LDR's effectively
	 .f(16'b0),
	 .g(16'b0),
	 .h(16'b0),
	 .out(pcmux_out)
);

assign not_stall = (dcache_resp & icache_resp) | (icache_resp & ~(dcache_read | dcache_write)); //(dcache_resp | icache_resp/*~(dcache_read | dcache_write)*/); //Confusing name on my part, if high we're NOT stalling


/*PC Register 
	
	load-load_pc
	in - pcmux_out
	out - pc_out (to Plus2 and IF_ID register)
*/
register pc
(
    .clk(clk),
    //.load(1'b1),
	 .load(not_stall),
    .in(pcmux_out),
    .out(pc_out)
);


/*Plus2
Input: pc_out from PC register
Output: pc_plus2_out to PCMUX
*/
plus2 Plus2 
(
	.in(pc_out),
	.out(pc_plus2_out)
);


/*IF-ID register (Checkpoint 1)
	
	load-load_ir
	in - pc_out(16bits) + icache_rdata(16 bits) 
	out - imm4, imm5, offset6, opcode, src1, src2 
*/
IF_ID_register IF_ID( 

	.clk(clk),
	.load(/*icache_resp imma fool*/not_stall),
	.pc_out(pc_plus2_out),
	.icache_rdata(icache_rdata),
	.imm4(imm4),
	.imm5(imm5),
	.not_stall(not_stall),
	.offset6(offset6),
	.offset11(offset11),
	.tv8(tv8),
	.opcode(opcode),
	.src1(src1_IF_ID),
	.src2(src2_IF_ID),  //D TODO: PUT IR[5:3] for when implement LC3x
	.dest(dest_IF_ID),
	.pc_mem_read(pc_mem_read),
	.icache_rdata_IF_ID(icache_rdata_IF_ID),
	.immediate_bit(immediate_bit),
	.jsr_bit(jsr_bit),
	.d_bit_shf(d_bit_shf),
	.pc_out_IF_ID(pc_out_IF_ID)
);

assign icache_read = pc_mem_read;

/*Storemux
	
	Input: storemux_sel from control word
	Output: 0-> src1 1-> dest 2-> r7 3->Dont care (for now) 
	Output goes to regfile	
 
 */
mux4 #(.width(3)) storemux 
(
	.sel(control_word.storemux_sel),
	.a(src1_IF_ID),
	.b(dest_IF_ID), //D: don't need because already dealt with dest   //A:   Need it for STR since src is now dest
	.c(r7),
	.d(3'b000),
	.f(storemux_out)
);


/* SRC2Mux select 

input : src2mux_sel from control_word 
Output: 0- src2 -1 - sr1 (for  cases of Store instructions)
Output goes to regfile

*/

mux4 #(.width(3)) src2mux
(
	.sel(control_word.src2mux_sel),
	.a(src2_IF_ID),
	.b(src1_IF_ID), //A: This seems weird but other  than expanding the regfile, I couldnt  think of anything else
	.c(3'b0),
	.d(3'b0),
	.f(src2mux_out)

);

/*Regfile Mux

	Input: regfilemux_sel from Control Word
	Output: regfilemux_out to regfile and gencc
*/

mux4 regfilemux
(
	.sel(control_word_MEM_WB.regfilemux_sel),
	.a(wbmux_out), 
	.b(br_add_out),
	.c(pc_out_MEM_WB),//for JSR & JSRR
	.d(16'b0),
	.f(regfilemux_out)
);

/*Regfile
	
	Input: load_regile from Control_word
	Output: reg_a, reg_b goes to ID_EX register 
 
 */
regfile regfile
(
	.clk(clk),
	.load(control_word_MEM_WB.load_regfile), //D: Ok to use 
	.in(regfilemux_out),
	.src_a(storemux_out),
	.src_b(src2mux_out), //D originally sr2, should be src2 cuz we need to be consistent
	.dest(dest_MEM_WB), //D, I changed dest_reg_out to this. it's an input that selects the dest and comes out of if-id
	.reg_a(sr1_out),
	.reg_b(sr2_out)
);


/*Control_Rom
	Input: opcode from IF-ID register
	ouput: control_word
*/
control_rom controlRom (
	.opcode(opcode),
	.control_word(control_word),
	.immediate_bit(immediate_bit),
	.d_bit_shf(d_bit_shf),
	.jsr_bit(jsr_bit)
);

/*CC register

holds current condition code
*/
register #(.width(3)) CC
(
	.clk(clk),
	.load(control_word_MEM_WB.load_cc),
	.in(gencc_out),
	.out(cc_out)
);


/*GENCC

generates condition code
*/
gencc GENCC
(
	.in(regfilemux_out),
	.out(gencc_out)
);

/*CCCOMP
	
	Input: dest register, cc_out
	Output: branch_enable 

*/
cccomp CCCOMP
(
	.a(dest_ID_EX), //D should be IDEX ???because  want to look at what the branch wants
	.cc(cc_out),
	.branch_enable(branch_enable) //D: doesn't go anywhere

);

//Sign extend immediate5
signextend #(.width(5)) SEXT5
(
	.in(imm5),
	.out(sext5_out)
);

//sign extend offset6
signextend #(.width(6)) SEXT6
(
	.in(offset6),
	.out(sext6_out)
);

//Sign extend immediate4
signextend #(.width(4)) SEXT4
(
	.in(imm4),
	.out(sext4_out) //D
);

//adjust (sext<<1) offset6 //D - FOr loads PC + (SEXT(IR[5:0] << 1)
adj #(.width(6)) adj6 
(
	.in(offset6),
	.out(adj6_out)
);
//zroext(tv8) for trap
zeroextShift #(.width(8)) zx8_trap
(
	//.in(tv8_EX_MEM), might be a reason why it's in the ex_mem step, but Idk whyand it doesn't actually take trap, imo should be from IF-ID step
	.in(tv8),
	.out(tv8_out)
);

//adj tv8 no need, created zeroext shift because adj sexts (don't want to sext)
/*adj #(.width(16)) adjtv8
(
	.in(tv8_int),
	.out(tv8_out)
);*/


//SHF module
shift sh16
(
	.in(alu_out_EX_MEM),
	.imm4(imm4_EX_MEM),//should come from EX MEM reg for next CP
	.status({control_word_EX_MEM.bit_A_shf, control_word_EX_MEM.bit_D_shf}),//should come from EX MEM reg for next CP
	.out(shifted_sr1_out)
);

/*OP2Mux (alu operand2 mux)
	Input: imm4, off, imm5 sext
	output: op2_out to ID_EX
*/
mux8 OP2Mux( //D
	.sel(control_word.op2_sel),
	.a(16'b0),
	.b(sext4_out),
	.c(sext5_out),
	.d(sext6_out), 
	.e(pc_out_IF_ID),
	.f(adj6_out),//For load op2mux = 5  and store  too. 
 	.g(tv8_out),
	.h(16'b0),
	.out(op2_out)

);

logic load_ID_EX; // B: quartus complained about implicit net, so I put this here
assign load_ID_EX = not_stall & control_word.load_ID_EX;

/*ID_EX Register

Input: load_ID_EX from control word
		pc_out_IF_ID from IF_ID_register
		
		input lc3b_word pc_out_IF_ID,
	input lc3b_word sr1_out,
	input lc3b_word sr2_out,
	input lc3b_word op2_out,
	input lc3b_offset11 offset11,
	input lc3b_control_word control_word,
	input branch_enable,//maybe ??
	input dest_IF_ID 
Output: SR1_OUT to alu_a_mux,
		  sr2_out to alu_b_mux, 
		  op2_out to alu_b_mux,
		  	output lc3b_word dest_ID_EX,
			control_word_IDEXOut to EX_MEM
			
*/
ID_EX_register ID_EX (

	.clk(clk),
	//.load(control_word.load_ID_EX),
	.load(load_ID_EX),
	.pc_out_IF_ID(pc_out_IF_ID),
	.icache_rdata_IF_ID(icache_rdata_IF_ID),
	.icache_rdata_EX_MEM(icache_rdata_EX_MEM),
	.icache_rdata_MEM_WB(icache_rdata_MEM_WB),
	.control_word_EX_MEM_to_ID_EX(control_word_EX_MEM_to_ID_EX),
	.dest_EX_MEM_to_ID_EX(dest_EX_MEM_to_ID_EX),
	.sr1_out_EX_MEM_to_ID_EX(sr1_out_EX_MEM_to_ID_EX),
	.sr1_out(sr1_out),
	.sr2_out(sr2_out),
	.op2_out(op2_out),
	.offset11(offset11),
	.tv8(tv8),
	.control_word(control_word),
	.branch_enable(branch_enable), //D I thought you determine branch_enable at this step. Therefore it would only cause confusion to put this here
	.sr1_out_ID_EX(sr1_out_ID_EX),
	.sr2_out_ID_EX(sr2_out_ID_EX),
	.op2_out_ID_EX(op2_out_ID_EX),
	.offset11_ID_EX(offset11_ID_EX), //D we need this because offset9 and offset11 come straight from the ID-EX stage
	.offset9_ID_EX(offset9_ID_EX), //D
	.offset6_ID_EX(offset6_ID_EX),
	.imm4_ID_EX(imm4_ID_EX),
	.tv8_ID_EX(tv8_ID_EX),
	.dest_IF_ID(dest_IF_ID),
	.dest_ID_EX(dest_ID_EX),
	.icache_rdata_ID_EX(icache_rdata_ID_EX),
	.branch_enable_ID_EX(branch_enable_ID_EX),
	.control_word_ID_EX(control_word_ID_EX),
	.pc_out_ID_EX(pc_out_ID_EX)

);



/* alu_a mux
	Input:  sel - comes from control word
			a - first source register data
			b - forwarded output from ALU
			
	Output:	f - first input to ALU
*/
mux8 #(.width(16)) alu_amux(
	.sel(control_word_ID_EX.alu_amux_sel), //D comes from control word
	.a(sr1_out_ID_EX), 
	.b(alu_out_EX_MEM),// for forwarding ID_EX && EX_MEM
	.c(sr2_out_ID_EX),//for STR instructions only
	.d(alu_out_MEM_WB),// for forwarding ID_EX && MEM_WB
	.e(dcache_rdata_MEM_WB),//for LDI - this is passed through the ALU
	.f(16'b0),
	.g(16'b0),
	.h(16'b0),
	.out(alu_amux_out)
);

/* alu_b mux
	Input:	sel - comes from control word
			a - the second source register data
			b - an immediate/offset value
			c - the output from ALU (for forwarding)
			d - nothing (yet...)
	Output: f - second input to ALU 
*/
mux4 #(.width(16)) alu_bmux(
	.sel(control_word_ID_EX.alu_bmux_sel), //D comes from control word
	.a(sr2_out_ID_EX),
	.b(op2_out_ID_EX),
	.c(alu_out_EX_MEM),		//for forwarding ID_EX && EX_MEM
	.d(alu_out_MEM_WB),//for forwarding ID_EX && EX_MEM
	.f(alu_bmux_out)
);


/* ALU
	Input: 	aluop - The alu operation to perform (comes from control word)
			a - either the first source register or the forwarded output from ALU
			b - either the second source register, an immediate value/offset, or forwarded output from ALU			
	Output: Whatever you tell it do compute, mate.
*/
/* HOLD ON wouldn't forwarding stuff need to be put in a register or something? // A: yeah..so I redirected the alu_out_EX_MEM To the 2 muxes
	It just seems off, looking at the datapath. Muxes and ALUs can compute things immediately, right?
*/
alu ALU(
	.aluop(control_word_ID_EX.aluop),
	.a(alu_amux_out),
	.b(alu_bmux_out),
	.f(alu_out)
);

assign load_EX_MEM = control_word_ID_EX.load_EX_MEM & not_stall;
/* EX_MEM Register

//D
Input: 
	Start store things in memory/regfile and finish instruction which means we need the following:
	br_add_out - use branch adder output at this stage
	alu_out - result from alu
	sr1_out - this is in our design, but I don't really know why it's needed //D
	dest_ID_EX -need to carry dest along becaue you need at this stage
	control_word_ID_EX - control word from previous step
	Output:
	br_add_out_EX_MEM- use this at this stage
	alu_out_EX_MEM - use alu output at this stage //Don't think this is needed
	dest_EX_MEM - use dest value at this stage
	mem_wdata - data written to mem
	eff_addr - effective address from the ALU
	control_word_EX_MEM - the control word for the next stage
	
*/
EX_MEM_register EX_MEM
(
	.clk(clk),
	.load(load_EX_MEM),
	.br_add_out(br_add_out),
	.offset9_ID_EX(offset9_ID_EX),
	.pc_out_ID_EX(pc_out_ID_EX),
	.icache_rdata_ID_EX(icache_rdata_ID_EX),
	.control_word_EX_MEM_to_ID_EX(control_word_EX_MEM_to_ID_EX),
	.sr1_out_EX_MEM_to_ID_EX(sr1_out_EX_MEM_to_ID_EX),
	.offset11_ID_EX(offset11_ID_EX),
	.tv8_ID_EX(tv8_ID_EX),
	.alu_out(alu_out),
	.sr1_out(sr1_out_ID_EX),
	.dest_ID_EX(dest_ID_EX),
	.offset9_EX_MEM(offset9_EX_MEM),
	.offset11_EX_MEM(offset11_EX_MEM),
	.imm4_EX_MEM(imm4_EX_MEM),
	.control_word_ID_EX(control_word_ID_EX),
	.br_add_out_EX_MEM(br_add_out_EX_MEM),
	.tv8_EX_MEM(tv8_EX_MEM),
	.alu_out_EX_MEM(alu_out_EX_MEM),
	.dest_EX_MEM(dest_EX_MEM),
	.dest_EX_MEM_to_ID_EX(dest_EX_MEM_to_ID_EX),
	.pc_out_EX_MEM(pc_out_EX_MEM),
	.branch_enable(branch_enable),
	.icache_rdata_EX_MEM(icache_rdata_EX_MEM),
	.mem_wdata(mem_wdata_EX_MEM), //D: direct input, so need to carry this the whole time
	.mem_byte_enable_EX_MEM(mem_byte_enable_EX_MEM),
	.control_word_EX_MEM(control_word_EX_MEM)
);

adj #(.width(11)) ADJ11(
	.in(offset11_EX_MEM), //D don't use plain old offset11 because need one from ID-EX stage
	.out(adj11_out)
);

adj #(.width(9)) ADJ9(
	.in(offset9_EX_MEM), //D don't use plain old offset9 because need one from ID-EX stage
	.out(adj9_out)
);

/* Branch Mux
	Input: brmux_sel from control word
			PC Offset - either adj11 or adj9
			SOMETHING ELSE? - not sure yet
	Output: goes to branch adder for new address in case of branch
 */
mux4 #(.width(16)) brmux(
	.sel(control_word_EX_MEM.brmux_sel), //D once again, this should come from the control word
	.a(adj9_out),			// I DON'T KNOW WHAT GOES HERE (trapvect, right?) -Brandon //D: NOTHING,the only reason this is here is cuz I goofed up the design 
	.b(adj11_out),
	.c(16'b0),
	.d(16'b0),
	.f(brmux_out)
);

/*
	Branch adder
	Input:
	pc_out_ID_EX - the pc you need to add to for branches
	offset - the offset you add to the pc for the branch
	
	Output:
	br_add_out -output of the adder
	

*/

branchAdder br_add (

	.pc(pc_out_EX_MEM),
	.offset(brmux_out),
	.targetAddr(br_add_out)
);

assign dcache_wdata = mem_wdata_EX_MEM; //D: Is this right? don't think we need this for anything else
assign dcache_address = alu_out_EX_MEM;
assign icache_address = pc_out; //changed this as it was skipping the first instructiuon
assign dcache_read = control_word_EX_MEM.mem_read ;//D: activating mem_read and mem_write at this stage

assign dcache_write = control_word_EX_MEM.mem_write;

assign load_MEM_WB = not_stall;//((dcache_resp | ~(dcache_read | dcache_write))); //D: load_MEM_WB is set high when mem_resp is high or it's a alu instruction

MEM_WB_register MEM_WB
(

	.clk(clk),
	.load(load_MEM_WB),
	.br_add_out(br_add_out),//A for LEA
	.shifted_sr1_out(shifted_sr1_out),//A for SHF 
	.pc_in(pc_out_EX_MEM),
	.alu_out_EX_MEM(alu_out_EX_MEM),
	.icache_rdata_EX_MEM(icache_rdata_EX_MEM),
	.dcache_rdata(dcache_rdata),
	.dest_EX_MEM(dest_EX_MEM),
	.control_word_EX_MEM(control_word_EX_MEM),
	.alu_out_MEM_WB(alu_out_MEM_WB),
	.pc_out_MEM_WB(pc_out_MEM_WB),
	.dest_MEM_WB(dest_MEM_WB),
	.control_word_MEM_WB(control_word_MEM_WB),
	.dcache_rdata_MEM_WB(dcache_rdata_MEM_WB) ,
	.icache_rdata_MEM_WB(icache_rdata_MEM_WB)


);

mux2 wbmux
(
	.sel(control_word_MEM_WB.wbmux_sel),
	.a(alu_out_MEM_WB),
	.b(dcache_rdata_MEM_WB),
	.f(wbmux_out)
);

endmodule : pipeline_datapath
