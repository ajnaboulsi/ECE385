module full_adder (
	input	logic		   A, B,
	input	logic		   cin,
	output logic		S,
	output logic		cout
);
	
	always_comb
	begin

	S = A ^ B ^ cin; // Sum
	cout = (A & B) | (A & cin) | (B & cin); // Carry Out
	
	end
	
endmodule