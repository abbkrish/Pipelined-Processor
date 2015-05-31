library verilog;
use verilog.vl_types.all;
entity dcache is
    port(
        clk             : in     vl_logic;
        dcache_read     : in     vl_logic;
        dcache_write    : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        dcache_address  : in     vl_logic_vector(15 downto 0);
        dcache_wdata    : in     vl_logic_vector(15 downto 0);
        dcache_rdata    : out    vl_logic_vector(15 downto 0);
        dcache_resp     : out    vl_logic;
        L2_resp         : in     vl_logic;
        L2_rdata        : in     vl_logic_vector(127 downto 0);
        L2_read         : out    vl_logic;
        L2_write        : out    vl_logic;
        L2_address      : out    vl_logic_vector(15 downto 0);
        L2_wdata        : out    vl_logic_vector(127 downto 0)
    );
end dcache;
