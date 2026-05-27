module data_memory (
	input clk, WE,
	input [31:0] A, WD,
	
	output reg [31:0] RD
);

	reg [31:0] data_mem [10_000];
	
	always @(posedge clk)
	begin
		if (WE)
			data_mem[A[31:2]] <= WD;
	end

	always @(*)
	begin
		RD = data_mem[A[31:2]];
	end

endmodule