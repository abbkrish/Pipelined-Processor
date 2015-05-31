import lc3b_types::*;

module IF_ID_register (

input clk,
input load,
input lc3b_word pc_out,
input lc3b_word icache_rdata,
input not_stall,
output lc3b_imm4 imm4,
output lc3b_imm5 imm5,
output lc3b_offset6 offset6,
output lc3b_offset11 offset11,
output lc3b_trapvect8 tv8,
output lc3b_reg src1,
output lc3b_reg src2,
output lc3b_reg dest, 
output lc3b_opcode opcode,
output lc3b_word pc_out_IF_ID,
output lc3b_word icache_rdata_IF_ID,
output logic immediate_bit,
output logic jsr_bit,
output logic d_bit_shf,
output logic pc_mem_read
);



lc3b_word pc_out_data;
lc3b_word ir_data; //D : Brandon you forgot to change the icache_datad
/*
lc3b_reg src1_int;
lc3b_reg src2_int;
lc3b_reg dest_int;
lc3b_offset6 offset6_int;
lc3b_offset11 offset11_int;
lc3b_imm4 imm4_int;
lc3b_imm5 imm5_int;	*/

initial 
begin
    pc_out_data = 1'b0;
	ir_data = 1'b0;
	pc_mem_read = 1'b1; //TODO: change this when no longer using magic
end

always_ff @(posedge clk)
begin
    if (load)
    begin
        pc_out_data = pc_out;
		ir_data = icache_rdata;
			icache_rdata_IF_ID = icache_rdata;
			pc_mem_read = 1;

    end
	  if(~not_stall) //For stalling purposes
	 begin
		pc_mem_read = 1'b1;//1'b0;
	 end
	 else
	 begin
		pc_mem_read = 1'b1;
	 end
end

always_comb
begin
    opcode = lc3b_opcode'(ir_data[15:12]);
	 immediate_bit = ir_data[5]; //for ADD and AND
	 d_bit_shf = ir_data[4];
	 jsr_bit = ir_data[11]; //for JSR and JSRR 11 not 10
    src1 = ir_data[8:6];
    src2 = ir_data[2:0];
	 dest = ir_data[11:9]; 
	 offset6 = ir_data[5:0];
	 offset11 = ir_data[10:0];
	 tv8 = ir_data[7:0];
	 imm4 = ir_data[3:0];
	 imm5 = ir_data[4:0];
	 pc_out_IF_ID = pc_out_data;
 
end

endmodule