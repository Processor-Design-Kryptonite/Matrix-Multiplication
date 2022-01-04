module IRegister(clk,data_in,data_out,write_en
    );
input clk,write_en;
input [7:0] data_in;
output [7:0] data_out;
reg [7:0] data_out=0;

	always @(posedge clk)
		begin
			if (write_en)
				data_out <= data_in;
		end

endmodule
