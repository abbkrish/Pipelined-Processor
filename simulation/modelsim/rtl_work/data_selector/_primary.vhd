library verilog;
use verilog.vl_types.all;
entity data_selector is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        f               : out    vl_logic
    );
end data_selector;
