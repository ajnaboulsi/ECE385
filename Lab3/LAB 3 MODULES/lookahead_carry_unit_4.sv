module lookahead_carry_unit_4 (
	input logic [3:0]   P, G,
	input logic    	  cin,
	output logic [3:0]  cout,
	output logic		  PG, GG
);

	always_comb
	begin
	
	cout[0] = cin & P[0] | G[0];
	cout[1] = cin & P[0] & P[1] | G[0] & P[1] | G[1];
	cout[2] = cin & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G[1] & P[2] | G[2];
	cout[3] = cin & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];
	
	PG = P[0] & P[1] & P[2] & P[3];
	GG = G[3] | G[2] & P[3] | G[1] & P[3] & P[2] | G[0] & P[3] & P[2] & P[1];
	
	end
	  

endmodule
