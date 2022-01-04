`timescale 1ns/1ps
module dataA_tb;
	reg clk;
	reg [7:0] address;
	reg  write_en;
	reg [15:0] data;
	wire [15:0] q1, q2, q3, q4;
	
	// Clock
	initial 
		begin
			clk = 1'b0;
			forever begin	
				#1 clk = ~clk;
			end
		end

	
	dataA dataA(
		.address(address),
		.clk(clk),
		.write_en(write_en),
		.data(data),
		.q1(q1), 
		.q2(q2), 
		.q3(q3), 
		.q4(q4)
	);
	
	// Test
	initial 
		begin
			#1 // Set load	= 1 and data to data_in
			address = 8'd18;
			write_en = 1'd1;
			data = 8'd1;
			#20 // Set load = 0 and data to data_in
			address = 8'd5;
			write_en = 1'd0;
			#50
			$finish;
		end
endmodule 