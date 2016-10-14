module key (input CLOCK_50, inout [35:0] GPIO_1, input logic [3:0] KEY,
				output [6:0] HEX0, HEX2, HEX3, HEX4, HEX5);

	logic [31:0] clk;
	parameter whichClock = 8;
	clock_divider cdiv (CLOCK_50, clk);

		logic [4:0] H;
		logic [3:0] C;
		logic [0:3] R;
		
		logic not_press;
				
		assign GPIO_1[11] = C[0];
		assign GPIO_1[13] = C[1];
		assign GPIO_1[15] = C[2];
		assign GPIO_1[17] = C[3];
		
		assign R = {GPIO_1[19], GPIO_1[21], GPIO_1[23], GPIO_1[25]};

		logic [1:0] counter;
		assign not_press = (R[0] && R[1] && R[2] && R[3]);
		
		always @(posedge clk[whichClock])
			counter <= counter + not_press;
		
		always @(*)
			case(counter)
				0: C = 4'bzzz0;
				1: C = 4'bzz0z;
				2: C = 4'bz0zz;
				3: C = 4'b0zzz;
			endcase
		
	// Key scan logic
	always @(*) begin										
		if (R[0] == 0) begin
			case(counter)				
				0:			H = 1;
				1:			H = 4;
				2:			H = 7;
				3:			H = 14;
			endcase
		end 
		else if (R[1] == 0) begin
			case(counter)				
				0:			H = 2;
				1:			H = 5;
				2:			H = 8;
				3:			H = 0;
			endcase
		end 
		else if (R[2] == 0) begin
			case(counter)				
				0:			H = 3;
				1:			H = 6;
				2:			H = 9;
				3:			H = 15;
			endcase
		end
		else if (R[3] == 0) begin
			case(counter)				
				0:			H = 10;
				1:			H = 11;
				2:			H = 12;
				3:			H = 13;
			endcase
		end
		else				H = 16;
	end
		
		disp(H, HEX0);
		count(clk[whichClock], HEX2, HEX3, HEX4, HEX5, ~not_press, ~KEY[3]);
endmodule

module clock_divider (clock, divided_clocks);
		input logic clock;
		output logic [31:0] divided_clocks;

		initial
			divided_clocks <= 0;

		always_ff @(posedge clock)
			divided_clocks <= divided_clocks + 1;
endmodule