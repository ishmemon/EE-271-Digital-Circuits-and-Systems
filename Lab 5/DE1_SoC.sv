module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);   
 input  logic         CLOCK_50; // 50MHz clock.  
 output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
 output logic  [9:0]  LEDR;    
 input  logic  [3:0]  KEY; // True when not pressed, False when pressed  
 input  logic  [9:0]  SW;      
  
 // Generate clk off of CLOCK_50, whichClock picks rate.  
  
 logic reset; 
 logic [31:0] div_clk;  
  
 assign reset = ~KEY[0]; 
 //not not_gate (reset, KEY[0]);
 parameter whichClock = 25; // 0.75 Hz clock 
 clock_divider cdiv (.clock(CLOCK_50),  
                       .reset(reset),  
                       .divided_clocks(div_clk));   
  
 //  Clock  selection;  allows  for  easy  switching  between  simulation  and  board clocks 
 logic clkSelect; 
 // Uncomment ONE of the following two lines depending on intention 
  
 //assign clkSelect = CLOCK_50;          // for simulation 
 assign clkSelect = div_clk[whichClock]; // for board 
 
 // Set up FSM inputs and outputs.  
 logic sw0, sw1;
 logic [2:0] out;  
 assign sw0 = SW[0]; // input is SW[0] 
 assign sw1 = SW[1]; // next input is SW[1] 
   
 simple s (.clk(clkSelect), .reset, .sw0, .sw1, .out);
 // Show signals on LEDRs so we can see what is happening  
 assign LEDR[9] = clkSelect; 
 assign LEDR[8] = reset; 
 assign LEDR[2:0] = out; 
   
endmodule

module DE1_SoC_testbench();  
  logic         CLOCK_50;   
  logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
  logic  [9:0]  LEDR;     
  logic  [3:0]  KEY; 
  logic  [9:0]  SW;  
  
 DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);  
   
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  CLOCK_50 <= 0;  
  forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock 
 end  
   
 // Test the design. 
 initial begin   
      repeat(1) @(posedge CLOCK_50);  
  KEY[0] <= 0; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start  
  KEY[0] <= 1; repeat(1) @(posedge CLOCK_50); 
  SW[0]  <= 0; SW[1] <= 0; repeat(4) @(posedge CLOCK_50); // Test case 1: input is 0  
   
  SW[1]  <= 1; repeat(4) @(posedge CLOCK_50);
 
  SW[0]  <= 1; repeat(4) @(posedge CLOCK_50); 
  
  SW[1]  <= 0; repeat(4) @(posedge CLOCK_50); 
  $stop; // End the simulation.  
 end 
 
 endmodule 