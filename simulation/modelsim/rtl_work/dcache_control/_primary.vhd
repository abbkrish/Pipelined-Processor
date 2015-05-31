library verilog;
use verilog.vl_types.all;
entity dcache_control is
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
        dirty_A_dataout : in     vl_logic;
        dirty_B_dataout : in     vl_logic;
        dirty_A_write   : out    vl_logic;
        dirty_B_write   : out    vl_logic;
        dirty_A_datain  : out    vl_logic;
        dirty_B_datain  : out    vl_logic;
        tag_A_write     : out    vl_logic;
        tag_B_write     : out    vl_logic;
        data_A_write    : out    vl_logic;
        data_B_write    : out    vl_logic;
        lru_datain      : out    vl_logic;
        lru_write       : out    vl_logic;
        replacemux_sel  : out    vl_logic;
        dcache_write    : in     vl_logic;
        dcache_read     : in     vl_logic;
        dcache_resp     : out    vl_logic;
        L2_resp         : in     vl_logic;
        L2_write        : out    vl_logic;
        L2_read         : out    vl_logic;
        pmemaddressmux_sel: out    vl_logic
    );
end dcache_control;
