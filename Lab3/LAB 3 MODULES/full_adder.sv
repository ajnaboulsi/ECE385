module full_adder (
	input	logic		   A, B,
	input	logic		   cin,
	output logic		S,
	output logic		cout,
	output logic		P, G
);
	
	always_comb
	begin
	
	P = A ^ B; // Propagrate
	G = A & B; // Generate
	S = A ^ B ^ cin; // Sum
	cout = (A & B) | (A & cin) | (B & cin); // Carry Out
	
	end
	
	
endmodule