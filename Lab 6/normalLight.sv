module normalLight (Clock, Reset, L, R, NL, NR, lightOn); 
 input logic Clock, Reset; 
 
   // L is true when left key is pressed, R is true when the right key 
 // is pressed, NL is true when the light on the left is on, and NR 
 // is true when the light on the right is on.  
 input logic L, R, NL, NR; 
 
 output logic lightOn;
 
 enum { on, off } ps, ns;
// Next State logic  
				 always_comb begin  
				  case (ps)  
					on: if ((~L&R) | (L&~R)) ns = off;
					else ns = on;
					//if ((NR == 0) & (NL == 0) & (L == 0) & (R == 0)) ns = on; 
						//else if (R&L) ns = on;	
						//else ns = off; 
					off: if ((NR & L) | (NL & R)) ns = on;
						else ns = off;
				  endcase  
				 end 

	
	
 // Output logic - could also be another always_comb block. 
 
 assign lightOn = (ps == on); 
 
 
   // DFFs  
 always_ff @(posedge Clock) begin  
  if (Reset)   
    ps <= off;
  else  
   ps <= ns;  
 end
 
 // Your code goes here!! 
 //FSM design
endmodule 

 module normalLight_testbench();  
 logic  Clock, Reset, L, R, NL, NR;  
 logic  lightOn;  
  
 normalLight dut (Clock, Reset, L, R, NL, NR, lightOn);   
   
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
  Reset <= 0; L <= 0; R <= 0; NL <= 0; NR <= 0; @(posedge Clock);   
                     @(posedge Clock);   
                      @(posedge Clock); 
				NR <= 1; @(posedge Clock);
                      @(posedge Clock);
				          @(posedge Clock);			 
            NL <= 1; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);   
            NR <= 1; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);
				R <= 1; NL <= 0; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);
				NR <= 1; @(posedge Clock);
                      @(posedge Clock);
				          @(posedge Clock);			 
            NL <= 1; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);   
            NR <= 1; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);
				L <= 1; R <= 0; NL <= 0; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);	
				NR <= 1; @(posedge Clock);
                      @(posedge Clock);
				          @(posedge Clock);			 
            NL <= 1; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);   
            NR <= 1; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);
				R <= 1; NL <= 0; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);
				NR <= 1; @(posedge Clock);
                      @(posedge Clock);
				          @(posedge Clock);			 
            NL <= 1; NR <= 0; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);   
            NR <= 1; @(posedge Clock);   
                      @(posedge Clock);   
                      @(posedge Clock);			 
   
  $stop; // End the simulation.  
 end  
endmodule  
