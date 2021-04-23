//Two-always example for state machine

module control (input  logic Clk, Reset, Run,
                output logic Shift, ADD, SUB, Ld_Clr, ClrA);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {A,As, B,Bs, C,Cs, D,Ds, E,Es, F,Fs, G,Gs, H,Hs, I,Is, J, K}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
	 begin
				if(Reset)
					curr_state <= A;
				else
					curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (~Reset)
                       next_state = J;
            B :    next_state = Bs;
				Bs:    next_state = C;
            C :    next_state = Cs;
				Cs:    next_state = D;
            D :    next_state = Ds;
				Ds:    next_state = E;  
            E :    next_state = Es;
				Es:    next_state = F;
				F : 	 next_state = Fs;
				Fs:    next_state = G;
				G :    next_state = Gs;
				Gs:    next_state = H;  
				H :    next_state = Hs;
				Hs:    next_state = I;
				I :    next_state = Is;	
				Is:    next_state = J;
				J :	 if (Run)
							  next_state = K;  
				K:		 next_state = B;

							  
        endcase
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	   	   A: 
	         begin
                Shift = 1'b0;
					 Ld_Clr = 1'b1;
					 ADD = 1'b0;
					 SUB = 1'b0;
					 ClrA = 1'b0;
		      end
				
				B,C,D,E,F,G,H:
				begin 
					 Shift = 1'b0;
					 Ld_Clr = 1'b0;
					 ADD = 1'b1;
					 SUB = 1'b0;
					 ClrA = 1'b0;
				end
				
				Bs,Cs,Ds,Es,Fs,Gs,Hs,Is:
				begin 
					 Shift = 1'b1;
					 Ld_Clr = 1'b0;
					 ADD = 1'b0;
					 SUB = 1'b0;
					 ClrA = 1'b0;
				end
				
				I:
				begin 
					 Shift = 1'b0;
					 Ld_Clr = 1'b0;
					 ADD = 1'b0;
					 SUB = 1'b1;
					 ClrA = 1'b0;
				end
				
	   	   J: 
		      begin
                Shift = 1'b0;
					 Ld_Clr = 1'b0;
					 ADD = 1'b0;
					 SUB = 1'b0;
					 ClrA = 1'b0;
		      end
				
				K:
				begin 
					 Shift = 1'b0;
					 Ld_Clr = 1'b0;
					 ADD = 1'b0;
					 SUB = 1'b0;
					 ClrA = 1'b1;
				end
        endcase
    end

endmodule
