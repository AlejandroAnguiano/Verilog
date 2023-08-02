module shift_r #(parameter S= 32)(
input logic [S-1:0] in,
output logic [S-1:0] out );

assign out = {'0,in[S-1:2]};
endmodule 
