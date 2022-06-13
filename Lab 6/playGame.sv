module playGame (Clock, Reset, L, R, lights, numbers);
   
	
	input logic Clock, Reset;
	input logic L, R;
	
	
	output logic [9:1] lights;
	output logic [6:0] numbers;
	

	//Need to deal with the edge case
	normalLight light9 (.Clock, .Reset, .L, .R, .NL(1'b0), .NR(lights[8]), 
		.lightOn(lights[9]) );  
   
	
	normalLight nt8 (.Clock, .Reset, .L, .R, .NL(lights[9]), .NR(lights[7]),
		.lightOn(lights[8]) );  
   normalLight n7 (.Clock, .Reset, .L, .R, .NL(lights[8]), .NR(lights[6]),
		.lightOn(lights[7]) ); 
   normalLight n6 (.Clock, .Reset, .L, .R, .NL(lights[7]), .NR(lights[5]),
		.lightOn(lights[6]) );  
   centerLight cen (.Clock, .Reset, .L, .R, .NL(lights[6]), .NR(lights[4]),
		.lightOn(lights[5]) );  
   normalLight n4 (.Clock, .Reset, .L, .R, .NL(lights[5]), .NR(lights[3]),
		.lightOn(lights[4]) );  
   normalLight n3 (.Clock, .Reset, .L, .R, .NL(lights[4]), .NR(lights[2]),
		.lightOn(lights[3]) );  
   normalLight n2 (.Clock, .Reset, .L, .R, .NL(lights[3]), .NR(lights[1]),
		.lightOn(lights[2]) );  
   //Another edge case to deal with
	normalLight n1 (.Clock, .Reset, .L, .R, .NL(lights[2]), .NR(1'b0),
		.lightOn(lights[1]) );  

	winning REX (.clk(Clock), .reset(Reset), .leftest(lights[9]), .rightest(lights[1]), .L, .R, .numbers);
endmodule

module playGame_testbench();
   logic Clock, Reset, L, R;
	logic [9:1] lights;
	logic [6:0] numbers;
   
	playGame dut4 (.Clock, .Reset, .L, .R, .lights, .numbers);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   Clock <= 0;    
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock; 
	end 
	
	initial begin
	                                     @(posedge Clock);
	   Reset <= 1;                       @(posedge Clock);
	   Reset <= 0; L <= 0; R <= 0;       @(posedge Clock);
	                       R <= 1;       @(posedge Clock);
	               L <= 1;               @(posedge Clock);
				   			  R <= 0;       @(posedge Clock);
								                @(posedge Clock);
					   		
		$stop;
   end	
endmodule	