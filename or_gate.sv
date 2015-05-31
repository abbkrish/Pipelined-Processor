module or_gate #(parameter width = 1) (
input [width -1: 0] a,
input [width -1: 0] b,
output [width -1: 0] c
);

assign c = a | b;

endmodule
