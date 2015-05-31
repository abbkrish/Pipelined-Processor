library verilog;
use verilog.vl_types.all;
entity shift is
    generic(
        width           : integer := 16
    );
    port(
        \in\            : in     vl_logic_vector;
        imm4            : in     vl_logic_vector(3 downto 0);
        status          : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end shift;
