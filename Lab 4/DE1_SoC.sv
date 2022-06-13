


// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW); 
output logic[6:0]    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic[9:0]    LEDR; 
 input  logic[3:0]    KEY;
 input  logic[9:0]SW; 
 
 // SW[9] is U, SW[8] is P, SW[7] is C. SW[0] is secret mark. 
 //Discounted light is LEDR[0]. 0 is not discount, 1 is discount
 //Stolen light is LEDR[4].0 is not stolen, 1 is stolen. 
 

 logic discountItem;
 logic andOut;
 
 and and1 (andOut, SW[9], SW[7]);
 or or1 (discountItem, andOut, SW[8]);

 assign LEDR[2] = discountItem;
 

 
 logic orOut;
 logic notU;
 logic andOut2;
 logic robbed; 
 
 or or2 (orOut, SW[0], SW[8]);
 not not2 (notU, SW[9]);
 and and2(andOut2, notU, SW[7]);
 nor nor2(robbed, orOut, andOut2);
 
  
 assign LEDR[5] = robbed; 
 
 always_comb  
	case(SW[9:7])
	
	3'b000: begin //SOFA
		HEX5 = 7'b0010010;
		HEX4 = 7'b1000000;
		HEX3 = 7'b0001110;
		HEX2 = 7'b0001000;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
	
	3'b001: begin   //Trash can
		HEX5 = 7'b1100010;
		HEX4 = 7'b1111111;
		HEX3 = 7'b1111111;
		HEX2 = 7'b1111111;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
	
	3'b011: begin //Ball
		HEX5 = 7'b0000110;
		HEX4 = 7'b0110110;
		HEX3 = 7'b0110000;
		HEX2 = 7'b1111111;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
	
	3'b100: begin //Nintendo Switch
		HEX5 = 7'b0100001;
		HEX4 = 7'b0111110;
		HEX3 = 7'b0000011;
		HEX2 = 7'b1111111;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
	
	3'b101: begin //Air Pods
		HEX5 = 7'b0011000;
		HEX4 = 7'b0011000;
		HEX3 = 7'b1111111;
		HEX2 = 7'b1111111;
		HEX1 = 7'b1111111;
		HEX0 = 7'b1111111;
	end
	
	3'b110: begin //Playing Cards
		HEX5 = 7'b1000000;
		HEX4 = 7'b1000000;
		HEX3 = 7'b1000000;
		HEX2 = 7'b1000000;
		HEX1 = 7'b1000000;
		HEX0 = 7'b1000000;
	end
	
	default: begin
		HEX5 = 7'bX;
		HEX4 = 7'bX;
		HEX3 = 7'bX;
		HEX2 = 7'bX;
		HEX1 = 7'bX;
		HEX0 = 7'bX;

	end
 endcase
 
 
 
 endmodule
 
 module DE1_SoC_testbench();
 logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
 logic  [9:0] LEDR; 
 logic  [3:0] KEY; 
 logic  [9:0] SW;
 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
 // Try all combinations of inputs.
 integer i;
 initial begin
 
 for(i = 0; i <1024; i++) begin
 
	SW[9:0] = i; #10;
 end
 
 end
 
 endmodule
 

 
