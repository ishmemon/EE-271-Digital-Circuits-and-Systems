module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);   
	input  logic         CLOCK_50;                          // 50MHz clock.  
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;    
	input  logic  [3:0]  KEY;                               // True when not pressed, False when pressed  
	input  logic  [9:0]  SW;      
  

   logic reset;
   logic L, R; 
 
  
   assign reset = SW[9]; 
 
   //Set all the default values of the Hex's make them all blank except for HEX0.
   assign HEX1 = 7'b1111111; 
   assign HEX2 = 7'b1111111; 
   assign HEX3 = 7'b1111111; 
   assign HEX4 = 7'b1111111; 
   assign HEX5 = 7'b1111111; 
 
 
   //Then I call the FSM machines there are two 
   inputProcess i1(.clk(CLOCK_50), .reset(reset), .L(~KEY[3]), .R(~KEY[0]), .nextL(L), .nextR(R));
   playGame winner(.Clock(CLOCK_50), .Reset(SW[9]), .L(L), .R(R), .lights(LEDR[9:1]), .numbers(HEX0));
	
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
					@(posedge CLOCK_50);
  SW[9] <= 1; @(posedge CLOCK_50); // Always reset FSMs at start 
  
  //First I go 6 times to the left, I press the left button 6 times basically
  SW[9] <= 0; KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                       @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
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
							 
	
	
	
 //First I go 6 times to the right, I press the right button 6 times basically   
 SW[9] <= 1; @(posedge CLOCK_50); 
  SW[9] <= 0; KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
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
				

  //Then I just do a mix of left and right and press KEY0 a few times and KEY3 
  //a few times.  
  SW[9] <= 1; @(posedge CLOCK_50); 
  SW[9] <= 0; KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);  
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
							 
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 
					KEY[0]  <= 0; KEY[3] <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
  //SW[9] <= 0; KEY[0] <= 1; KEY[3] <= 0; @(posedge CLOCK_50); 
	//								@(posedge CLOCK_50);
  //KEY[0] <= 0; KEY[3] <= 1; @(posedge CLOCK_50); 
	//								@(posedge CLOCK_50);	
  //KEY[0] <= 1; KEY[3] <= 0; @(posedge CLOCK_50); 
	//								@(posedge CLOCK_50);
		//							@(posedge CLOCK_50);
	//KEY[0] <= 0; KEY[3] <= 1; @(posedge CLOCK_50);
	//KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50); 
		//							@(posedge CLOCK_50);
			//						@(posedge CLOCK_50);
	//KEY[0]  <= 1; KEY[3] <= 0; @(posedge CLOCK_50); 
		//							@(posedge CLOCK_50);
			//						@(posedge CLOCK_50);

  
  
  $stop; // End the simulation.  
 end 
 
 endmodule 