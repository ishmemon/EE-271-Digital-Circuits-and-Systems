module winning (clk, reset, leftest, rightest, L, R, leftWin, rightWin, oneWin);
   input logic clk, reset;
   input logic	leftest, rightest, L, R;
	output logic [6:0] leftWin, rightWin;
	output logic oneWin;
	
	
	//Left winner is One, right winner is Two. 
	logic [2:0] counterOne;
	logic [2:0] counterTwo;
	
	logic [1:0] ps, ns;
	
	parameter one = 2'b01, two = 2'b10, none = 2'b00;
	
	logic [6:0] ONE, TWO, NONE, ZERO, THREE, FOUR, FIVE, SIX, SEVEN; 

	always_comb begin
	   if (counterOne == 3'b000) begin
			leftWin = ZERO;
		end else if (counterOne == 3'b001) begin
			leftWin = ONE; 
		end else if (counterOne == 3'b010) begin
			leftWin = TWO;
		end else if (counterOne == 3'b011) begin
			leftWin = THREE;
		end else if (counterOne == 3'b100) begin
			leftWin = FOUR;
		end else if (counterOne == 3'b101) begin
		   leftWin = FIVE;
		end else if (counterOne == 3'b110) begin
			leftWin = SIX;
		end else begin
			leftWin = SEVEN;
		end
	
	end
	
	always_comb begin
	   if (counterTwo == 3'b000) begin
			rightWin = ZERO;
		end else if (counterTwo == 3'b001) begin
			rightWin = ONE; 
		end else if (counterTwo == 3'b010) begin
			rightWin = TWO;
		end else if (counterTwo == 3'b011) begin
			rightWin = THREE;
		end else if (counterTwo == 3'b100) begin
			rightWin = FOUR;
		end else if (counterTwo == 3'b101) begin
		   rightWin = FIVE;
		end else if (counterTwo == 3'b110) begin
			rightWin = SIX;
		end else begin
			//It holds the default as 7 because it does not really matter after 7
			rightWin = SEVEN;
		end
	
	end
	
	
	
	assign ZERO = 7'b1000000;	
	assign ONE = 7'b1111001;
	assign TWO = 7'b0100100;
	assign NONE = 7'b1111111;
	assign THREE = 7'b0110000;
	assign FOUR = 7'b0011001;
	assign FIVE = 7'b0010010;  
	assign SIX = 7'b0000010;
   assign SEVEN = 7'b1111000;	


	always_comb begin
	   case (ps)
		   none:  if (leftest & L & ~R) begin
		     	ns = two; 
				//counterOne = counterOne + 1;
			end
			   else if (rightest & R & ~L) begin 
				   ns = one; 
					//counterTwo = counterTwo + 1; 
			end
					 else begin ns = none; 

					 end
			//Now we need to deal with the new reset thing
			one:   begin
				//It should go back and start again
				ns = none; 
				//oneWin = 1'b1;
			
			end
			//Now we need to deal with the new reset thing
			two:   begin 
				//It should go back and start again
				ns = none; 
				//oneWin = 1'b1;
			
			end
			default: begin 
				ns = none; 
				//counterOne = 0; 
				//counterTwo = 0;
				//oneWin = 1'b0;
			
			end
			
		endcase
	end
		
	always_ff @(posedge clk) begin
	   if (reset) begin
		   ps <= none;
			counterOne <= 0;
			counterTwo <= 0;
			oneWin <= 0;
		end else if (ns == one) begin
		   ps <= ns;
			counterTwo <= counterTwo + 1; 
			oneWin <= 1;
			end else if (ns == two) begin
		   ps <= ns;
			counterOne <= counterOne + 1;
			oneWin <= 1;

	end else begin
		ps <= ns;
		oneWin <= 0;
	end

	end
			
		
endmodule

module winning_testbench();
   logic clk, reset, leftest, rightest, L, R;
	logic [6:0] leftWin, rightWin;
	logic oneWin;
	
	winning dut8 (clk, reset, leftest, rightest, L, R, leftWin, rightWin, oneWin);
	
  // Set up a simulated clock.   
  parameter CLOCK_PERIOD=100;  
  initial begin  
    clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
  end  
   
 // Set up the inputs to the design.  Each line is a clock cycle.  
 //I make a lot of wins on both sides to see if the counter works
 initial begin    
                                   @(posedge clk);
	   reset <= 1;  @(posedge clk);
	   reset <= 0; L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		                                   @(posedge clk);
	   reset <= 1;  @(posedge clk);
	   reset <= 0; L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		                                   @(posedge clk);
	     @(posedge clk);
	   L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		                                   @(posedge clk);
	     @(posedge clk);
	    L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		                                   @(posedge clk);
	     @(posedge clk);
	    L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		                                   @(posedge clk);
	     @(posedge clk);
	    L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		                                   @(posedge clk);

													  
													  
			
			
			
			
			
			
			
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		
					
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		
					
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		
					
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		
		
		
		
					
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		
		
		
		
		
					
			L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
																							 
	 L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		L <= 0; R <= 0; leftest <= 0;  rightest <= 0; @(posedge clk);
	                                              rightest <= 1; @(posedge clk);
	                               leftest <= 1; @(posedge clk);
				   				 rightest <= 0;       @(posedge clk);
	R <= 1;                                     @(posedge clk);
	           rightest <= 1;       @(posedge clk);
					leftest <= 0;                       @(posedge clk);
				rightest <= 0;       @(posedge clk);
	L <= 1;                        @(posedge clk);
			rightest <= 1;       @(posedge clk);
leftest <= 1;                       @(posedge clk);
       rightest <= 0;       @(posedge clk);
 R <= 0;		                               @(posedge clk);
                         rightest <= 1;       @(posedge clk);
		 leftest <= 0;                       @(posedge clk);
				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		
		$stop;
	end
endmodule

	