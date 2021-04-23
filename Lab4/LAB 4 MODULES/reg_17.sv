module reg_17 (input					Clk, Ld_Clr, Shift, ClrA, Shift_In,
					input						[8:0] D,
					output logic			Shift_Out,
					output logic 			[16:0] Data_Out);
					
//		always_ff @ (posedge Clk)
//		begin
//				if(Load)
//					Data_Out <= D;
//				else if (Shift)
//					begin
//					Data_Out <= { Shift_In, Data_Out[7:1] }; 
//					end
//		end
		
endmodule