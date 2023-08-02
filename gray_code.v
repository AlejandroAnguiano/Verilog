module gray_code( clk,q, reset, qgray);
input clk;
input reset;
output reg [3:0] qgray;
input[3:0] q;
/*
always @(negedge reset or posedge clk)
if (!reset)
qgray <= 0;
else
q <= q + 1;
assign qgray = {q[3], ^q[3:2], ^q[2:1], ^q[1:0]};
endmodule 
*/
always @(negedge reset or posedge clk)
if (!reset)
qgray <= 0;
else
case (q)
3'b000: qgray <= 3'b000;
3'b001: qgray <= 3'b001;
3'b010: qgray <= 3'b011;
3'b011: qgray <= 3'b010;
3'b100: qgray <= 3'b110;
3'b101: qgray <= 3'b111;
3'b110: qgray <= 3'b101;
3'b111: qgray <= 3'b100;
default: qgray <= 3'bx;
endcase
endmodule 