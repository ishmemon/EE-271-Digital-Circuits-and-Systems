module comparator (clk, inputA, inputB, out);
	input logic clk;
	input logic [9:0] inputA, inputB;
	output logic out;
	
	logic [9:0] difference;
	assign difference = inputA - inputB;

	always_comb begin
		if (inputA > inputB) begin
		//if (difference > 10'b0000000000) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end
	
	//difference = inputA - inputB;
	
	//always_comb begin
	  // if (inputA[0] == 1 & inputB[0] == 0) begin
		//	out = 0;
		//end else if (inputB[0] == 1 & inputA[0] == 0) begin
			//out = 1;
		//end else if (inputB[0] == 1 & inputA[0] == 1) begin
			////They both are negative we should just compare magnitudes 
			//inputB = (~inputB) + 1;
			//inputA = (~inputA) + 1;
			//if (inputB[8:0] > inputA[8:0]) 
			
		//end else begin
			//out = 0;
		//end
	
	//end
	
endmodule 

 module comparator_testbench();  
 logic  clk; 
 logic [9:0] inputA, inputB;  
 logic  out;  
  
 comparator dut (clk, inputA, inputB, out);   
   
 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin  
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 initial begin  
                      @(posedge clk);    
  inputA <= 10'b1111111111; inputB <= 0000000000; @(posedge clk);   
                     @(posedge clk);   
                      @(posedge clk); 
				inputA <= 10'b0000000000; inputB <= 1111111111; @(posedge clk);
                      @(posedge clk);	
			          @(posedge clk);
				inputA <= 10'b1000000000; inputB <= 0111111111; @(posedge clk);
                      @(posedge clk);	
			          @(posedge clk);			 
						  
  
   
  $stop; // End the simulation.  
 end  
endmodule  