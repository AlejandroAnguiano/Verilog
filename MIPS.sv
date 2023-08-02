module MIPS (
input logic clk,
input logic clr,
output reg [32:0] alu
);

logic jump,branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,RegDst,zero;
logic [32:0]mux_s2,mux_s3,mux_s4,mux_s5,rom_addr,rom_out,r_data2,r_data1,mux2_in1,result_PC,mux5_in1,
shift2_out,mux4_in1,mux3_in1,conversion_momentanea,out_shift1;
logic [4:0]mux_s1;
logic [7:0]alu_in;
logic [1:0]aluop;

logic PCSrc;

control control_unit(
.opcode(rom_out[31:26]),
.jump(jump),
.branch(branch),
.MemRead(MemRead),
.MemtoReg(MemtoReg),
.MemWrite(MemWrite),
.ALUSrc(ALUSrc),
.RegWrite(RegWrite),
.RegDst(RegDst),
.ALUOp(aluop));

PC counter(
.clk(clk),
.clr(clr),
.data_in(mux_s5),
.data_out(rom_addr));



Reg_Bank #(.WL(32),.AL(32))
Reg_Bank0(
	.clk(clk), 
	.wr_en(MemWrite),
	.rd1_en(1'b1),
	.rd2_en(1'b1),
	.w_addr(mux_s1), 
	.r_addr1(rom_out[25:21]),
	.r_addr2(rom_out[20:16]),
	.w_data(mux_s3),
	.r_data1(r_data1),
	.r_data2(r_data2)
);

asyncmemROM 
INSmemory(
.raddr(rom_addr),
.waddr('0),
.Data_in('0),
.wen(1'b0),
.ren(1'b1),
.data_out(rom_out)
);

asyncmem 
RAM(.raddr(alu),
.waddr(alu),
.Data_in(r_data2),
.wen(MemWrite),
.ren(MemRead),
.clk(clk),
.data_out(mux3_in1)
);

 sign extender(
.in(rom_out[15:0]),
.out(mux2_in1));

shift_r #(.S(32))instr(
.in(rom_out[25:0]),
.out(out_shift1) );

shift_r #(.S(32)) jumpt(
.in(mux2_in1),
.out(shift2_out) );



alu m3(
.a(r_data1),
.b(mux_s2),
.alu_in(alu_in),
.zero(zero),
.alu_out(alu));

alu_control M2(
.aluop(aluop),
.instr(rom_out[5:0]), 
.alu_in(alu_in));

mux_ #(.WL(5)) mux1 (
.in_0(rom_out[20:16]),
.in_1(rom_out[15:11]),
.sel(RegDst),
.out(mux_s1)
);
mux_  #(.WL(32)) mux2 (
.in_0(r_data2),
.in_1(mux2_in1),
.sel(ALUSrc),
.out(mux_s2)
);
mux_  #(.WL(32)) mux3 (
.in_0(alu),
.in_1(mux3_in1),
.sel(MemWrite),
.out(mux_s3)
);
mux_ #(.WL(32)) mux4(
.in_0(result_PC),
.in_1(mux4_in1),
.sel(PCSrc),
.out(mux_s4)
);
mux_ #(.WL(32)) mux5(
.in_0(mux_s4),
.in_1(conversion_momentanea),
.sel(jump),
.out(mux_s5)
);

adder PC(
.A(rom_addr),
.B(4'b0100),
.result(result_PC));

adder jump1(
.A(result_PC),
.B(shift2_out),
.result(mux4_in1));

assign  PCSrc= branch & zero;
assign conversion_momentanea= {rom_addr[31:28],out_shift1};

endmodule


