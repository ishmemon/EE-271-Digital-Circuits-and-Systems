module inputProcess (Clock, reset, L, R, nextL, nextR);
   input logic          Clock, reset;
	
	
	input logic                       L, R;
	//I am going to change the inputProcess to only set the R input since the left is already dealt with in DE1_Soc. 
	
	
	output logic            nextL;
   output logic       	nextR;
	
	key le (.clk(Clock), .RST(reset), .key(L), .out(nextL));
	key ri (.clk(Clock), .RST(reset), .key(R), .out(nextR));
	
endmodule

module inputProcess_testbench();  
  logic  Clock, reset, L, R;  
  logic  nextL, nextR;  
  
  inputProcess dut13 (Clock, reset, L, R, nextL, nextR);   
   
  // Set up a simulated clock.   
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   Clock <= 0;    
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock; 
	end 
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
    reset <= 1; @(posedge Clock); 
    reset <= 0; L <= 0; R <= 0; @(posedge Clock);
                     @(posedge Clock);   
                      @(posedge Clock);
                     
			L <= 1; @(posedge Clock);   
                      @(posedge Clock); 
							                      @(posedge Clock);   
                      @(posedge Clock);
							                      @(posedge Clock);   
                R <= 1;      @(posedge Clock);
							                      @(posedge Clock);   
                      @(posedge Clock);
							                      @(posedge Clock);   
                      @(posedge Clock);
							                      @(posedge Clock);   
                 L <= 0; @(posedge Clock);
		$stop;
   end	
endmodule