module displayWin(clk, RST, RedPixels, GrnPixels, outputRed, outputOrange, oneWin);
	input logic clk;
	input logic RST;
	input logic [15:0][15:0] RedPixels, GrnPixels;
	output logic [6:0] outputRed, outputOrange;
	output logic oneWin;
	
	//There are 10 ways to win 
	//If someone wins there is a reset

	//Left winner is One, right winner is Two. 
	logic [2:0] counterOne;
	logic [2:0] counterTwo;
	
	logic [1:0] ps, ns;
	
	
	logic [6:0] ONE, TWO, NONE, ZERO, THREE, FOUR, FIVE, SIX, SEVEN;
	
	parameter one = 2'b01, two = 2'b10, none = 2'b00;
	 

	always_comb begin
	   if (counterOne == 3'b000) begin
			outputRed = ZERO;
		end else if (counterOne == 3'b001) begin
			outputRed = ONE; 
		end else if (counterOne == 3'b010) begin
			outputRed = TWO;
		end else if (counterOne == 3'b011) begin
			outputRed = THREE;
		end else if (counterOne == 3'b100) begin
			outputRed = FOUR;
		end else if (counterOne == 3'b101) begin
		   outputRed = FIVE;
		end else if (counterOne == 3'b110) begin
			outputRed = SIX;
		end else begin
			outputRed = SEVEN;
		end
	
	end
	
	always_comb begin
	   if (counterTwo == 3'b000) begin
			outputOrange = ZERO;
		end else if (counterTwo == 3'b001) begin
			outputOrange = ONE; 
		end else if (counterTwo == 3'b010) begin
			outputOrange = TWO;
		end else if (counterTwo == 3'b011) begin
			outputOrange = THREE;
		end else if (counterTwo == 3'b100) begin
			outputOrange = FOUR;
		end else if (counterTwo == 3'b101) begin
		   outputOrange = FIVE;
		end else if (counterTwo == 3'b110) begin
			outputOrange = SIX;
		end else begin
			//It holds the default as 7 because it does not really matter after 7
			outputOrange = SEVEN;
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

		//I need to check if there is a Grn or red win over here and if there
		//is a red win then the first if in the none goes to it and if there is an 
		//orange win the second if goes to it.
		
	logic redWinner;
	logic orangeWinner;
	
	//All 17 ways for red to win
	/*always_comb begin
		if (RedPixels[1][14] == 1 & RedPixels[1][11] == 1 & RedPixels[1][8] == 1 & RedPixels[1][5] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1) begin
			redWinner = 1'b1;
		end else begin
			redWinner = 1'b0;
		end
	
	
	
	
	
	end
	
	//All 10 ways for orange to win
	always_comb begin
	
		if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else if (RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & RedPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1 & GrnPixels[] == 1) begin
			redWinner = 1'b1;
		end else begin
			redWinner = 1'b0;
		end
		
	end*/

	always_comb begin
	   case (ps)
		   none:  
		if (RedPixels[14][1] == 1 & RedPixels[11][1] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1) begin
			ns = one;
		end else if (RedPixels[11][1] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1 & RedPixels[2][1] == 1) begin
			ns = one;
		end else if (RedPixels[14][4] == 1 & RedPixels[11][4] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1) begin
			ns = one;
		end else if (RedPixels[11][4] == 1 & RedPixels[8][4] == 1 & RedPixels[5][4] == 1 & RedPixels[2][4] == 1) begin
			ns = one;
		end else if (RedPixels[14][7] == 1 & RedPixels[11][7] == 1 & RedPixels[8][7] == 1 & RedPixels[5][7] == 1) begin
			ns = one;
		end else if (RedPixels[11][7] == 1 & RedPixels[8][7] == 1 & RedPixels[5][7] == 1 & RedPixels[2][7] == 1) begin
			ns = one;
		end else if (RedPixels[14][10] == 1 & RedPixels[11][10] == 1 & RedPixels[8][10] == 1 & RedPixels[5][10] == 1) begin
			ns = one;
		end else if (RedPixels[11][10] == 1 & RedPixels[8][10] == 1 & RedPixels[5][10] == 1 & RedPixels[2][10] == 1) begin
			ns = one;
		end else if (RedPixels[14][1] == 1 & RedPixels[11][4] == 1 & RedPixels[8][7] == 1 & RedPixels[5][10] == 1) begin
			ns = one;
		end else if (RedPixels[11][4] == 1 & RedPixels[8][7] == 1 & RedPixels[5][10] == 1 & RedPixels[2][13] == 1) begin
			ns = one;
		end else if (RedPixels[2][1] == 1 & RedPixels[5][4] == 1 & RedPixels[8][7] == 1 & RedPixels[11][10] == 1) begin
			ns = one;
		end else if (RedPixels[5][4] == 1 & RedPixels[8][7] == 1 & RedPixels[11][10] == 1 & RedPixels[14][13] == 1) begin
			ns = one;


		end else if (RedPixels[5][1] == 1 & RedPixels[5][4] == 1 & RedPixels[5][7] == 1 & RedPixels[5][10] == 1) begin
			ns = one;
		end else if (RedPixels[5][4] == 1 & RedPixels[5][7] == 1 & RedPixels[5][10] == 1 & RedPixels[5][13] == 1) begin
			ns = one;
		end else if (RedPixels[2][1] == 1 & RedPixels[2][4] == 1 & RedPixels[2][7] == 1 & RedPixels[2][10] == 1) begin
			ns = one;
		end else if (RedPixels[2][4] == 1 & RedPixels[2][7] == 1 & RedPixels[2][10] == 1 & RedPixels[2][13] == 1) begin
			ns = one;
			
					end else if (RedPixels[14][1] == 1 & RedPixels[14][4] == 1 & RedPixels[14][7] == 1 & RedPixels[14][10] == 1) begin
			ns = one;
		end else if (RedPixels[14][4] == 1 & RedPixels[14][7] == 1 & RedPixels[14][10] == 1 & RedPixels[14][13] == 1) begin
			ns = one;
		end else if (RedPixels[11][1] == 1 & RedPixels[11][4] == 1 & RedPixels[11][7] == 1 & RedPixels[11][10] == 1) begin
			ns = one;
		end else if (RedPixels[11][4] == 1 & RedPixels[11][7] == 1 & RedPixels[11][10] == 1 & RedPixels[11][13] == 1) begin
			ns = one;
		end else if (RedPixels[8][1] == 1 & RedPixels[8][4] == 1 & RedPixels[8][7] == 1 & RedPixels[8][10] == 1) begin
			ns = one;
		end else if (RedPixels[8][4] == 1 & RedPixels[8][7] == 1 & RedPixels[8][10] == 1 & RedPixels[8][13] == 1) begin
			ns = one;
			
			
			
			
			
			
			
			
		//Now I need to implement the Grn thing	
				end else if (GrnPixels[14][1] == 1 & GrnPixels[11][1] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1) begin
			ns = two;
		end else if (GrnPixels[11][1] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1 & GrnPixels[2][1] == 1) begin
			ns = two;
		end else if (GrnPixels[14][4] == 1 & GrnPixels[11][4] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1) begin
			ns = two;
		end else if (GrnPixels[11][4] == 1 & GrnPixels[8][4] == 1 & GrnPixels[5][4] == 1 & GrnPixels[2][4] == 1) begin
			ns = two;
		end else if (GrnPixels[14][7] == 1 & GrnPixels[11][7] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][7] == 1) begin
			ns = two;
		end else if (GrnPixels[11][7] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][7] == 1 & GrnPixels[2][7] == 1) begin
			ns = two;
		end else if (GrnPixels[14][10] == 1 & GrnPixels[11][10] == 1 & GrnPixels[8][10] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][10] == 1 & GrnPixels[8][10] == 1 & GrnPixels[5][10] == 1 & GrnPixels[2][10] == 1) begin
			ns = two;
		end else if (GrnPixels[14][1] == 1 & GrnPixels[11][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][10] == 1 & GrnPixels[2][13] == 1) begin
			ns = two;
		end else if (GrnPixels[2][1] == 1 & GrnPixels[5][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[11][10] == 1) begin
			ns = two;

		end else if (GrnPixels[5][1] == 1 & GrnPixels[5][4] == 1 & GrnPixels[5][7] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;
		end else if (GrnPixels[5][4] == 1 & GrnPixels[5][7] == 1 & GrnPixels[5][10] == 1 & GrnPixels[5][13] == 1) begin
			ns = two;
		end else if (GrnPixels[2][1] == 1 & GrnPixels[2][4] == 1 & GrnPixels[2][7] == 1 & GrnPixels[2][10] == 1) begin
			ns = two;
		end else if (GrnPixels[2][4] == 1 & GrnPixels[2][7] == 1 & GrnPixels[2][10] == 1 & GrnPixels[2][13] == 1) begin
			ns = two;
		
			end else if (GrnPixels[5][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[11][10] == 1 & GrnPixels[14][13] == 1) begin
			ns = two;
		end else if (GrnPixels[14][1] == 1 & GrnPixels[14][4] == 1 & GrnPixels[14][7] == 1 & GrnPixels[14][10] == 1) begin
			ns = two;
		end else if (GrnPixels[14][4] == 1 & GrnPixels[14][7] == 1 & GrnPixels[14][10] == 1 & GrnPixels[14][13] == 1) begin
			ns = two;
		end else if (GrnPixels[11][1] == 1 & GrnPixels[11][4] == 1 & GrnPixels[11][7] == 1 & GrnPixels[11][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][4] == 1 & GrnPixels[11][7] == 1 & GrnPixels[11][10] == 1 & GrnPixels[11][13] == 1) begin
			ns = two;
		end else if (GrnPixels[8][1] == 1 & GrnPixels[8][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[8][10] == 1) begin
			ns = two;
		end else if (GrnPixels[8][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[8][10] == 1 & GrnPixels[8][13] == 1) begin
			ns = two;
	
			
			
			
		end else begin ns = none;	

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
	   if (RST) begin
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


module displayWin_testbench();
	logic clk;
	logic RST;
	logic [15:0][15:0] RedPixels, GrnPixels;
	logic [6:0] outputRed, outputOrange;
	logic oneWin;
	
	displayWin dut18 (clk, RST, RedPixels, GrnPixels, outputRed, outputOrange, oneWin);
	
	
	 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
 
   
 // Test the design.
integer i; 
 initial begin   
 
  //I go through all the 65536 values (2^16) and assign them to the pixel grids.
	for(i = 0; i <65536; i++) begin
    RST <= 1; @(posedge clk); 
    RST <= 0; RedPixels[0] = i; GrnPixels[0] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
			RedPixels[1] = i; GrnPixels[1] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[2] = i; GrnPixels[2] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[3] = i; GrnPixels[3] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[4] = i; GrnPixels[4] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[5] = i; GrnPixels[5] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[6] = i; GrnPixels[6] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[7] = i; GrnPixels[7] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[8] = i; GrnPixels[8] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[9] = i; GrnPixels[9] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[10] = i; GrnPixels[10] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[11] = i; GrnPixels[11] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[12] = i; GrnPixels[12] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[13] = i; GrnPixels[13] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[14] = i; GrnPixels[14] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[15] = i; GrnPixels[15] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);

				
	  end
	  

  
  $stop; // End the simulation.  
 end 
 
 endmodule 