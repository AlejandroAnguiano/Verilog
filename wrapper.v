module wrapper (SW,LEDR,MAX10_CLK1_50,KEY);

input [9:0]SW;
input  [1:0] KEY;
input   MAX10_CLK1_50;
output [9:0] LEDR;
wire Clock = !KEY[0] ;

	wire Resetn = SW[0];
	wire out;
	

cont_1s_RCO counte(.mclk(Clock), .reset(Resetn),.RCO(LEDR[5]));
gray_code gray( .q(SW[4:1]), .reset(Resetn), .qgray(LEDR[3:0]),.clk(Clock));

endmodule
