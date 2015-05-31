library verilog;
use verilog.vl_types.all;
entity icache_control is
    port(
        clk             : in     vl_logic;
        lru             : in     vl_logic;
        hit_A           : in     vl_logic;
        hit_B           : in     vl_logic;
        valid_A_dataout : in     vl_logic;
        valid_B_dataout : in     vl_logic;
        valid_A_write   : out    vl_logic;
        valid_B_write   : out    vl_logic;
        valid_A_datain  : out    vl_logic;
        valid_B_datain  : out    vl_logic;
        tag_A_write     : out    vl_logic;
        tag_B_write     : out    vl_logic;
        data_A_write    : out    vl_logic;
        data_B_write    : out    vl_logic;
        lru_datain      : out    vl_logic;
        lru_write       : out    vl_logic;
        icache_read     : in     vl_logic;
        icache_resp     : out    vl_logic;
        L2_resp         : in     vl_logic;
        L2_read         : out    vl_logic
    );
end icache_control;
