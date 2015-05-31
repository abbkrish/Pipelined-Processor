library verilog;
use verilog.vl_types.all;
entity icache_datapath is
    port(
        clk             : in     vl_logic;
        hit_A           : out    vl_logic;
        hit_B           : out    vl_logic;
        valid_A_write   : in     vl_logic;
        valid_B_write   : in     vl_logic;
        tag_A_write     : in     vl_logic;
        tag_B_write     : in     vl_logic;
        data_A_write    : in     vl_logic;
        data_B_write    : in     vl_logic;
        lru_write       : in     vl_logic;
        valid_A_datain  : in     vl_logic;
        valid_B_datain  : in     vl_logic;
        lru_datain      : in     vl_logic;
        valid_A_dataout : out    vl_logic;
        valid_B_dataout : out    vl_logic;
        lru_dataout     : out    vl_logic;
        icache_address  : in     vl_logic_vector(15 downto 0);
        L2_rdata        : in     vl_logic_vector(127 downto 0);
        icache_rdata    : out    vl_logic_vector(15 downto 0);
        L2_address      : out    vl_logic_vector(15 downto 0)
    );
end icache_datapath;
