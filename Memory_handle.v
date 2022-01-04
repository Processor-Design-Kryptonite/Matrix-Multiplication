module Memory_handle(
	
	input	[7:0]  address,
	input	  clock,
	input	  write_en1,write_en2,write_en3,write_en4,
	input	[15:0]  data1, data2, data3, data4,
	output	[15:0]  q1, q2, q3, q4
	);
	
	DRAM DRAM1(
		.address(address),
		.clock(clk),
		.wren(write_en1),
		.q(q1),
		.data(data1)
	);
	
	DRAM DRAM2(
		.address(address+8'd16),
		.clock(clk),
		.wren(write_en2),
		.q(q2),
		.data(data2)
	);
	
	DRAM DRAM3(
		.address(address+8'd32),
		.clock(clk),
		.wren(write_en3),
		.q(q3),
		.data(data3)
	);
	
	DRAM DRAM4(
		.address(address+8'd48),
		.clock(clk),
		.wren(write_en4),
		.q(q4),
		.data(data4)
	);

endmodule