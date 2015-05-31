library verilog;
use verilog.vl_types.all;
entity branchAdder is
    generic(
        width           : integer := 16
    );
    port(
        pc              : in     vl_logic_vector;
        offset          : in     vl_logic_vector;
        targetAddr      : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end branchAdder;
