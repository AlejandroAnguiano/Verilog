module PC(clk,clr,data_in,data_out);
input clk, clr;
input [31:0] data_in;
output logic [31:0] data_out;


always_ff @(posedge clk) begin
	if(clr)
		data_out <= 0;
		  else 
            data_out <= data_in;
				 
end



endmodule 