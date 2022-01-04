module cpu_clock_generator(
	input MAIN_CLOCK, PROCESS_FINISHED,
	output reg TICK = 1'b1
	);
	always @ (posedge MAIN_CLOCK)
		begin
			if (~PROCESS_FINISHED)
				TICK = ~TICK;
			else
				TICK = 1'b0;
		end
endmodule