module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, GPIO_1, SW);   
	input  logic         CLOCK_50;                          // 50MHz clock.  
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;
    output logic [35:0] GPIO_1;	
	input  logic  [3:0]  KEY;                               // True when not pressed, False when pressed  
	input  logic  [9:0]  SW;      
  
		logic [31:0] div_clk;
   logic reset;
   logic L, R;
	logic [7:0] inputKey;
	   logic clk;
 	 logic SYSTEM_CLOCK;
  
   assign reset = SW[9];



	logic oneWin;	
	
	
	
	
	
	
		 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
 
   //Set all the default values of the Hex's make them all blank except for HEX0.
   assign HEX1 = 7'b1111111; 
   assign HEX2 = 7'b1111111; 
   assign HEX3 = 7'b1111111; 
   assign HEX4 = 7'b1111111;

//Divide clocks here 	
   parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
   assign clk = div_clk[whichClock];	
	
	
	//New copied code to make the lights light up
		 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 //logic [31:0] clk;
	 
	 //clock_divider divider (.clock(CLOCK_50), .reset(reset), .divided_clocks(clk));
	 
	 //assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 assign SYSTEM_CLOCK = div_clk[14];
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */

	 
	 //assign RST = ~KEY[0];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(reset), .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 KEY0      : Reset
		 =================================================================== */
					  
							  
								  
							  
							  
							  
							  
							  
							  
							  
										  
							  
//Logic to find out the computer button press, I need to make KEY3 change to be the computer's press
	
	/*logic [3:0] proxy;

	logic [3:0] store; 
	flop f1(.q(store[0]), .d(~KEY[0]), .clk, .Reset(reset));
	flop f2(.q(store[1]), .d(~KEY[1]), .clk, .Reset(reset));
	flop f3(.q(store[2]), .d(~KEY[2]), .clk, .Reset(reset));
	flop f4(.q(store[3]), .d(~KEY[3]), .clk, .Reset(reset));
	
	flop f1_2(.q(proxy[0]), .d(store[0]), .clk, .Reset(reset));
	flop f2_2(.q(proxy[1]), .d(store[1]), .clk, .Reset(reset));
	flop f3_2(.q(proxy[2]), .d(store[2]), .clk, .Reset(reset));
	flop f4_2(.q(proxy[3]), .d(store[3]), .clk, .Reset(reset));*/
	
	
	
	
	
	
	//logic [1:0] proxy;

	//logic [1:0] store; 
	//flop f1(.q(store[0]), .d(SW[0]), .clk, .Reset(reset));
	//flop f2(.q(store[1]), .d(SW[1]), .clk, .Reset(reset));
	
	//flop f1_2(.q(proxy[0]), .d(store[0]), .clk, .Reset(reset));
	//flop f2_2(.q(proxy[1]), .d(store[1]), .clk, .Reset(reset));
	
	//logic alternate; 
	//The first player's turn is determined by the switch being SW1, SW0 being 10 and
	//the second one's turn is determined by it being 00 (or 11). 
	//assign alternate = ((~proxy[0]) & proxy[1]);
	
	
	
	inputProcess i1(.Clock(SYSTEM_CLOCK), .reset(reset), .L(SW[8]), .R(SW[7]), .nextL(inputKey[3]), .nextR(inputKey[2]));
	inputProcess i2(.Clock(SYSTEM_CLOCK), .reset(reset), .L(SW[6]), .R(SW[5]), .nextL(inputKey[1]), .nextR(inputKey[0]));
	inputProcess i3(.Clock(SYSTEM_CLOCK), .reset(reset), .L(SW[3]), .R(SW[2]), .nextL(inputKey[7]), .nextR(inputKey[6]));
	inputProcess i4(.Clock(SYSTEM_CLOCK), .reset(reset), .L(SW[1]), .R(SW[0]), .nextL(inputKey[5]), .nextR(inputKey[4]));
	
	
	//LED_test test (.clk(SYSTEM_CLOCK), .RST((reset|oneWin)), .RedPixels, .GrnPixels, .inputKey(proxy));
	LED_test test (.clk(SYSTEM_CLOCK), .RST((reset|oneWin)), .RedPixels, .GrnPixels, .inputKey, .SW(SW[1:0]));
	
	
	//fallingDownRed onePlayer (.RST(reset), .RedPixels, .GrnPixels, .inputKey(proxy));
	displayWin winner (.clk(SYSTEM_CLOCK), .RST(reset), .RedPixels, .GrnPixels, .outputRed(HEX0), .outputOrange(HEX5), .oneWin);
	 
	
//To implement the computer player thing, all I do is change the L(L) to the L(proxy) L(compare)
 
   //Then I call the FSM machines there are two 
   //inputProcess i1(.clk(clk), .reset(reset), .L(~KEY[3]), .R(~KEY[0]), .nextL(L), .nextR(R));
	//the leftWin is on the HEX5 and the rightWin is on the HEX0
   //playGame winner(.Clock(clk), .Reset(SW[9]), .L(L), .R(R), .lights(LEDR[9:1]), .leftWin(HEX5), .rightWin(HEX0));
	     //displayWin disp();
	
endmodule
	 
module DE1_SoC_testbench();  
  logic         CLOCK_50;   
  logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
  logic  [9:0]  LEDR;
  logic [35:0] GPIO_1;  
  logic  [3:0]  KEY; 
  logic  [9:0]  SW;  
  
 DE1_SoC dut12 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, GPIO_1, SW);  
   
 // Set up a simulated clock.   
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   CLOCK_50 <= 0;    
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; 
	end 
 
   
 // Test the design.
integer i; 
 initial begin   
  //    repeat(1) @(posedge CLOCK_50);  
  //SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start  
  //SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 
  //KEY[0]  <= 0; KEY[3] <= 1; repeat(5) @(posedge CLOCK_50); // Test case 1: win by going left only  
   
  //SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start  
  //SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 
  //KEY[0]  <= 1; KEY[3] <= 0; repeat(5) @(posedge CLOCK_50); // Test case 2: win by going right only
  
  //SW[9] <= 1; repeat(1) @(posedge CLOCK_50); // Always reset FSMs at start  
  //SW[9] <= 0; repeat(1) @(posedge CLOCK_50); 
  //KEY[0]  <= 1; KEY[3] <= 0; repeat(2) @(posedge CLOCK_50); // Test case 3: Win by going right and left right and left
  //KEY[0]  <= 0; KEY[3] <= 1; repeat(2) @(posedge CLOCK_50); //but end at right
  //KEY[0] <= 1; KEY[3] <= 0; repeat(3) @(posedge CLOCK_50);
  //KEY[0] <= 0; KEY[3] <= 1; repeat(1) @(posedge CLOCK_50);
  //KEY[0]  <= 1; KEY[3] <= 0; repeat(3) @(posedge CLOCK_50); //At this point we have won but I will also test the edge case and see
  //KEY[0]  <= 1; KEY[3] <= 0; repeat(3) @(posedge CLOCK_50);	//what happens if we keep going
  //I think according to Modelsim if we keep going the lights just turn off. 
  
  //I will try rewriting the testbench in the diff format.
	
 //First I go 6 times to the right, I press the right button 6 times basically 
 //With the computer setting being 000000000, 000000001, 000000010, and so on.

 
	for(i = 0; i <512; i++) begin
 SW[9] <= 1; @(posedge CLOCK_50); 
  SW[9] <= 0; SW[8:0] = i; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
               
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
	                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					
					//I set the value back to 0 this way it ensures that the next time
					//the button is pressed again so it actually causes a change
					SW[8:0] = 9'b000000000; @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 

				
				
	  end

  
  $stop; // End the simulation.  
 end 
 
 endmodule 