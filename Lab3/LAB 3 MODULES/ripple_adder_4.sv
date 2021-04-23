module ripple_adder_4
(
	input  [3:0] A, B,
	input         cin,
	output [3:0] S,
	output        cout
);

	  logic [2:0] cin_; // Wires between full adders
	  
	  full_adder adder[3:0] (A, B, {cin_, cin}, S, {cout, cin_});

     
endmodule
