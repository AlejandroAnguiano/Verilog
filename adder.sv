module adder (
input [31:0] A,
input [31:0] B,
output [31:0] result);

assign result = A +B ;

endmodule 


//adder ad1(.A(PC),.B({'0,0100})