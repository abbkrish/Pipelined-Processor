library verilog;
use verilog.vl_types.all;
library work;
entity ID_EX_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        pc_out_IF_ID    : in     vl_logic_vector(15 downto 0);
        icache_rdata_IF_ID: in     vl_logic_vector(15 downto 0);
        icache_rdata_EX_MEM: in     vl_logic_vector(15 downto 0);
        icache_rdata_MEM_WB: in     vl_logic_vector(15 downto 0);
        control_word_EX_MEM_to_ID_EX: in     work.lc3b_types.lc3b_control_word;
        dest_EX_MEM_to_ID_EX: in     vl_logic_vector(2 downto 0);
        sr1_out_EX_MEM_to_ID_EX: in     vl_logic_vector(15 downto 0);
        sr1_out         : in     vl_logic_vector(15 downto 0);
        sr2_out         : in     vl_logic_vector(15 downto 0);
        op2_out         : in     vl_logic_vector(15 downto 0);
        dest_IF_ID      : in     vl_logic_vector(2 downto 0);
        offset11        : in     vl_logic_vector(10 downto 0);
        tv8             : in     vl_logic_vector(7 downto 0);
        control_word    : in     work.lc3b_types.lc3b_control_word;
        branch_enable   : in     vl_logic;
        sr1_out_ID_EX   : out    vl_logic_vector(15 downto 0);
        sr2_out_ID_EX   : out    vl_logic_vector(15 downto 0);
        dest_ID_EX      : out    vl_logic_vector(2 downto 0);
        op2_out_ID_EX   : out    vl_logic_vector(15 downto 0);
        offset11_ID_EX  : out    vl_logic_vector(10 downto 0);
        offset9_ID_EX   : out    vl_logic_vector(8 downto 0);
        offset6_ID_EX   : out    vl_logic_vector(5 downto 0);
        imm4_ID_EX      : out    vl_logic_vector(3 downto 0);
        tv8_ID_EX       : out    vl_logic_vector(7 downto 0);
        control_word_ID_EX: out    work.lc3b_types.lc3b_control_word;
        icache_rdata_ID_EX: out    vl_logic_vector(15 downto 0);
        branch_enable_ID_EX: out    vl_logic;
        pc_out_ID_EX    : out    vl_logic_vector(15 downto 0)
    );
end ID_EX_register;
