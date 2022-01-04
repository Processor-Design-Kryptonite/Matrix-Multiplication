module dataA(
	//input [7:0] address,
	input [15:0] address,
	input clk,
	input write_en,
	input [15:0] data1,data2,data3,data4,
	output [15:0] q1,q2,q3,q4
	);

	wire en1,en2,en3,en4,enable;
	wire [15:0] q,data;
	wire [7:0] dram_address;

	DRAM_control controller(
		.clk(clk),
		.address(address),
		.write_en(write_en),
		.en1(en1),
		.en2(en2),
		.en3(en3),
		.en4(en4),
		.dram_address(dram_address)
	);

	DRAM_ip data_in(
		.clk(clk),
		.en1(en1),
		.en2(en2),
		.en3(en3),
		.en4(en4),
		.write_en(write_en),
		.data1(data1),
		.data2(data2),
		.data3(data3),
		.data4(data4),
		.data(data),
		.wren(enable)
	);
	
	DRAM DRAM(
		.address(dram_address),
		.clock(clk),
		.wren(enable),
		.q(q),
		.data(data)
	);
	
	DRAM_op dataq1(
		.clk(clk),
		.enable(en1),
		.q(q),
		.data_out(q1)
	);

	DRAM_op dataq2(
		.clk(clk),
		.enable(en2),
		.q(q),
		.data_out(q2)
	);

	DRAM_op dataq3(
		.clk(clk),
		.enable(en3),
		.q(q),
		.data_out(q3)
	);

	DRAM_op dataq4(
		.clk(clk),
		.enable(en4),
		.q(q),
		.data_out(q4)
	);

endmodule