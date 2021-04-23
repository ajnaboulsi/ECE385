module datapath (input						Clk, Reset, Run, LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
					  input						GatePC, GateMDR, GateALU, GateMARMUX, SR2MUX, ADDR1MUX, MARMUX, MIO_EN, DRMUX, SR1MUX,
					  input 						[1:0] PCMUX, ADDR2MUX, ALUK,
					  input 						[15:0] MDR_In,
					  output logic 			[15:0] MDR, MAR, IR, ProgramCnt,
					  output logic				BEN);
		
	//internal
	logic [15:0] PC, PC_Next, MAR_Next, MDR_Next, IR_Next, ALU, MARMUX_Out, BUS16, A, SR2M_I2, B, ADDR2M_Out, ADDR1M_Out;
	logic [3:0] gate;
	logic [2:0] DRM_Out, SR1M_Out, CC, CC_Next;
	logic BEN_Next;
	
	assign ProgramCnt = PC;
	assign MARMUX_Out = ADDR1M_Out + ADDR2M_Out;
		always_ff @ (posedge Clk)
			begin
				if (Reset)
					begin
					PC <= 16'h0000;
					CC <= 12'b000;
					BEN <= 16'h0000;
					MAR <= 16'h0000;
					MDR <= 16'h0000;
					IR <= 16'h0000;
					end
				else 
					begin
					PC <= PC_Next;
					MAR <= MAR_Next;
					MDR <= MDR_Next;
					IR <= IR_Next;
					BEN <= BEN_Next;
					CC <= CC_Next;
					end
			end
			
		always_comb 
			begin
				//////////////////GATE->BUS
				gate = {GatePC, GateMDR, GateALU, GateMARMUX};
				unique case (gate)
					4'b1000:
						BUS16 = PC;
					4'b0100:
						BUS16 = MDR;
					4'b0010:
						BUS16 = ALU;
					4'b0001:
						BUS16 = MARMUX_Out;
					default:
						BUS16 = 16'h0000;
				endcase
				
				//////////////////DRMUX
				unique case(DRMUX)
					1'b0:
						DRM_Out = IR[11:9];
					1'b1:
						DRM_Out = 3'b111;
				endcase
				
				//////////////////SR1MUX
				unique case(SR1MUX)
					1'b0:
						SR1M_Out = IR[8:6];
					1'b1:
						SR1M_Out = IR[11:9];
				endcase
				
				//////////////////SR2MUX
				unique case(SR2MUX)
					1'b0:
						B = SR2M_I2;
					1'b1:
						B = {{11{IR[4]}},IR[4:0]};
				endcase
				
				//////////////////ADDR2MUX
				unique case(ADDR2MUX)
					2'b00:
						ADDR2M_Out = 16'h0000;
					2'b01:
						ADDR2M_Out = {{10{IR[5]}}, IR[5:0]};
					2'b10:
						ADDR2M_Out = {{7{IR[8]}}, IR[8:0]};
					2'b11:
						ADDR2M_Out = {{5{IR[10]}}, IR[10:0]};
				endcase
				
				
				//////////////////ADDR1MUX
				unique case(ADDR1MUX)
					1'b0:
						ADDR1M_Out = PC;
					1'b1:
						ADDR1M_Out = A;
				endcase
				
				//////////////////////////ELSE CONDITIONS
				PC_Next = PC;
				MAR_Next = MAR;
				MDR_Next = MDR;
				IR_Next = IR;
				CC_Next = CC;
				BEN_Next = BEN;
				
				//////////////////PCMUX
				if (LD_PC)
					begin
						unique case (PCMUX)
							2'b00:
								PC_Next = PC+1;
							2'b01:
								PC_Next = ADDR1M_Out + ADDR2M_Out; //change week2
							2'b10:
								PC_Next = BUS16; //change week2
							2'b11:
								PC_Next = 16'bX; //change week2
						endcase
					end
					
				//////////////////MAR
				if (LD_MAR)
					MAR_Next = BUS16;
				
				//////////////////MDR
				if (LD_MDR)
					begin
						unique case (MIO_EN)
							1'b0:
								MDR_Next = BUS16;
							1'b1:
								MDR_Next = MDR_In;
						endcase
					end
				//////////////////IR
				if (LD_IR)
					IR_Next = BUS16;
					
				//////////////////NZP
				if (LD_CC)
					begin
						if(BUS16 == 16'h0000)
							CC_Next = 3'b010;
						else if(BUS16[15] == 1)
							CC_Next = 3'b100;
						else 
							CC_Next = 3'b001;
					end
					
				//////////////////BEN
				if (LD_BEN)
					begin
						if (IR[11:9] & CC)
							BEN_Next = 1'b1;
						else 
							BEN_Next = 1'b0;
					end
			end
			
		reg_file REG_FILE (.Clk(Clk), .LD_REG(LD_REG), .Reset(Reset), 
								 .DRM(DRM_Out), .SR1M(SR1M_Out), .SR2(IR[2:0]), 
								 .Data_In(BUS16), .SR1_Out(A), .SR2_Out(SR2M_I2));
	
		alu ALUNIT(.ALUK(ALUK), .A(A), .B(B), .ALU_Out(ALU));
		
endmodule

