library verilog;
use verilog.vl_types.all;
entity word_replacer is
    port(
        mem_address     : in     vl_logic_vector(15 downto 0);
        byte_enable     : in     vl_logic_vector(1 downto 0);
        data_block      : in     vl_logic_vector(127 downto 0);
        data_word       : in     vl_logic_vector(15 downto 0);
        enable          : in     vl_logic;
        data_out        : out    vl_logic_vector(127 downto 0)
    );
end word_replacer;
