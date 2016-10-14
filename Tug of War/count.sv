module count(input logic clk, input logic reset, input logic win, output logic [2:0] score, output logic [6:0] HEX);

	
	always_ff @(posedge clk)
		if (reset)
			score <= 0;
		else if (win)
			score <= score + 1;
	
	always @(*)
		case(score)
			0:  HEX = 7'b1000000;
			1:  HEX = 7'b1111001;
			2:  HEX = 7'b0100100;
			3:  HEX = 7'b0110000;
			4:  HEX = 7'b0011001;
			5:  HEX = 7'b0010010;
			6:  HEX = 7'b0000010;
			7:  HEX = 7'b1111000;
		endcase
endmodule