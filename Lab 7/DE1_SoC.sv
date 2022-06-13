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

//Divide clocks here
	logic [31:0] div_clk; 	
   parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
   logic clk;
   assign clk = div_clk[whichClock];	
							  
//Logic to find out the computer button press, I need to make KEY3 change to be the computer's press
	logic [9:0] proxy;
	assign proxy[0] = 0;
	
	
	
	//this was the old code I am going to add changed below to account for the metastability of the flip flops
	/*assign proxy[1] = SW[0];
	assign proxy[2] = SW[1];
	assign proxy[3] = SW[2];
	assign proxy[4] = SW[3];
	assign proxy[5] = SW[4];
	assign proxy[6] = SW[5];
	assign proxy[7] = SW[6];
   assign proxy[8] = SW[7];
	assign proxy[9] = SW[8];*/
	
	logic [8:0] store; 
	flop f1(.q(store[0]), .d(SW[0]), .clk, .Reset(reset));
	flop f2(.q(store[1]), .d(SW[1]), .clk, .Reset(reset));
	flop f3(.q(store[2]), .d(SW[2]), .clk, .Reset(reset));
	flop f4(.q(store[3]), .d(SW[3]), .clk, .Reset(reset));
	flop f5(.q(store[4]), .d(SW[4]), .clk, .Reset(reset));
	flop f6(.q(store[5]), .d(SW[5]), .clk, .Reset(reset));
	flop f7(.q(store[6]), .d(SW[6]), .clk, .Reset(reset));
	flop f8(.q(store[7]), .d(SW[7]), .clk, .Reset(reset));
	flop f9(.q(store[8]), .d(SW[8]), .clk, .Reset(reset));
	
	flop f1_2(.q(proxy[1]), .d(store[0]), .clk, .Reset(reset));
	flop f2_2(.q(proxy[2]), .d(store[1]), .clk, .Reset(reset));
	flop f3_2(.q(proxy[3]), .d(store[2]), .clk, .Reset(reset));
	flop f4_2(.q(proxy[4]), .d(store[3]), .clk, .Reset(reset));
	flop f5_2(.q(proxy[5]), .d(store[4]), .clk, .Reset(reset));
	flop f6_2(.q(proxy[6]), .d(store[5]), .clk, .Reset(reset));
	flop f7_2(.q(proxy[7]), .d(store[6]), .clk, .Reset(reset));
	flop f8_2(.q(proxy[8]), .d(store[7]), .clk, .Reset(reset));
	flop f9_2(.q(proxy[9]), .d(store[8]), .clk, .Reset(reset));
	
	
	
	
	
	logic [9:0] lfsrOut;
	lfsr find(.clk, .Reset(reset), .q(lfsrOut));
	logic compare;
	comparator compareValue(.clk, .inputA(proxy), .inputB(lfsrOut), .out(compare));
	
//To implement the computer player thing, all I do is change the L(L) to the L(proxy) L(compare)
 
   //Then I call the FSM machines there are two 
   inputProcess i1(.clk(clk), .reset(reset), .L(~KEY[3]), .R(~KEY[0]), .nextL(L), .nextR(R));
	//the leftWin is on the HEX5 and the rightWin is on the HEX0
   playGame winner(.Clock(clk), .Reset(SW[9]), .L(compare), .R(R), .lights(LEDR[9:1]), .leftWin(HEX5), .rightWin(HEX0));
	
endmodule
	
//This one still needs to be fixed. 
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
  SW[9] <= 0; KEY[0]  <= 1; SW[8:0] = i; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 
					KEY[0]  <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1; @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
                     @(posedge CLOCK_50);   
                      @(posedge CLOCK_50);
					KEY[0]  <= 0; @(posedge CLOCK_50);
					KEY[0]  <= 1;  @(posedge CLOCK_50);
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
				
				
				
	  end
  
  $stop; // End the simulation.  
 end 
 
 endmodule 