module control(
input [5:0] opcode,
//
output logic jump,
output logic branch,
output logic MemRead,
output logic MemtoReg,
output logic MemWrite,
output logic ALUSrc,
output logic RegWrite,
output logic RegDst,
output logic [1:0] ALUOp);


always_comb begin
case (opcode) 
6'b000000:begin ALUOp = 2'b 10 ;jump=0;branch =0;MemRead=0;MemtoReg=0;MemWrite=0;ALUSrc=0;RegWrite =1;RegDst=1;end // Type-R

6'b001000:begin ALUOp = 2'b 00; jump=0;branch =0;MemRead=0;MemtoReg=0;MemWrite=0;ALUSrc=1;RegWrite =1;RegDst=0; end //ADDI

6'b100011:begin ALUOp = 2'b 00; jump=0;branch =0;MemRead=1;MemtoReg=1;MemWrite=0;ALUSrc=1;RegWrite =1;RegDst=0;end //LOAD

6'b101011:begin ALUOp = 2'b 00; jump=0;branch =0;MemRead=0;MemtoReg=0;MemWrite=1;ALUSrc=1;RegWrite =0;RegDst=0;end //STORE

6'b000100:begin ALUOp = 2'b 01; jump=0;branch =1;MemRead=0;MemtoReg=0;MemWrite=0;ALUSrc=0;RegWrite =0;RegDst=0;end //BEQ

6'b001101:begin ALUOp = 2'b 11; jump=0;branch =0;MemRead=0;MemtoReg=0;MemWrite=0;ALUSrc=1;RegWrite =1;RegDst=0;end //ORI

default: begin ALUOp =   2'bxx; jump=1;branch =0;MemRead=0;MemtoReg=0;MemWrite=0;ALUSrc=0;RegWrite =0;RegDst=0;end //J
endcase
end

endmodule 