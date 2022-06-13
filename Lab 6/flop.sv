 //Module to build flop
 module flop(q, d, clk, Reset);
	output logic q;
	input logic d;
	input logic clk;
	input logic Reset;
	
	always_ff @(posedge clk) begin
		  if (Reset)   
    q <= 0;
  else  
		q <= d;
	end
endmodule 