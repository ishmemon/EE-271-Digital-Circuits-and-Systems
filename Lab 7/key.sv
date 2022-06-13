module key (clk, reset, key, out);
   input logic clk, reset;
   input logic	key;
	output logic out;
	
	parameter on = 1'b01, off = 1'b00;
	logic ns, oldKey;
	
	always_comb
	   case (out)
		   on: ns = off;
			off: if ((key == on) & (key != oldKey)) ns = on;
			     else ns = off;
			default: ns = off;
		endcase
	
	always @(posedge clk)
	   if (reset)
		   begin out <= off;
			      oldKey <= off;
			end
		else begin
		   out <= ns;
			oldKey <= key;
		end
		
endmodule

module key_testbench();
   logic clk, reset, key;
	logic out;
   
	key dut5 (.clk, .reset, .key, .out);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                                     @(posedge clk);
	   reset <= 1;                       @(posedge clk);
	   reset <= 0;    key <= 0;          @(posedge clk);
	                                     @(posedge clk);
	                  key <= 1;          @(posedge clk);
				   			                @(posedge clk);
		reset <= 1;                       @(posedge clk);
	   reset <= 0;    key <= 0;          @(posedge clk);
	                                     @(posedge clk);
	                  key <= 1;          @(posedge clk);
				   			                @(posedge clk);
								            			   		
		$stop;
   end	
endmodule