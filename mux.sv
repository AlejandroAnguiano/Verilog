module mux_
#(
	// Parameter Declarations
	parameter WL = 32  // Register Word-Length 
	 
	)
	(

input logic [WL-1:0] in_0,
input logic [WL-1:0] in_1,

input logic sel,

output logic [WL-1:0] out
);

assign out = sel ? in_0:in_1;

endmodule 


