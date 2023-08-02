module sign (
input logic [15:0] in,

output logic [31:0] out);

always @*

out [31:0] <= { {16{in[15]}},in};

endmodule 