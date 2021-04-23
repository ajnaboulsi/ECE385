module lookahead_adder (
	input logic [15:0]  A, B,
	input logic         cin,
	output logic [15:0] S,
	output logic        cout
);

	logic [15:0] P, G;
	logic [15:0] full_adder_cin;
	logic [3:0] lookahead_cin;
	logic [3:0] PG, GG;

	full_adder full_adder [15:0] ( 
											.A(A),
											.B(B), 
											.cin({full_adder_cin[14:0], cin}), 
											.S(S),
											.P(P), 
											.G(G) 
										 );
	
	
	lookahead_carry_unit_4 lookahead [3:0] ( 
														  .P(P), 
														  .G(G), 
														  .cin({lookahead_cin[2:0], cin}), 
														  .cout(full_adder_cin), 
														  .PG(PG), 
														  .GG(GG) 
														);
														
	lookahead_carry_unit_4 lookahead_16 (
													  .P(PG),
													  .G(GG),
													  .cin(cin),
													  .cout(lookahead_cin),
													);
	
	assign cout = lookahead_cin[3];

endmodule
