module DRAM_ip (
	input clk,
	input en1,en2,en3,en4,write_en,
	input [15:0] data1,data2,data3,data4,
	output reg [15:0] data,
	output reg wren
	);
	
	always @ (*)
		begin
			wren <= write_en;
			if (en1)
				data <= data1;
			else if (en2)
				data <= data2;
			else if (en3)
				data <= data3;
			else if (en4)
				data <= data4;
		end 
endmodule 