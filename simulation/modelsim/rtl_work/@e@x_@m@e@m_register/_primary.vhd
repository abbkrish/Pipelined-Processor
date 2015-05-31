library verilog;
use verilog.vl_types.all;
library work;
entity EX_MEM_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        control_word_ID_EX: in     work.lc3b_types.lc3b_control_word;
        icache_rdata_ID_EX: in     vl_logic_vector(15 downto 0);
        pc_out_ID_EX    : in     vl_logic_vector(15 downto 0);
        pc_out_EX_MEM   : out    vl_logic_vector(15 downto 0);
        offset11_ID_EX  : in     vl_logic_vector(10 downto 0);
        tv8_ID_EX       : in     vl_logic_vector(7 downto 0);
        offset9_ID_EX   : in     vl_logic_vector(8 downto 0);
        branch_enable   : in     vl_logic;
        br_add_out      : in     vl_logic_vector(15 downto 0);
        alu_out         : in     vl_logic_vector(15 downto 0);
        sr1_out         : in     vl_logic_vector(15 downto 0);
        dest_ID_EX      : in     vl_logic_vector(2 downto 0);
        control_word_EX_MEM_to_ID_EX: out    work.lc3b_types.lc3b_control_word;
        br_add_out_EX_MEM: out    vl_logic_vector(15 downto 0);
        alu_out_EX_MEM  : out    vl_logic_vector(15 downto 0);
        imm4_EX_MEM     : out    vl_logic_vector(3 downto 0);
        tv8_EX_MEM      : out    vl_logic_vector(7 downto 0);
        offset11_EX_MEM : out    vl_logic_vector(10 downto 0);
        offset9_EX_MEM  : out    vl_logic_vector(8 downto 0);
        dest_EX_MEM     : out    vl_logic_vector(2 downto 0);
        dest_EX_MEM_to_ID_EX: out    vl_logic_vector(2 downto 0);
        sr1_out_EX_MEM_to_ID_EX: out    vl_logic_vector(15 downto 0);
        control_word_EX_MEM: out    work.lc3b_types.lc3b_control_word;
        mem_byte_enable_EX_MEM: out    vl_logic_vector(1 downto 0);
        icache_rdata_EX_MEM: out    vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0)
    );
end EX_MEM_register;
