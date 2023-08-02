module alu(
input logic [31:0] a,
input logic [31:0] b,
input [7:0] alu_in,

output zero,
output logic [31:0] alu_out);
logic [1:0] aluop;
logic  [5:0] func ;

assign aluop = alu_in [7:6];
assign func = alu_in [5:0];

always @(*)
	begin 
	case (aluop) 
	2'b00: alu_out = a+b;                    //ADDI,LOAD,STORE 
	2'b01:  alu_out = a-b ;                  //BEQ
	2'b10:begin
		case(func)
		6'b100000: alu_out = a+b;             //ADD
		6'b101010: alu_out = (a < b) ? 1:0;	  //SLT
		6'b100100: alu_out = a & b;			  //AND
		6'b100101: alu_out = a | b;			  //OR
		6'b100010: alu_out = a - b;			  //SUB
		6'b100111: alu_out = ~(a | b);        //NOR
		default: alu_out= 'z;
		endcase
		end 
	2'b11: alu_out = a | b;                  //ORI
	default: alu_out= 'z;
   endcase
	end
	
	assign zero = (a-b == 0) ? 1:0;
endmodule
