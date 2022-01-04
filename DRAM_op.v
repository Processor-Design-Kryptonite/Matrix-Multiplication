module DRAM_op(
	input clk,
	input enable,
	input [15:0] q,
	output reg [15:0] data_out
	);
		
	always @ (*)
		begin
			if (enable)
				data_out <= q;
		end 
endmodule 