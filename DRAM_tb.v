`timescale 1ns/1ps
module DRAM_tb;
	reg clk;
	reg [7:0] address;
	reg  write_en;
	reg  [15:0] data;
	wire [15:0] q;
	
	// Clock
	initial 
		begin
			clk = 1'b0;
			forever begin
				#1 clk = ~clk;
			end
		end

	
	DRAM DRAM(
		.address(address),
		.clock(clk),
		.wren(write_en),
		.q(q),
		.data(data)
	);
	
	// Test
	initial 
		begin
			#1 // Set load	= 1 and data to data_in
			address = 8'd5;
			write_en = 1'd0;
			data = 16'd32;
			#2 // Set load = 0 and data to data_in
			write_en = 1'd1;
			address = 8'd5;
			#4
			address = 16'd5;
			write_en = 1'd0;
			#4
			
			$finish;
		end
endmodule