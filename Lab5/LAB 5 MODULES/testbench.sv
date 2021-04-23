module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
	logic [9:0] SW;
	logic	Clk;
	logic Run;
	logic Continue;
	logic [9:0] LED;
	logic [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
			
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
slc3_testtop slc3_sim(.*);	

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS	
Run = 0;
Continue = 0;
SW = 10'b0000001011;		
#2 Continue = 1;
Run = 1;
#8 Run = 0;
#2 Run = 1;
#100 SW = 10'b0001011011;	
#150 SW = 10'b0001110111;	
#150 SW = 10'b0001000001;	


end
endmodule