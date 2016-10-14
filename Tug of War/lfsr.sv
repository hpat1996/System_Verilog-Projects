module lfsr (input logic clk, output logic [9:0] Q, input logic r);
		reg out;
		assign out = ~(Q[9] + Q[6]);
		always @(posedge clk) begin
			if (r)
				Q <= 0;
			else
				Q <= {Q[9:0], out};
		end
endmodule

module lfsr_testbench();

logic clk;
logic [9:0] Q;
logic r;

lfsr dut(clk, Q, r);

		parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end

			// Set up the inputs to the design. Each line is a clock cycle.
		initial begin
									@(posedge clk);
		r <= 1; 					@(posedge clk);
									@(posedge clk);
		r <= 0;					@(posedge clk);
		
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		@(posedge clk);@(posedge clk);									
		$stop; // End the simulation.
	end
endmodule									