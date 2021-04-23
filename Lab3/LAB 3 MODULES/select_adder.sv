module select_adder (
	input  [15:0] A, B,
	input         cin,
	output [15:0] S,
	output        cout
);
	
	logic [2:0] cout_0, cout_1, C;
	logic [11:0] S_0, S_1;
	
	always_comb
	begin
		C[1] = cout_0[0] | (cout_1[0] & C[0]);
		C[2] = cout_0[1] | (cout_1[1] & C[1]);
		cout = cout_0[2] | (cout_1[2] & C[2]);
		
		S[15:4] = {
						C[2] ? S_1[11:8] : S_0[11:8],
						C[1] ? S_1[7:4] : S_0[7:4],
						C[0] ? S_1[3:0] : S_0[3:0]
					 };
		
	end
	
	ripple_adder_4 adder_first			(
													.A(A[3:0]),
													.B(B[3:0]),
													.cin(1'b0),
													.S(S[3:0]),
													.cout(C[0])
												);
												
	ripple_adder_4 adder_0 [2:0]		(
													.A(A[15:4]),
													.B(B[15:4]),
													.cin(1'b0),
													.S(S_0),
													.cout(cout_0)
												);
										
	ripple_adder_4 adder_1 [2:0]		(
													.A(A[15:4]),
													.B(B[15:4]),
													.cin(1'b1),
													.S(S_1),
													.cout(cout_1)
												);
	
endmodule
