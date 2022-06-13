module simple (clk, reset, sw0, sw1, out);   
 input  logic  clk, reset, sw0, sw1;   
 output logic [2:0] out;   
 
 // State variables 
 enum { calm, ltor, rtol, calm2, ltor2, ltor3, rtol2, rtol3 } ps, ns;  
  
 // Next State logic  
 always_comb begin  
  case (ps)  
   calm:   if (sw0)  ns = rtol; 
		else if (sw1) ns = ltor;
      else  ns = calm2;
	calm2: ns = calm;
   ltor:  if (sw1)  ns = ltor2;  
      else  ns = calm;  
   ltor2: ns = ltor3;
	ltor3: ns = ltor;
	rtol:  if (sw0)  ns = rtol2;  
      else  ns = calm;  
	rtol2: ns = rtol3;
	rtol3: ns = rtol;
  endcase  
 end  
   
 // Output logic - could also be another always_comb block. 
 //assign out = ps;  
 always_comb begin
  case (ns)
   calm: out = 3'b010;
	calm2: out = 3'b101;
	ltor2: out = 3'b010;
	ltor: out = 3'b100;
	ltor3: out = 3'b001;
	rtol: out = 3'b001;
	rtol2: out = 3'b010;
	rtol3: out = 3'b100;
	endcase
  end
	
 
 // DFFs  
 always_ff @(posedge clk) begin  
  if (reset)   
    ps <= calm2;
	 //ns <= calm2;
		
  else  
   ps <= ns;  
 end
 
 endmodule
 
 module simple_testbench();  
 logic  clk, reset, sw0, sw1;  
 logic  out;  
  
 simple dut (clk, reset, sw0, sw1, out);   
   
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
                      @(posedge clk);   
  reset <= 1;         @(posedge clk); // Always reset FSMs at start  
  reset <= 0; sw0 <= 0; sw1 <= 0; @(posedge clk);   
                     @(posedge clk);   
                      @(posedge clk); 
				sw1 <= 1; @(posedge clk);
                      @(posedge clk);
				          @(posedge clk);			 
            sw0 <= 1; @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);   
            sw1 <= 0; @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);   
   
  $stop; // End the simulation.  
 end  
endmodule  