library verilog;
use verilog.vl_types.all;
library work;
entity control_rom is
    port(
        opcode          : in     work.lc3b_types.lc3b_opcode;
        control_word    : out    work.lc3b_types.lc3b_control_word;
        immediate_bit   : in     vl_logic;
        d_bit_shf       : in     vl_logic;
        jsr_bit         : in     vl_logic
    );
end control_rom;
