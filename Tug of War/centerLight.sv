module centerLight (Clock, Reset, L, R, NL, NR, curr, lightOn);
	input logic Clock, Reset;
	input logic L, R, NL, NR, curr;
	output logic lightOn;
	
	always_ff @(posedge Clock) 
		if ((~Reset && ~L && ~R) || (L && R))	lightOn <= curr;
		else if (Reset)		   		lightOn <= 1;
		else if (L && NR)					lightOn <= 1;
		else if (R && NL) 				lightOn <= 1;
		else									lightOn <= 0;
endmodule

module normalLight (Clock, Reset, L, R, NL, NR, curr, lightOn);
	input logic Clock, Reset;
	input logic L, R, NL, NR, curr;
	output logic lightOn;
	
	always_ff @(posedge Clock)
		if ((~Reset && ~L && ~R) || (L && R))	lightOn <= curr;
		else if (Reset)					lightOn <= 0;
		else if (L && NR)					lightOn <= 1;
		else if (R && NL) 				lightOn <= 1;
		else									lightOn <= 0;
endmodule

module edgeLLight (Clock, Reset, L, R, NL, NR, curr, lightOn);
	input logic Clock, Reset;
	input logic L, R, NL, NR, curr;
	output logic lightOn;
	
	always_ff @(posedge Clock)
		if ((~Reset && ~L && ~R) || (L && R))	lightOn <= curr;
		else if (Reset)					lightOn <= 0;
		else if (L && NR)					lightOn <= 1;
		else if (R && NL) 				lightOn <= 1;
		else if (curr && L)				lightOn <= 1;
		else									lightOn <= 0;
endmodule

module edgeRLight (Clock, Reset, L, R, NL, NR, curr, lightOn);
	input logic Clock, Reset;
	input logic L, R, NL, NR, curr;	
	output logic lightOn;
	
	always_ff @(posedge Clock)
		if ((~Reset && ~L && ~R) || (L && R))	lightOn <= curr;
		else if (Reset)					lightOn <= 0;
		else if (L && NR)					lightOn <= 1;
		else if (R && NL) 				lightOn <= 1;
		else if (curr && R)				lightOn <= 1;
		else									lightOn <= 0;
endmodule

module CL_testbench();

	logic clk, Reset, L, R, NL, NR, curr, lightOn;
	
	centerLight dut (clk, Reset, L, R, NL, NR, curr, lightOn);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
	initial begin
			
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	Reset <= 0;
	L <= 1;
	NR <= 1;		@(posedge clk);
					@(posedge clk);
	L <= 1;
	NR <= 0;		@(posedge clk);
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	$stop; // End the simulation.
	end
endmodule

module NL_testbench();

	logic clk, Reset, L, R, NL, NR, curr, lightOn;
	
	normalLight dut (clk, Reset, L, R, NL, NR, curr, lightOn);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
	initial begin
			
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	Reset <= 0;
	L <= 1;
	NR <= 1;		@(posedge clk);
					@(posedge clk);
	L <= 1;
	NR <= 0;		@(posedge clk);
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	$stop; // End the simulation.
	end
endmodule

module EL_testbench();

	logic clk, Reset, L, R, NL, NR, curr, lightOn;
	
	edgeLLight dut (clk, Reset, L, R, NL, NR, curr, lightOn);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
	initial begin
			
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	Reset <= 0;
	L <= 1;
	NR <= 1;		@(posedge clk);
					@(posedge clk);
	L <= 1;
	NR <= 0;		@(posedge clk);
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	$stop; // End the simulation.
	end
endmodule

module ER_testbench();

	logic clk, Reset, L, R, NL, NR, curr, lightOn;
	
	edgeRLight dut (clk, Reset, L, R, NL, NR, curr, lightOn);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
	initial begin
			
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	Reset <= 0;
	R <= 1;
	NL <= 1;		@(posedge clk);
					@(posedge clk);
	L <= 1;
	NR <= 0;		@(posedge clk);
					@(posedge clk);
	Reset <= 1; @(posedge clk);
					@(posedge clk);
	$stop; // End the simulation.
	end
endmodule