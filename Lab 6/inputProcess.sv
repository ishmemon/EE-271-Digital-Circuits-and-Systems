module inputProcess (clk, reset, L, R, nextL, nextR);
   input logic          clk, reset, L, R;
	
	
	
	output logic            nextL, nextR;
	
	key le (.clk, .reset, .key(L), .out(nextL));
	key ri (.clk, .reset, .key(R), .out(nextR));
	
endmodule

module inputProcess_testbench();  
  logic  Clock, Reset, L, R;  
  logic  nextL, nextR;  
  
  inputProcess dut (Clock, Reset, L, R, nextL, nextR);   
   
  // Set up a simulated clock.   
  parameter CLOCK_PERIOD=100;  
  initial begin  
    Clock <= 0;  
  forever #(CLOCK_PERIOD/2) Clock <= ~Clock; // Forever toggle the clock 
  end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
                      @(posedge Clock);   
  Reset <= 1;         @(posedge Clock); // Always reset FSMs at start  
  Reset <= 0; L <= 0; R <= 0; @(posedge Clock);   
                     @(posedge Clock);   
                      @(posedge Clock); 
				R <= 1; @(posedge Clock);
                      @(posedge Clock);    
				          @(posedge Clock);			 
            L <= 1; @(posedge Clock);   
                      @(posedge Clock);     
                      @(posedge Clock);
			   R <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);		 
 		 
   	   		
		$stop;
   end	
endmodule