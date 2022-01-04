module control_unit(
	input clk, Z,
	input [7:0] instruction,
	output reg fetch, finish = 0,
	output [5:0] cmd,
	output reg [3:0] b_bus_select,
	output reg [2:0] alu_op,
	output reg [16:0] selectors
);

localparam
FETCH1 = 6'd0, FETCH2 = 6'd1, FETCH3 = 6'd2, FETCH4 = 6'd3,
CLAC = 6'd5, LDAC = 6'd6, STAC = 6'd7,
MVACR = 6'd8, MVACR1 = 6'd9, MVACR2 = 6'd10, MVACR3 = 6'd11,
MVACAS = 6'd12, MVACMR = 6'd13, MVACTR = 6'd14, MVACAR = 6'd15,
MVR = 6'd16, MVR1 = 6'd17, MVR2 = 6'd18, MVR3 = 6'd19, MVAS = 6'd20,
INCR1 = 6'd21, INCR2 = 6'd22, INCR3 = 6'd23, INCAS = 6'd24,
JPNZ = 6'd25,
JPNZY = 6'd26, JPNZY1 = 6'd27,
JPNZN = 6'd28, JPNZN1 = 6'd29, JPNZN2 = 6'd30,
ADDR = 6'd31, ADD = 6'd32, SUB = 6'd33, MUL = 6'd34,
ADDM = 6'd35, ADDM1 = 6'd36,MULM = 6'd37,MULM1 = 6'd38,
MVACTM = 6'd39, MVTM = 6'd40,
NOP = 6'd4, END = 6'd41;
localparam
DATA_FROM_RAM = 4'd0, PC = 4'd1, R1 = 4'd2, R2 = 4'd3, R3 = 4'd4,
AS = 4'd5, TR = 4'd6, MR = 4'd7, R = 4'd8, AC = 4'd9, 
INSTRUCTIONS = 4'd10, AR = 4'd11, TM = 4'd12;
localparam
ADDAB = 3'd0, SUBAB = 3'd1, PASS = 3'd2, ZER = 3'd3, MULAB = 3'd4, MULMA = 3'd5;

reg [5:0] CONTROL_COMMAND;
reg [5:0] NEXT_COMMAND = FETCH1;
always @ (negedge clk) CONTROL_COMMAND <= NEXT_COMMAND;


//CONTROL_COMMAND or Z or instruction
always @ (CONTROL_COMMAND or Z or instruction)
	case(CONTROL_COMMAND)
		FETCH1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <=INSTRUCTIONS;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= FETCH2;
			end
		FETCH2: // Checked
			begin
				fetch <= 1;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= FETCH3;
			end
		FETCH3: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= PASS;
				selectors <= 17'b0_1000_0000_0000_0000;
				NEXT_COMMAND <= FETCH4;
			end
		FETCH4: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= instruction[5:0];
			end
		CLAC: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ZER;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		LDAC: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		STAC: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0001;
				NEXT_COMMAND <= FETCH1;
			end
		MVACR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <=AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0010_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACR1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0001_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACR2: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_1000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACR3: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0100_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACAS: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0001_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACMR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_1000;
				NEXT_COMMAND <= FETCH1;
			end	
		MVACTR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0100;
				NEXT_COMMAND <= FETCH1;
			end
		MVACTM: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b1_0000_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVACAR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0100_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		MVR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= R;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MVR1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= R1;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MVR2: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= R2;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MVR3: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= R3;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MVAS: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AS;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MVTM: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= TM;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
//		MVAR: // Checked
//			begin
//				fetch <= 0;
//				finish <= 0;
//				b_bus_select <= AR;
//				alu_op <= PASS;
//				selectors <= 13'b0_0000_0000_0010;
//				NEXT_COMMAND <= FETCH1;
//			end
//		INCAR: // Checked
//			begin
//				fetch <= 0;
//				finish <= 0;
//				b_bus_select <= DATA_FROM_RAM;
//				alu_op <= ADDAB;
//				selectors <= 13'b0_0001_0000_0000;
//				NEXT_COMMAND <= FETCH1;
//			end
		INCR1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0100_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		INCR2: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0010_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		INCR3: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0001_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		INCAS: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_1000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		ADDR: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= R;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		ADD: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= TR;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		SUB: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= TR;
				alu_op <= SUBAB;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MUL: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= MR;
				alu_op <= MULAB;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		MULM: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= PASS;
				selectors <= 17'b0_1000_0000_0000_0000;
				NEXT_COMMAND <= MULM1;
			end
		MULM1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= MULMA;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
//		DIV: // Checked
//			begin
//				fetch <= 0;
//				finish <= 0;
//				b_bus_select <= INSTRUCTIONS;
//				alu_op <= PASS;
//				selectors <= 13'b1_0000_0000_0000;
//				NEXT_COMMAND <= DIV1;
//			end
//		DIV1: // Checked
//			begin
//				fetch <= 0;
//				finish <= 0;
//				b_bus_select <= INSTRUCTIONS;
//				alu_op <= DIVA;
//				selectors <= 13'b0_0000_0000_0010;
//				NEXT_COMMAND <= FETCH1;
//			end
		ADDM: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= ADDAB;
				selectors <= 17'b0_1000_0000_0000_0000;
				NEXT_COMMAND <= ADDM1;
			end
		ADDM1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		JPNZ: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= (Z) ? JPNZY : JPNZN;
			end
		JPNZY: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= PASS;
				selectors <= 17'b0_1000_0000_0000_0000;
				NEXT_COMMAND <= JPNZY1;
			end
		JPNZY1: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ZER;
				selectors <= 17'b0_0000_0000_0000_0010;
				NEXT_COMMAND <= FETCH1;
			end
		JPNZN: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op<= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= JPNZN1;
			end
		JPNZN1: // Checked
			begin
				fetch<= 0;
				finish <= 0;
				b_bus_select <= INSTRUCTIONS;
				alu_op <= PASS;
				selectors <= 17'b0_0000_0010_0000_0000;
				NEXT_COMMAND <= JPNZN2;
			end
		JPNZN2: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= AC;
				alu_op <= ADDAB;
				//SELECTORS <= 13'b0_0000_0100_0000;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		NOP: // Checked
			begin
				fetch <= 0;
				finish <= 0;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= FETCH1;
			end
		END: // Checked
			begin
				fetch <= 0;
				finish <= 1;
				b_bus_select <= DATA_FROM_RAM;
				alu_op <= ADDAB;
				selectors <= 17'b0_0000_0000_0000_0000;
				NEXT_COMMAND <= END;
			end
	endcase
	assign cmd = CONTROL_COMMAND;

endmodule
