library verilog;
use verilog.vl_types.all;
entity cache_hierarchy is
    port(
        clk             : in     vl_logic;
        icache_read     : in     vl_logic;
        icache_address  : in     vl_logic_vector(15 downto 0);
        icache_rdata    : out    vl_logic_vector(15 downto 0);
        icache_resp     : out    vl_logic;
        dcache_read     : in     vl_logic;
        dcache_write    : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        dcache_address  : in     vl_logic_vector(15 downto 0);
        dcache_wdata    : in     vl_logic_vector(15 downto 0);
        dcache_rdata    : out    vl_logic_vector(15 downto 0);
        dcache_resp     : out    vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic;
        pmem_address    : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0);
        pmem_resp       : in     vl_logic;
        pmem_rdata      : in     vl_logic_vector(127 downto 0)
    );
end cache_hierarchy;
