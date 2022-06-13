module key (clk, RST, key, out);
   
	
	input logic clk, RST;
   input logic	key;
	
	
	
	
	output logic out;
	
								logic next, prevValue;
	
	parameter one = 2'b01;
   parameter two = 2'b00;

		always @(posedge clk)
	   if (RST)
		   begin out <= two;
			      prevValue <= two;
			end
		else begin
		   out <= next;
			prevValue <= key;
		end
	
	
	
	always_comb
	   case (out)
			two: if ((key == one) & (key != prevValue)) next = one;
			     else next = two;
		   one: next = two;
			default: next = two;
		endcase
	

		
endmodule

module key_testbench();
   logic clk, RST, key;
	logic out;
   
	key dut15 (.clk, .RST, .key, .out);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                 @(posedge clk);
						  @(posedge clk);
						  @(posedge clk);
	   RST <= 1;                       @(posedge clk);
	   RST <= 0;    key <= 1;          @(posedge clk);
	                  @(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
	                  key <= 0;          @(posedge clk);
				   		  @(posedge clk);
							  @(posedge clk);
							  @(posedge clk);
							  @(posedge clk);
							  @(posedge clk);
							  @(posedge clk);
							  @(posedge clk);

								            			   		
		$stop;
   end	
endmodule