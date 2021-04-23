
module Processor (input logic   Clk,     
                                Reset_LdClr,   
                                Run, 
                  input  logic [7:0]  SW,     // input data
                  output logic [7:0]  Aval,Bval,
                  output logic [6:0] HEX0, HEX1, HEX2, HEX3,
						output logic Xval);

	 //local logic variables go here
	 logic Reset_LdClr_SH, Run_SH, Shift, A_Sout, M, X, ADD, SUB, Ld_Clr, ClrA;
	 logic [7:0] A,Aadd, B;
	 always_comb
	 begin
		 Xval = X;
		 Aval = A;
		 Bval = B;
	 end
	 
	 //Instantiation of modules here
	 reg_8    			regA (
								   .Clk(Clk),
									.Shift(Shift),
									.Shift_In(X), 
									.clear(Ld_Clr|| ClrA),
									.Load(ADD || SUB),
									.D(Aadd),
									
									.Shift_Out(A_Sout),
									.Data_Out(A)
									);
									
	 reg_8    			regB (
									.Clk(Clk),
									.Shift(Shift),
									.Shift_In(A_Sout), 
									.Load(Ld_Clr),
									.D(SW),
									
									.Data_Out(B)
									);
											
    adder_9bit       adder (
									 .A({A[7], A[7:0]}),
									 .B({SW[7], SW[7:0]}),
									 .SUB(SUB),
									 .ADD(ADD),
									 .M(B[0]),
									 
									 .S({X, Aadd})
									 );
		
	 control          control_unit (
											  .Clk(Clk),
											  .Reset(Reset_LdClr_SH),
											  .Run(Run_SH),
											  
											  .Shift(Shift),
											  .ADD(ADD),
											  .SUB(SUB),
											  .Ld_Clr(Ld_Clr),
											  .ClrA(ClrA)
											  );
											  
	 HexDriver        Hex0 (
                        .In0(Aval[7:4]),
                        .Out0(HEX0));
	 HexDriver        Hex1 (
                        .In0(Aval[3:0]),
                        .Out0(HEX1));
								
	 HexDriver        Hex2 (
                        .In0(Bval[7:4]),
                        .Out0(HEX2));	
	 HexDriver        Hex3 (
                        .In0(Bval[3:0]),
                        .Out0(HEX3));
				
    sync res(Clk, ~Reset_LdClr, Reset_LdClr_SH);
	 sync run(Clk, ~Run, Run_SH);
	 
endmodule
