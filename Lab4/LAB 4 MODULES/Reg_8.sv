module reg_8 (input  logic Clk, Shift, Shift_In, Load, clear,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
		 if (clear)
			  Data_Out <= 2'h00;
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift)
				begin
				Data_Out <= {Shift_In, Data_Out[7:1]}; 
				end
    end
	
	always_comb
	begin
			Shift_Out = Data_Out[0];
	end

endmodule
