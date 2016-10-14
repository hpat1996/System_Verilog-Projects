module UIL (input [3:0] KEY, input logic [2:0] ps, output logic [2:0] ns);

		logic [2:0] A, R, L, B;
		assign A = 3'b000;
		assign B = 3'b111;
		assign R = 3'b001;
		assign L = 3'b010;

			always_comb begin
			case(ps)
				A: if (~KEY[3])		ns = L;
					else					ns = A;
				default: if (KEY[3])			ns = A;
							else					ns = B;
			endcase
			end
endmodule

module UIR (input KEY, input logic [2:0] ps, output logic [2:0] ns);

		logic [2:0] A, R, L, B;
		assign A = 3'b000;
		assign B = 3'b111;
		assign R = 3'b001;
		assign L = 3'b010;

			always_comb begin
			case(ps)
				A: if (KEY)		ns = R;
					else					ns = A;
				default: if (~KEY)			ns = A;
							else					ns = B;
			endcase
			end
endmodule

module UIL_testbench();

	logic[3:0] KEY;
	logic [2:0] ps, ns;
	logic clk;
	
	UIL dut (KEY, ps, ns);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
	
	initial begin
							@(posedge clk);
		KEY[3] <= 0;	@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		KEY[3] <= 1;	@(posedge clk);
							@(posedge clk);
							@(posedge clk);
	$stop; // End the simulation.
	end
endmodule

module UIR_testbench();

	logic KEY;
	logic [2:0] ps, ns;
	logic clk;
	
	UIR dut (KEY, ps, ns);
	
	parameter CLOCK_PERIOD=100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
							@(posedge clk);
		KEY <= 0;	@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		KEY <= 1;	@(posedge clk);
							@(posedge clk);
							@(posedge clk);
	$stop; // End the simulation.
	end
endmodule
							