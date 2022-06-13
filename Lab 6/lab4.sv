//Attribution: This file is similar to one created by the UW Electrical Engineering Faculty.
module seg7 (bcd, leds); 
 input  logic  [3:0] bcd; 
 output logic  [6:0] leds; 
  
 always_comb begin 
  case (bcd) 
   //          Light: 6543210 
   4'b0000: leds = 7'b1000000; // 0 
   4'b0001: leds = 7'b1111001; // 1 
   4'b0010: leds = 7'b0100100; // 2 
   4'b0011: leds = 7'b0110000; // 3 
   4'b0100: leds = 7'b0011001; // 4 
   4'b0101: leds = 7'b0010010; // 5 
   4'b0110: leds = 7'b0000010; // 6 
   4'b0111: leds = 7'b1111000; // 7 
   4'b1000: leds = 7'b0000000; // 8 
   4'b1001: leds = 7'b0010000; // 9 
   default: leds = 7'bX; 
  endcase 
 end 
endmodule

module lab4 (HEX1, HEX0, SW);
	input logic [9:0] SW;
	output logic [6:0] HEX1, HEX0;
	seg7 sub1 (.bcd(SW[3:0]), .leds(HEX0));
	seg7 sub2 (.bcd(SW[7:4]), .leds(HEX1));

endmodule
	
 module lab4_testbench();
 logic  [6:0] HEX0, HEX1;  
 logic  [9:0] SW;
 lab4 dut (.HEX0, .HEX1, .SW);
 // Try all combinations of inputs.
 integer i;
 initial begin //Stimulus
 
 SW[9] = 1'b0;
 SW[8] = 1'b0;
 
 for(i = 0; i <256; i++) begin
 
	SW[7:0] = i; #10;
 end
 
 end
 
 endmodule

 

