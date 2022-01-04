module memory_clock_generator(
	input MAIN_CLOCK,
	output reg TICK = 1'b1
	);
	always @ (posedge MAIN_CLOCK)
		begin
			TICK = ~TICK;
		end
endmodule