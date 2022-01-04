module DRAM_control(
	input clk,
	//input [7:0] address,
	input [15:0] address,
	input write_en,
	output reg en1, en2, //en3, en4,
	output reg [7:0] dram_address
	);
	
	localparam 
	START = 4'd0, DATA1 = 4'd1, DATA2 = 4'd2, DATA3 = 4'd3, DATA4 = 4'd4,
	STORE1 = 4'd5, STORE2 = 4'd6, STORE3 = 4'd7, STORE4 = 4'd8;

	reg [3:0] DRAM_COMMAND;
	reg [3:0] NEXT_COMMAND = START;
	
	
	wire AorB;
	wire [7:0] NorK;
	assign AorB = address[7]; // if A mat 1
	assign NorK = address[6:0];

	always @ (negedge clk) DRAM_COMMAND <= NEXT_COMMAND;
	//always @ (write_en) NEXT_COMMAND <= START;

	always @ (posedge clk)
		case(DRAM_COMMAND)
			START:
				begin
					dram_address <= address[15:8];
					NEXT_COMMAND <= (write_en) ? STORE1 : DATA1;
				end
			DATA1:
				begin
					en1 <= 1'b1;
					en2 <= 1'b0;
//					en3 <= 1'b0;
//					en4 <= 1'b0;
					NEXT_COMMAND <= (write_en) ? STORE1 : DATA2;
					//dram_address = dram_address + 7'd16;
					if (AorB)
						dram_address = dram_address + NorK;
					else 
						dram_address <= address[15:8];
				end
			DATA2:
				begin
					en1 <= 1'b0;
					en2 <= 1'b1;
//					en3 <= 1'b0;
//					en4 <= 1'b0;
					NEXT_COMMAND <= (write_en) ? STORE1 : START;
				end
					//dram_address = dram_address + 7'd16;
//					if (AorB)
//						dram_address = dram_address + NorK;
//					else 
//						dram_address <= address[15:8];
//				end
//			DATA3:
//				begin
//					en1 <= 1'b0;
//					en2 <= 1'b0;
//					en3 <= 1'b1;
//					en4 <= 1'b0;
//					NEXT_COMMAND <= (write_en) ? STORE1 : DATA4;
//					//dram_address = dram_address + 7'd16;
//					if (AorB)
//						dram_address = dram_address + NorK;
//					else 
//						dram_address <= address[15:8];
//				end
//			DATA4:
//				begin
//					en1 <= 1'b0;
//					en2 <= 1'b0;
//					en3 <= 1'b0;
//					en4 <= 1'b1;
//					NEXT_COMMAND <= (write_en) ? STORE1 : START;
//				end
			STORE1:
				begin
					en1 <= 1'b1;
					en2 <= 1'b0;
//					en3 <= 1'b0;
//					en4 <= 1'b0;
					NEXT_COMMAND <= (write_en) ? STORE2 : START;
					dram_address <= address[15:8];
				end
			STORE2:
				begin
					en1 <= 1'b0;
					en2 <= 1'b1;
//					en3 <= 1'b0;
//					en4 <= 1'b0;
					dram_address = dram_address + NorK;
					NEXT_COMMAND <= START;
				end
//			STORE3:
//				begin
//					en1 <= 1'b0;
//					en2 <= 1'b0;
//					en3 <= 1'b1;
//					en4 <= 1'b0;
//					NEXT_COMMAND <= (write_en) ? STORE4 : START;
//					dram_address = dram_address + NorK;
//				end
//			STORE4:
//				begin
//					en1 <= 1'b0;
//					en2 <= 1'b0;
//					en3 <= 1'b0;
//					en4 <= 1'b1;
//					dram_address = dram_address + NorK;
//					NEXT_COMMAND <= START;
//				end
		endcase

endmodule 