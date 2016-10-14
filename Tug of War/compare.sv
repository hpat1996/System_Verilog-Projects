module compare (input logic [9:0] X, Y, output logic out);
	assign out = X>Y;
endmodule