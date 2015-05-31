library verilog;
use verilog.vl_types.all;
entity pipeline_datapath is
    port(
        clk             : in     vl_logic;
        icache_resp     : in     vl_logic;
        icache_rdata    : in     vl_logic_vector(15 downto 0);
        dcache_rdata    : in     vl_logic_vector(15 downto 0);
        icache_read     : out    vl_logic;
        icache_address  : out    vl_logic_vector(15 downto 0);
        dcache_resp     : in     vl_logic;
        dcache_read     : out    vl_logic;
        dcache_write    : out    vl_logic;
        dcache_wdata    : out    vl_logic_vector(15 downto 0);
        dcache_address  : out    vl_logic_vector(15 downto 0);
        mem_byte_enable : out    vl_logic_vector(1 downto 0)
    );
end pipeline_datapath;
