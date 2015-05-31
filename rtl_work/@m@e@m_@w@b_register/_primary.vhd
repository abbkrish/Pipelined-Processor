library verilog;
use verilog.vl_types.all;
library work;
entity MEM_WB_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        alu_out_EX_MEM  : in     vl_logic_vector(15 downto 0);
        pc_in           : in     vl_logic_vector(15 downto 0);
        shifted_sr1_out : in     vl_logic_vector(15 downto 0);
        br_add_out      : in     vl_logic_vector(15 downto 0);
        icache_rdata_EX_MEM: in     vl_logic_vector(15 downto 0);
        dcache_rdata    : in     vl_logic_vector(15 downto 0);
        dest_EX_MEM     : in     vl_logic_vector(2 downto 0);
        control_word_EX_MEM: in     work.lc3b_types.lc3b_control_word;
        alu_out_MEM_WB  : out    vl_logic_vector(15 downto 0);
        dest_MEM_WB     : out    vl_logic_vector(2 downto 0);
        control_word_MEM_WB: out    work.lc3b_types.lc3b_control_word;
        pc_out_MEM_WB   : out    vl_logic_vector(15 downto 0);
        dcache_rdata_MEM_WB: out    vl_logic_vector(15 downto 0);
        icache_rdata_MEM_WB: out    vl_logic_vector(15 downto 0)
    );
end MEM_WB_register;
