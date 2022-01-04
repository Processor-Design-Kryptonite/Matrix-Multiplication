`timescale 1ns/1ps
module clock_divider_tb;
	reg clock_in; 
	wire clock_out;
	
	// Clock
	initial 
		begin
			clock_in = 1'b0;
			forever begin
				#1 clock_in = ~clock_in;
			end
		end

	Clock_divider clock_divider(
			clock_in, clock_out
	);
	
	// Test
	initial 
		begin
			#16
			$finish;
		end
endmodule