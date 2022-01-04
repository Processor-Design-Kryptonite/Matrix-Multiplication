module Register(clk,data_in,data_out,write_en,increase
    );
input clk,write_en;
input increase;
input [15:0] data_in;
output [15:0] data_out;
reg [15:0] data_out=0;

	always @(posedge clk)
		begin
			if (write_en)
				data_out <= data_in;
			if (increase)
				data_out <= data_out +1;
		end

endmodule


