`timescale 1ns/1ps
module DRAM_control_tb;
	reg clk;
	reg [7:0] address;
	reg  write_en;
	wire en1, en2, en3, en4;
	
	// Clock
	initial 
		begin
			clk = 1'b0;
			forever begin	
				#1 clk = ~clk;
			end
		end

	
	DRAM_control control(
		.clk(clk),
		.address(address),
		.write_en(write_en),
		.en1(en1), 
		.en2(en2), 
		.en3(en3), 
		.en4(en4)
	);
	
	// Test
	initial 
		begin
			#1 // Set load	= 1 and data to data_in
			address = 8'd5;
			write_en = 1'd0;
			#20 // Set load = 0 and data to data_in
			$finish;
		end
endmodule 