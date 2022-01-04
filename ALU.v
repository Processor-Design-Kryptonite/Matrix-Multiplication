module ALU
	(
		input [15:0] A_bus, B_bus,
		input [2:0] ALU_OP,
		output reg [15:0] C_bus,
		output reg FLAG_Z
	);
	parameter ADD = 3'd0, SUB = 3'd1, PASS = 3'd2, ZER = 3'd3, MUL = 3'd4, MULM = 3'd5;
	always @ (ALU_OP or A_bus or B_bus)
		begin
			case (ALU_OP)
				ADD:
					begin
						C_bus = A_bus + B_bus;
						FLAG_Z = 0;
					end
				SUB:
					begin
						C_bus = A_bus - B_bus;
						FLAG_Z = (A_bus == 16'd0) ? 1'b1 : 1'b0;
					end
				PASS:
					begin
						C_bus = B_bus;
						if (A_bus == 16'd0) FLAG_Z = 1;
					end
				ZER:
					begin
						C_bus = 0;
						FLAG_Z = 1;
					end
				MUL:
					begin
						C_bus = A_bus * B_bus;
						FLAG_Z = 0;
					end
					
				MULM: 
					begin
						C_bus = A_bus<<B_bus;
						FLAG_Z = 0;
					end
			endcase
		end
endmodule
