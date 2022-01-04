module processing_unit
(
// Inputs
input MAIN_CLOCK,
input [7:0] DATA_FROM_RAM, INSTRUCTION,
output PROCESS_FINISHED, CPU_CLOCK,
output CPU_WRITE_EN, Z_Flag,
output [15:0] CPU_ADDRESS, REG_AC, REG_1, REG_2,
output [7:0] CPU_DATA, INSTRUCTION_ADDRESS,
output [5:0] CMD
);
wire INTERNAL_CLOCK, FLAG_Z, FETCH;
wire [2:0] ALU_OP;
wire [3:0] REG_IN_B_BUS;
wire [7:0] IR;
wire [15:0] B_BUS, PC, R1, R2, TR, R, AC, ALU_OUT;
wire [12:0] SELECTORS;
wire SIGNAL_TO_FINISH_PROCESS;
assign CPU_CLOCK = INTERNAL_CLOCK;
assign CPU_WRITE_EN = SELECTORS[0];
assign CPU_DATA = B_BUS[7:0];
assign INSTRUCTION_ADDRESS = PC[7:0];
assign PROCESS_FINISHED = SIGNAL_TO_FINISH_PROCESS;
assign REG_AC = AC;
assign REG_1 = R1;
assign REG_2 = R2;
assign Z_Flag = FLAG_Z;
cpu_clock_generator Clock (
.MAIN_CLOCK(MAIN_CLOCK),
.PROCESS_FINISHED(SIGNAL_TO_FINISH_PROCESS),
.TICK(INTERNAL_CLOCK)
);
mux_for_busB muxing(
.select(REG_IN_B_BUS),
.pc(PC),
.r1(R1),
.r2(R2),
.tr(TR),
.r(R),
.ac(AC),
.ar(CPU_ADDRESS),
.instructions(INSTRUCTION),
.data_from_ram(DATA_FROM_RAM),
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
.increase(1'b0),
.data_in(B_BUS[7:0]),
.data_out(IR)
);
Register  AR_register(
.clk(INTERNAL_CLOCK),
.write_en(SELECTORS[7]),
.increase(SELECTORS[8]),
.data_in(B_BUS),
.data_out(CPU_ADDRESS)
);
Register General_register(
.clk(INTERNAL_CLOCK),
.write_en(SELECTORS[2]),
.increase(1'b0),
.data_in(B_BUS),
.data_out(R)
);
Register R1_register (
.clk(INTERNAL_CLOCK),
.write_en(SELECTORS[5]),
.increase(SELECTORS[11]),
.data_in(B_BUS),
.data_out(R1)
);
Register R2_register(
.clk(INTERNAL_CLOCK),
.write_en(SELECTORS[4]),
.increase(SELECTORS[10]),
.data_in(B_BUS),
.data_out(R2)
);
Register TR_register(
.clk(INTERNAL_CLOCK),
.write_en(SELECTORS[3]),
.increase(SELECTORS[9]),
.data_in(B_BUS),
.data_out(TR)
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
.write_en(SELECTORS[6]),
.increase(SELECTORS[12]),
.data_in(B_BUS),
.data_out(PC)
);
ALU ALU_unit (
.A_in(AC),
.B_in(B_BUS),
.cntrl_signal(ALU_OP),
.C_out(ALU_OUT),
.Z(FLAG_Z)
);
endmodule
