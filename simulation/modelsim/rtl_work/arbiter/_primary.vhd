library verilog;
use verilog.vl_types.all;
entity arbiter is
    port(
        clk             : in     vl_logic;
        L2inst_rd_req   : in     vl_logic;
        L2inst_address  : in     vl_logic_vector(15 downto 0);
        L2data_rd_req   : in     vl_logic;
        L2data_wr_req   : in     vl_logic;
        L2data_address  : in     vl_logic_vector(15 downto 0);
        L2_resp         : in     vl_logic;
        arb_inst_resp   : out    vl_logic;
        L2_read         : out    vl_logic;
        L2_write        : out    vl_logic;
        arb_data_resp   : out    vl_logic;
        L2_address      : out    vl_logic_vector(15 downto 0)
    );
end arbiter;
