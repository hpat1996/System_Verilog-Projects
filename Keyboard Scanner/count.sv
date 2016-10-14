module count(input logic clock, output logic [6:0] HEX2, HEX3, HEX4, HEX5, input logic press, input logic r);
			logic [15:0] d;
			logic ps, ns;
			enum {A, B} state;
			logic go;
						
			always @(*)
				case(ps)
					A: begin
						if (press) begin
							ns = B;
							go = 1;
						end else begin
							ns = A;
							go = 0;
						end
						end
					B: begin
						if (press) begin
							ns = B;
							go = 0;
						end else begin
							ns = A;
							go = 0;
						end
						end
				endcase
			
			
			always @(posedge clock)	 begin
				if (r)
					d =0;
				ps <= ns;
				d = d + go;
				if (d[3:0] == 10) begin
					d[7:4]++;
					d[3:0] = 0;
				end 
				if (d[7:4] == 10) begin
					d[11:8]++;
					d[7:4] = 0;
				end 
				if (d[11:8] == 10) begin
					d[15:12]++;
					d[11:8] = 0;
				end 
				if (d[15:12] == 10) begin
					d[15:12] = 0;
				end 
			end
			
			
			disp(d[3:0], HEX2);
			disp(d[7:4], HEX3);
			disp(d[11:8], HEX4);
			disp(d[15:12], HEX5);
endmodule