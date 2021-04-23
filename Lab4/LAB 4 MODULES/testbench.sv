module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic	Reset_LdClr, Run; 
logic [7:0]  SW;     
logic [7:0]  Aval,Bval;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic Xval;

// To store expected results
//logic [16:0] ans;
			
		
// Instantiating the DUT
// Make sure the module and signal names match with those in your design
Processor processor0(.*);	

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
Reset_LdClr = 0;	
Run = 1;
SW = 8'b11000101;		

#2 Reset_LdClr = 1;

#20 SW = 8'b00000111;
#2 Run = 0;
#2 Run = 1;


end
endmodule
