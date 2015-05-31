library verilog;
use verilog.vl_types.all;
entity icache is
    port(
        clk             : in     vl_logic;
        icache_read     : in     vl_logic;
        icache_address  : in     vl_logic_vector(15 downto 0);
        icache_rdata    : out    vl_logic_vector(15 downto 0);
        icache_resp     : out    vl_logic;
        L2_resp         : in     vl_logic;
        L2_rdata        : in     vl_logic_vector(127 downto 0);
        L2_read         : out    vl_logic;
        L2_address      : out    vl_logic_vector(15 downto 0)
    );
end icache;
