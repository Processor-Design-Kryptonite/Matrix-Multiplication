`timescale 1ns/1ps
module Memory_tb;
	reg clk;
	reg [7:0] address;
	reg  write_en1, write_en2, write_en3, write_en4;
	reg  [15:0] data1, data2, data3, data4;
	wire [15:0] q1, q2, q3, q4;
	
	// Clock
	initial 
		begin
			clk = 1'b0;
			forever begin
				#1 clk = ~clk;
			end
		end

	
	Memory_handle Memory_handle(
		.address(address),
		.clock(clk),
		.write_en1(write_en1),
		.write_en2(write_en2),
		.write_en3(write_en3),
		.write_en4(write_en4),
		.q1(q1),
		.q2(q2),
		.q3(q3),
		.q4(q4),
		.data1(data1),
		.data2(data2),
		.data3(data3),
		.data4(data4)
	);
	
	// Test
	initial 
		begin
			#1
			address = 8'd4;
			write_en1 = 1'd0;
			write_en2 = 1'd1;
			write_en3 = 1'd1;
			write_en4 = 1'd1;
			data1 = 16'd1;
			data2 = 16'd2;
			data3 = 16'd3;
			data4 = 16'd4;
			#2
			write_en1 = 1'd1;
			write_en2 = 1'd0;
			write_en3 = 1'd1;
			write_en4 = 1'd1;
			#2
			write_en1 = 1'd1;
			write_en2 = 1'd1;
			write_en3 = 1'd0;
			write_en4 = 1'd1;
			#2
			write_en1 = 1'd1;
			write_en2 = 1'd1;
			write_en3 = 1'd1;
			write_en4 = 1'd0;
			#8
			address = 8'd128;
//			write_en = 1'd1;
			#8		
			$finish;
		end
endmodule