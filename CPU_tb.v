`timescale 1ns/1ps
module CPU_tb;

	reg MAIN_CLOCK;
	wire RAM_CLOCK;
	wire [15:0] REG_AC1, REG_AC2;
	wire [15:0] REG_1_1;// REG_1_2, REG_1_3, REG_1_4;
	wire [15:0] REG_2_1;// REG_2_2, REG_2_3, REG_2_4;
	wire [15:0] REG_3_1;// REG_3_2, REG_3_3, REG_3_4;  
	wire [15:0] REG_AS1;// REG_AS2, REG_AS3, REG_AS4;
	wire [5:0] CMD1;// CMD2, CMD3, CMD4;
	wire PROCESS_DONE1;// PROCESS_DONE2, PROCESS_DONE3, PROCESS_DONE4;
	wire [15:0] DATA_OUT_RAM1, DATA_OUT_RAM2;
	
	
	CPU cpu (
		.MAIN_CLOCK(MAIN_CLOCK),
		.RAM_CLOCK(RAM_CLOCK),
		.REG_1_1(REG_1_1),
		.REG_2_1(REG_2_1),
		.REG_3_1(REG_3_1),
		.REG_AS1(REG_AS1),
		.CMD1(CMD1),
		.PROCESS_DONE1(PROCESS_DONE1),
		.REG_AC1(REG_AC1),
		.REG_AC2(REG_AC2),
		.DATA_OUT_RAM1(DATA_OUT_RAM1),
		.DATA_OUT_RAM2(DATA_OUT_RAM2)
	);
	
	// Clock
	initial begin
		MAIN_CLOCK = 1'b0;
			forever begin
				#1 MAIN_CLOCK = ~MAIN_CLOCK;
			end
	end
	
	// Test
	initial begin
	#3000000
	$finish;
	end
endmodule