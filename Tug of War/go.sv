module go (input CLOCK_50, input logic [3:0] ps, input logic [9:0] LD, output logic [9:0] LEDR);

	genvar i;
	
	generate
			for (i = 1; i < 10; i++) begin:light
				if (i == 5) 		centerLight c1 (CLOCK_50, ps[2], ps[1], ps[0], LD[i+1], LD[i-1], LD[i], LEDR[i]);
				else if (i == 1)	edgeRLight n1 (CLOCK_50, ps[2], ps[1], ps[0], LD[i+1], 0, LD[i], LEDR[i]);
				else if (i == 9)  edgeLLight n2 (CLOCK_50, ps[2], ps[1], ps[0], 0, LD[i-1], LD[i], LEDR[i]);
				else					normalLight n3 (CLOCK_50, ps[2], ps[1], ps[0], LD[i+1], LD[i-1], LD[i], LEDR[i]);
			end
	endgenerate

endmodule