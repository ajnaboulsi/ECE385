module reg_file (input			Clk, LD_REG, Reset,
					  input 			[2:0]	DRM, SR1M, SR2,
					  input 			[15:0] Data_In, 
					  output logic	[15:0] SR2_Out, SR1_Out);
		logic [7:0] LD;
		logic [15:0] D_Out [7:0];
		logic [15:0] D_In [7:0];
		
		always_comb 
			begin
				LD = LD_REG << DRM;
				D_In[DRM] = Data_In;
				SR1_Out = D_Out[SR1M];
				SR2_Out = D_Out[SR2];
			end
		
		reg_16 registers [7:0](.Clk(Clk), .Load(LD), .D(D_In), .Data_Out(D_Out));
endmodule

module reg_16 (input					   Clk, Load, Reset,
					input						[15:0] D,
					output logic 			[15:0] Data_Out );
					
		always_ff @ (posedge Clk)
		begin
				if (Reset)
					Data_Out <= 8'h0;
				// Loading D into register when load button is pressed (will eiher be switches or result of sum)
				else if(Load)
					Data_Out <= D;
		end
		
endmodule

