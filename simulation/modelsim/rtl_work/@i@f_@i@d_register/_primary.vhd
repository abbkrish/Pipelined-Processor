library verilog;
use verilog.vl_types.all;
library work;
entity IF_ID_register is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        pc_out          : in     vl_logic_vector(15 downto 0);
        icache_rdata    : in     vl_logic_vector(15 downto 0);
        not_stall       : in     vl_logic;
        imm4            : out    vl_logic_vector(3 downto 0);
        imm5            : out    vl_logic_vector(4 downto 0);
        offset6         : out    vl_logic_vector(5 downto 0);
        offset11        : out    vl_logic_vector(10 downto 0);
        tv8             : out    vl_logic_vector(7 downto 0);
        src1            : out    vl_logic_vector(2 downto 0);
        src2            : out    vl_logic_vector(2 downto 0);
        dest            : out    vl_logic_vector(2 downto 0);
        opcode          : out    work.lc3b_types.lc3b_opcode;
        pc_out_IF_ID    : out    vl_logic_vector(15 downto 0);
        icache_rdata_IF_ID: out    vl_logic_vector(15 downto 0);
        immediate_bit   : out    vl_logic;
        jsr_bit         : out    vl_logic;
        d_bit_shf       : out    vl_logic;
        pc_mem_read     : out    vl_logic
    );
end IF_ID_register;
