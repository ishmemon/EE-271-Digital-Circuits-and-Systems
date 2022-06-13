module lfsr (clk, Reset, q);
	input logic clk, Reset;
	output logic [9:0] q;


	
	
	logic xnorOut;
	xnor keep (xnorOut, q[9], q[6]);
	
	//always_ff @(posedge clk) begin
		//if (Reset) begin
			//q <= 10'b0000000000;
		//end
		
	flop f1 (.q(q[0]), .d(xnorOut), .clk, .Reset);
	flop f2 (.q(q[1]), .d(q[0]), .clk, .Reset);
	flop f3 (.q(q[2]), .d(q[1]), .clk, .Reset);
	flop f4 (.q(q[3]), .d(q[2]), .clk, .Reset);
	flop f5 (.q(q[4]), .d(q[3]), .clk, .Reset);
	flop f6 (.q(q[5]), .d(q[4]), .clk, .Reset);
	flop f7 (.q(q[6]), .d(q[5]), .clk, .Reset);
	flop f8 (.q(q[7]), .d(q[6]), .clk, .Reset);
	flop f9 (.q(q[8]), .d(q[7]), .clk, .Reset);
	flop f10 (.q(q[9]), .d(q[8]), .clk, .Reset);
endmodule 


module lfsr_testbench();
	logic clk, Reset;
	logic [9:0] q;
	
	 lfsr dut (clk, Reset, q);  
   
 // Set up a simulated clk.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clk 
 end 
	
	 initial begin  
                      @(posedge clk);   
  Reset <= 1;         @(posedge clk); // Always reset FSMs at start  
  Reset <= 0; @(posedge clk);   
                     @(posedge clk);   
                      @(posedge clk); 
				       @(posedge clk);
                      @(posedge clk);
				          @(posedge clk);			 
            Reset <= 1; @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);   
            Reset <= 0; @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);
				Reset <= 0; @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);
				    @(posedge clk);
                      @(posedge clk);
				          @(posedge clk);			 
               @(posedge clk);   
                      @(posedge clk);   
                      @(posedge clk);   
            
  $stop; // End the simulation.  
 end  
endmodule 