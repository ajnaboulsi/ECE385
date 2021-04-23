module adder_9bit
(
	input logic [8:0] A, B,
	input logic SUB, ADD, M,
	output logic [8:0] S,
	output logic cout
);

	  logic [7:0] cin_; // Wires between full adders
	  logic [8:0] A_New, B_New;
	  always_comb
		begin
			if (SUB && ~ADD && M)
				begin
				B_New = B ^ 9'b111111111;
				A_New = A;
				end
			else if (ADD && ~SUB && M)
				begin
				A_New = A;
				B_New = B;
				end
			else 
				begin
				A_New = A;
				B_New = 9'b000000000;
				end
		end
		
		full_adder adder[8:0] (B_New, A_New, {cin_, SUB}, S, {cout, cin_});
		
endmodule
