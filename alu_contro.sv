module alu_control(
input [1:0] aluop,
input [5:0] instr, 
output logic [7:0] alu_in);

assign alu_in = {aluop,instr};


endmodule 


