module BoothMul(clk,rst,start,X,Y,valid,Z);

input clk;
input rst;
input start;
input logic [7:0]X,Y;
output logic [15:0]Z;
output valid;

logic [7:0] next_Z,Z_temp;
logic next_state, pres_state;
logic [1:0] temp,next_temp;
logic [1:0] count,next_count;
logic valid, next_valid;

parameter IDLE = 1'b0;
parameter START = 1'b1;


if(rst)
begin
always_ff @ (posedge clk )
  Z          <= 16'd0;
  always_ff @ (posedge clk )
  valid      <= 1'b0;
  always_ff @ (posedge clk )
  pres_state <= 1'b0;
  always_ff @ (posedge clk )
  temp       <= 2'd0;
  always_ff @ (posedge clk )
  count      <= 2'd0;
end
else
begin
  Z          <= next_Z;
  valid      <= next_valid;
  pres_state <= next_state;
  temp       <= next_temp;
  count      <= next_count;
end


always_comb 
begin 
case(pres_state)
IDLE:
begin
next_count = 2'b0;
next_valid = 1'b0;
if(start)
begin
    next_state = START;
    next_temp  = {X[0],1'b0};
    next_Z     = {8'd0,X};
end
else
begin
    next_state = pres_state;
    next_temp  = 2'd0;
    next_Z     = 8'd0;
end
end

START:
begin
    case(temp)
    2'b10:   Z_temp = {Z[15:8]-Y,Z[7:0]};
    2'b01:   Z_temp = {Z[15:8]+Y,Z[7:0]};
    default: Z_temp = {Z[15:8],Z[7:0]};
    endcase
next_temp  = {X[count+1],X[count]};
next_count = count + 1'b1;
next_Z     = Z_temp >>> 1;
next_valid = (&count) ? 1'b1 : 1'b0; 
next_state = (&count) ? IDLE : pres_state;	
end
endcase
end
endmodule
