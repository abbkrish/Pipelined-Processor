package lc3b_types;

typedef logic [15:0] lc3b_word;
typedef logic  [7:0] lc3b_byte;

typedef logic  [8:0] lc3b_offset9;
typedef logic  [5:0] lc3b_offset6;

typedef logic  [2:0] lc3b_reg;
typedef logic  [2:0] lc3b_nzp;
typedef logic  [1:0] lc3b_mem_wmask;


/*MP1 stuff*/
typedef logic  [4:0] lc3b_imm5;
typedef logic  [3:0] lc3b_imm4;
typedef logic  [1:0] lc3b_shf;
typedef logic  [7:0] lc3b_trapvect8;
typedef logic 	[10:0] lc3b_offset11;
//END OF MP1


/*MP2 stuff*/
typedef logic [2:0] lc3b_L1_index;
typedef logic [2:0] lc3b_L1_offset;
typedef logic [8:0] lc3b_L1_tag;
typedef logic [127:0] lc3b_L1_line;
typedef enum int unsigned {way1, way2, invalid} lc3b_way;
typedef enum int unsigned {false, true} lc3b_boolean; 

typedef logic [3:0] lc3b_L2_index;
typedef logic [3:0] lc3b_L2_offset;
typedef logic [6:0] lc3b_L2_tag;
typedef logic [255:0] lc3b_L2_line;

typedef enum bit [3:0] {

    op_add  = 4'b0001,
    op_and  = 4'b0101,
    op_br   = 4'b0000,
    op_jmp  = 4'b1100,   /* also RET */
    op_jsr  = 4'b0100,   /* also JSRR */
    op_ldb  = 4'b0010,
    op_ldi  = 4'b1010,
    op_ldr  = 4'b0110,
    op_lea  = 4'b1110,
    op_not  = 4'b1001,
    op_rti  = 4'b1000,
    op_shf  = 4'b1101,
    op_stb  = 4'b0011,
    op_sti  = 4'b1011,
    op_str  = 4'b0111,
    op_trap = 4'b1111
} lc3b_opcode;

typedef enum bit [3:0] {
    alu_add,
    alu_and,
    alu_not,
    alu_pass,
    alu_sll,
    alu_srl,
    alu_sra,
	 alu_trap //to make trap work
} lc3b_aluop;


//PIPELINE stuff
typedef struct packed{
	logic load_pc;
	logic load_IF_ID;
	logic load_ID_EX;
	logic load_EX_MEM;
	logic load_MEM_WB;
	logic wbmux_sel;
	logic load_cc;
	logic mem_read;
	logic memAddr_mux_sel;
	logic mem_write;
	logic load_regfile;
	logic [1:0] brmux_sel;
	logic [2:0] pcmux_sel;
	logic [1:0] storemux_sel;
	logic [1:0] src2mux_sel;
	logic [1:0] regfilemux_sel;
	logic [1:0] alu_bmux_sel;
	logic [2:0] alu_amux_sel;
	logic [2:0] op2_sel;
	lc3b_aluop aluop;
	lc3b_opcode opcode;
	logic bit_A_shf;
	logic bit_D_shf;
	
}lc3b_control_word;

 
endpackage : lc3b_types

