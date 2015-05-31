import lc3b_types::*;

module ir
(
    input clk,
    input load,
    input lc3b_word in,
    output lc3b_opcode opcode,
    output lc3b_reg dest, src1, src2,
    output lc3b_offset6 offset6,
    output lc3b_offset9 offset9,
	 
	 /*MP1 stuff*/
	 output lc3b_imm5 imm5, 
	 output logic add_type,
	 output lc3b_imm4 imm4,
	 output lc3b_shf shf_status,
	 output lc3b_trapvect8 tv8,
	 output lc3b_offset11 offset11,
	 output logic jsr_type
);

lc3b_word data;

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data = in;
    end
end

always_comb
begin
    opcode = lc3b_opcode'(data[15:12]);

    dest = data[11:9];
    src1 = data[8:6];
    src2 = data[2:0];
	
    offset6 = data[5:0];
    offset9 = data[8:0];
	 
	 //MP1 changes
	 add_type = data[5:5];
	 imm5 = data[4:0];
	 imm4 = data[3:0];
	 shf_status[0] = data[4];
	 shf_status[1] = data[5];
	 tv8 = data[7:0];
	 offset11 = data[10:0];
	 jsr_type = data[11];
	 
end

endmodule : ir
