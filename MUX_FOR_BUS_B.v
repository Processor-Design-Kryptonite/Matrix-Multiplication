module MUX_FOR_BUS_B
	(
		// Inputs
		input [3:0] select,
		input [15:0] R1,R2,R3,AS,R,TR,TM,MR,AC,DATA_FROM_RAM,
		input [7:0] instructions,
		// Outputs
		output reg [15:0] bus
	);
	always @ (*) 
		begin
			case(select)
				4'd0: bus = DATA_FROM_RAM;
				4'd2: bus = R1;
				4'd3: bus = R2;
				4'd4: bus = R3;
				4'd5: bus = AS;
				4'd6: bus = TR;
				4'd7: bus = MR;
				4'd8: bus = R;
				4'd9: bus = AC;
				4'd10: bus = {8'b0000_0000, instructions};
				4'd12: bus = TM;
			endcase
		end
endmodule