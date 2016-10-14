module war (input logic CLOCK_50, output logic [9:0] LEDR, input logic [9:0] SW,
			  input logic [3:0] KEY, output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
				
		// Generate clk off of CLOCK_50, whichClock picks rate.
		logic [31:0] clk;
		parameter whichClock = 15;
		clock_divider cdiv (CLOCK_50, clk);
			  
			  
		assign HEX1 = 7'b1111111;
		assign HEX2 = 7'b1111111;
		assign HEX3 = 7'b1111111;
		assign HEX4 = 7'b1111111;

		logic [9:0] LD;

		logic [6:0] H;

		logic [2:0] RS, R, L;
		assign RS = 3'b100;
		assign R = 3'b001;
		assign L = 3'b010;
		logic [2:0] psl, nsl, psr, nsr, ps;
		logic V;
		logic rst;

		logic [2:0] SL, SR;

		UIL inl (KEY, psl, nsl);
		
		logic [9:0] Q;
		logic press;
		
		lfsr cpu (clk[whichClock], Q, V);
		compare ({1'b0, SW[8:0]}, Q, press);
		UIR inr (press, psr, nsr);

		assign H = (psl == L && LEDR[9])? 7'b0110000 : (psr == R && LEDR[1]) ? 7'b1000000 : 7'b1111111;
		assign V = ~H[0];

		generate
			assign ps = (psl == 7 || psl == 4) ? psr : (psr == 7) ? psl : psr + psl;
			assign LEDR = LD;
			go gol (clk[whichClock], ps, LEDR, LD);
			count cl (clk[whichClock], rst, V && H[5], SL, HEX5);
			count cr (clk[whichClock], rst, V && ~H[5], SR, HEX0);
		endgenerate

		always_ff @(posedge clk[whichClock]) begin
			if (SW[9]) begin
				psl <= RS;
				psr <= RS;
				SL <= 0;
				SR <= 0;
				rst <= 1;
			end else if (V) begin
				psl <= RS;
				psr <= RS;
				rst <= 0;
			end else if (~V) begin
				psl <= nsl;
				psr <= nsr;
				rst <= 0;
			end
		end
endmodule

// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
		input logic clock;
		output logic [31:0] divided_clocks;

		initial
			divided_clocks <= 0;

		always_ff @(posedge clock)
			divided_clocks <= divided_clocks + 1;
endmodule

module war_testbench();
	logic clk;
	logic [9:0] LEDR, SW;
	logic [3:0] KEY;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

		war dut (clk, LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

			// Set up the clock.
		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end

			// Set up the inputs to the design. Each line is a clock cycle.
		initial begin
									@(posedge clk);
		SW[9] <= 1; 			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		SW[9] <= 0;
		KEY[0] <= 1;
		KEY[3] <= 0;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		KEY[0] <= 0;
		KEY[3] <= 0;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);

		KEY[0] <= 1;
		KEY[3] <= 0;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		KEY[0] <= 0;
		KEY[3] <= 1;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);

		KEY[0] <= 0;
		KEY[3] <= 0;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		KEY[0] <= 0;
		KEY[3] <= 1;			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		$stop; // End the simulation.
	end
endmodule
