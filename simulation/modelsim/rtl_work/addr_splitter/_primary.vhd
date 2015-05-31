library verilog;
use verilog.vl_types.all;
entity addr_splitter is
    port(
        mem_address     : in     vl_logic_vector(15 downto 0);
        tag             : out    vl_logic_vector(8 downto 0);
        set             : out    vl_logic_vector(2 downto 0);
        offset          : out    vl_logic_vector(2 downto 0);
        last_bit        : out    vl_logic
    );
end addr_splitter;
