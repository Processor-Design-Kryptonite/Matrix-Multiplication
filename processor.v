module processor
(
	input MAIN_CLOCK,
	input [15:0] DATA_FROM_RAM,
	input [7:0] INSTRUCTION,
	output PROCESS_FINISHED, CPU_CLOCK,
	output CPU_WRITE_EN, //Z_Flag,
	output [15:0] CPU_ADDRESS, REG_AC, REG_1, REG_2, REG_3, REG_AS, CPU_DATA,
	output [7:0] INSTRUCTION_ADDRESS,
	output [5:0] CMD
);
	wire INTERNAL_CLOCK, FLAG_Z, FETCH;
	wire [2:0] ALU_OP;
	wire [3:0] REG_IN_B_BUS;
	wire [7:0] IR;
	wire [15:0] B_BUS, PC, R1, R2, R3, AS, TR, TM, MR, R, AC, ALU_OUT;
	wire [16:0] SELECTORS;
	wire SIGNAL_TO_FINISH_PROCESS;

	assign CPU_CLOCK = INTERNAL_CLOCK;
	assign CPU_WRITE_EN = SELECTORS[0];
	assign CPU_DATA = B_BUS[15:0];
	assign INSTRUCTION_ADDRESS = PC[7:0];
	assign PROCESS_FINISHED = SIGNAL_TO_FINISH_PROCESS;
	assign REG_AC = AC;
	assign REG_1 = R1;
	assign REG_2 = R2;
	assign REG_3 = R3;
	assign REG_AS = AS;
//	assign Z_Flag = FLAG_Z;

	cpu_clock_generator Clock (
		.MAIN_CLOCK(MAIN_CLOCK),
		.PROCESS_FINISHED(SIGNAL_TO_FINISH_PROCESS),
		.TICK(INTERNAL_CLOCK)
	);

	MUX_FOR_BUS_B mux(
		.select(REG_IN_B_BUS),
		.R1(R1),
		.R2(R2),
		.R3(R3),
		.AS(AS),
		.R(R),
		.TR(TR),
		.TM(TM),
		.MR(MR),
		.AC(AC),
		.DATA_FROM_RAM(DATA_FROM_RAM),
		.instructions(INSTRUCTION),
		.bus(B_BUS)
	);
	
	control_unit controlling (
		.clk(INTERNAL_CLOCK),
		.Z(FLAG_Z),
		.instruction(IR),
		.fetch(FETCH),
		.finish(SIGNAL_TO_FINISH_PROCESS),
		.b_bus_select(REG_IN_B_BUS),
		.alu_op(ALU_OP),
		.cmd(CMD),
		.selectors(SELECTORS)
	);

	IRegister IR_register(
		.clk(INTERNAL_CLOCK),
		.write_en(FETCH),
		.data_in(B_BUS[7:0]),
		.data_out(IR)
	);

	Register  AR_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[10]),
		.increase(1'b0),
		.data_in(B_BUS),
		.data_out(CPU_ADDRESS)
	);

	Register General_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[5]),
		.increase(1'b0),
		.data_in(B_BUS),
		.data_out(R)
	);

	Register R1_register (
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[8]),
		.increase(SELECTORS[14]),
		.data_in(B_BUS),
		.data_out(R1)
	);

	Register R2_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[7]),
		.increase(SELECTORS[13]),
		.data_in(B_BUS),
		.data_out(R2)
	);

	Register R3_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[6]),
		.increase(SELECTORS[12]),
		.data_in(B_BUS),
		.data_out(R3)
	);

	Register Loc_WR_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[4]),
		.increase(SELECTORS[11]),
		.data_in(B_BUS),
		.data_out(AS)
	);

	Register MUL_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[3]),
		.increase(1'b0),
		.data_in(B_BUS),
		.data_out(MR)
	);

	Register TR_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[2]),
		.increase(1'b0),
		.data_in(B_BUS),
		.data_out(TR)
	);
	
	Register TMUL_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[16]),
		.increase(1'b0),
		.data_in(B_BUS),
		.data_out(TM)
	);

	Register AC_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[1]),
		.increase(1'b0),
		.data_in(ALU_OUT),
		.data_out(AC)
	);

	Register PC_register(
		.clk(INTERNAL_CLOCK),
		.write_en(SELECTORS[9]),
		.increase(SELECTORS[15]),
		.data_in(B_BUS),
		.data_out(PC)
	);

	ALU ALU_unit (
		.A_bus(AC),
		.B_bus(B_BUS),
		.ALU_OP(ALU_OP),
		.C_bus(ALU_OUT),
		.FLAG_Z(FLAG_Z)
	);
endmodule
