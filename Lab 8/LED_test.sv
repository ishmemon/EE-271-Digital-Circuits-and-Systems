module LED_test(clk, RST, RedPixels, GrnPixels, inputKey, SW);
	 input logic clk; 
    input logic               RST;
	 input logic [7:0] inputKey;
	 input logic [1:0] SW;
    output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
    output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
	 
	 
	logic alternate;
	logic [1:0] store;
	logic [1:0] proxy;

	
	
		
	logic reset;
	assign reset = ((~inputKey[0]) & (~inputKey[1]) & (~inputKey[2]) & (~inputKey[3]) & (~inputKey[4]) & (~inputKey[5]) & (~inputKey[6]) & (~inputKey[7]));
	 
	 
	logic count;
	
	flop f1(.q(store[0]), .d(SW[0]), .clk, .Reset(reset));
	flop f2(.q(store[1]), .d(SW[1]), .clk, .Reset(reset));
	
	flop f1_2(.q(proxy[0]), .d(store[0]), .clk, .Reset(reset));
	flop f2_2(.q(proxy[1]), .d(store[1]), .clk, .Reset(reset));
		
		//always @(posedge clk) begin
			//alternate <= (~alternate);
		//end
		
		
		//assign alternate = (~clk);
	 
	//The first player's turn is determined by the switch being SW1, SW0 being 10 and
	//the second one's turn is determined by it being 00 (or 11). 
	//always_comb begin
		//alternate <= ((~proxy[0]) & proxy[1]);
	 //logic alternate;
	//assign alternate = 1'b1;
	//assign alternate = ~clk;
	
 
	/*always @ (posedge clk) begin
		if (reset) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
	end*/
	 
	 
	 always_ff @(posedge clk) begin
		if (reset) begin
		count <= 0;
		end else begin
			count <= count+1;
		end
	end
		//integer i;
	 //always_comb begin
		// Reset - Display default pattern this works
		//if (reset) begin
			//RedPixels = RedPixels;
			//GrnPixels = GrnPixels;
		
		//end else 
		//counter c (.clk(clk), .reset, .count);

		
	always_ff @(posedge clk) begin 	
		
		if (RST) begin
		  RedPixels[00] = 16'b0001001001001000;
		  RedPixels[01] = 16'b0001001001001000;
		  RedPixels[02] = 16'b0001001001001000;
		  RedPixels[03] = 16'b0001001001001000;
		  RedPixels[04] = 16'b0001001001001000;
		  RedPixels[05] = 16'b0001001001001000;
		  RedPixels[06] = 16'b0001001001001000;
		  RedPixels[07] = 16'b0001001001001000;
		  RedPixels[08] = 16'b0001001001001000;
		  RedPixels[09] = 16'b0001001001001000;
		  RedPixels[10] = 16'b0001001001001000;
		  RedPixels[11] = 16'b0001001001001000;
		  RedPixels[12] = 16'b0001001001001000;
		  RedPixels[13] = 16'b0001001001001000;
		  RedPixels[14] = 16'b0001001001001000;
		  RedPixels[15] = 16'b0001111111111110;
		  
		  //                  FEDCBA9876543210
		  GrnPixels[00] = 16'b0001001001001000;
		  GrnPixels[01] = 16'b0001001001001000;
		  GrnPixels[02] = 16'b0001001001001000;
		  GrnPixels[03] = 16'b0001001001001000;
		  GrnPixels[04] = 16'b0001001001001000;
		  GrnPixels[05] = 16'b0001001001001000;
		  GrnPixels[06] = 16'b0001001001001000;
		  GrnPixels[07] = 16'b0001001001001000;
		  GrnPixels[08] = 16'b0001001001001000;
		  GrnPixels[09] = 16'b0001001001001000;
		  GrnPixels[10] = 16'b0001001001001000;
		  GrnPixels[11] = 16'b0001001001001000;
		  GrnPixels[12] = 16'b0001001001001000;
		  GrnPixels[13] = 16'b0001001001001000;
		  GrnPixels[14] = 16'b0001001001001000;
		  GrnPixels[15] = 16'b0001111111111110;
		
	  // Display a pattern
		/*end else if (count) begin       //if (alternate) begin//if ((i%2) == 0) begin
			//i = i+1;
			//i++;
		  if (inputKey[0] == 1 & (~RST)) begin
		  RedPixels[00][2:1] = 2'b11;
		  RedPixels[01][2:1] = 2'b11;
		  RedPixels[02][2:1] = 2'b11;
		  if (RedPixels[03][1] == 1'b0 & GrnPixels[03][1] == 1'b0) begin
				RedPixels[00][2:1] = 2'b00;
				RedPixels[01][2:1] = 2'b00;
				RedPixels[02][2:1] = 2'b00;
				RedPixels[03][2:1] = 2'b11;
				RedPixels[04][2:1] = 2'b11;
				RedPixels[05][2:1] = 2'b11;
				if (RedPixels[06][1] == 1'b0 & GrnPixels[06][1] == 1'b0) begin
						RedPixels[03][2:1] = 2'b00;
						RedPixels[04][2:1] = 2'b00;
						RedPixels[05][2:1] = 2'b00;
						RedPixels[06][2:1] = 2'b11;
						RedPixels[07][2:1] = 2'b11;
						RedPixels[08][2:1] = 2'b11;
						
						if (RedPixels[09][1] == 1'b0 & GrnPixels[09][1] == 1'b0 ) begin
						RedPixels[06][2:1] = 2'b00;
						RedPixels[07][2:1] = 2'b00;
						RedPixels[08][2:1] = 2'b00;
						RedPixels[09][2:1] = 2'b11;
						RedPixels[10][2:1] = 2'b11;
						RedPixels[11][2:1] = 2'b11;
						
						if (RedPixels[12][1] == 1'b0 & GrnPixels[12][1] == 1'b0 ) begin
						RedPixels[09][2:1] = 2'b00;
						RedPixels[10][2:1] = 2'b00;
						RedPixels[11][2:1] = 2'b00;
						RedPixels[12][2:1] = 2'b11;
						RedPixels[13][2:1] = 2'b11;
						RedPixels[14][2:1] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[1] == 1 & (~RST) ) begin
		  RedPixels[00][5:4] = 2'b11;
		  RedPixels[01][5:4] = 2'b11;
		  RedPixels[02][5:4] = 2'b11;
		  if (RedPixels[03][4] == 1'b0 & GrnPixels[03][4] == 1'b0 ) begin
				RedPixels[00][5:4] = 2'b00;
				RedPixels[01][5:4] = 2'b00;
				RedPixels[02][5:4] = 2'b00;
				RedPixels[03][5:4] = 2'b11;
				RedPixels[04][5:4] = 2'b11;
				RedPixels[05][5:4] = 2'b11;
				if (RedPixels[06][4] == 1'b0 & GrnPixels[06][4] == 1'b0 ) begin
						RedPixels[03][5:4] = 2'b00;
						RedPixels[04][5:4] = 2'b00;
						RedPixels[05][5:4] = 2'b00;
						RedPixels[06][5:4] = 2'b11;
						RedPixels[07][5:4] = 2'b11;
						RedPixels[08][5:4] = 2'b11;
						
						if (RedPixels[09][4] == 1'b0 & GrnPixels[09][4] == 1'b0 ) begin
						RedPixels[06][5:4] = 2'b00;
						RedPixels[07][5:4] = 2'b00;
						RedPixels[08][5:4] = 2'b00;
						RedPixels[09][5:4] = 2'b11;
						RedPixels[10][5:4] = 2'b11;
						RedPixels[11][5:4] = 2'b11;
						
						if (RedPixels[12][4] == 1'b0 & GrnPixels[12][4] == 1'b0 ) begin
						RedPixels[09][5:4] = 2'b00;
						RedPixels[10][5:4] = 2'b00;
						RedPixels[11][5:4] = 2'b00;
						RedPixels[12][5:4] = 2'b11;
						RedPixels[13][5:4] = 2'b11;
						RedPixels[14][5:4] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[2] == 1 & (~RST) ) begin
		  RedPixels[00][8:7] = 2'b11;
		  RedPixels[01][8:7] = 2'b11;
		  RedPixels[02][8:7] = 2'b11;
		  if (RedPixels[03][7] == 1'b0 & GrnPixels[03][7] == 1'b0 ) begin
				RedPixels[00][8:7] = 2'b00;
				RedPixels[01][8:7] = 2'b00;
				RedPixels[02][8:7] = 2'b00;
				RedPixels[03][8:7] = 2'b11;
				RedPixels[04][8:7] = 2'b11;
				RedPixels[05][8:7] = 2'b11;
				if (RedPixels[06][7] == 1'b0 & GrnPixels[06][7] == 1'b0 ) begin
						RedPixels[03][8:7] = 2'b00;
						RedPixels[04][8:7] = 2'b00;
						RedPixels[05][8:7] = 2'b00;
						RedPixels[06][8:7] = 2'b11;
						RedPixels[07][8:7] = 2'b11;
						RedPixels[08][8:7] = 2'b11;
						
						if (RedPixels[09][7] == 1'b0 & GrnPixels[09][7] == 1'b0 ) begin
						RedPixels[06][8:7] = 2'b00;
						RedPixels[07][8:7] = 2'b00;
						RedPixels[08][8:7] = 2'b00;
						RedPixels[09][8:7] = 2'b11;
						RedPixels[10][8:7] = 2'b11;
						RedPixels[11][8:7] = 2'b11;
						
						if (RedPixels[12][7] == 1'b0 & GrnPixels[12][7] == 1'b0 ) begin
						RedPixels[09][8:7] = 2'b00;
						RedPixels[10][8:7] = 2'b00;
						RedPixels[11][8:7] = 2'b00;
						RedPixels[12][8:7] = 2'b11;
						RedPixels[13][8:7] = 2'b11;
						RedPixels[14][8:7] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[3] == 1 & (~RST) ) begin
		  RedPixels[00][11:10] = 2'b11;
		  RedPixels[01][11:10] = 2'b11;
		  RedPixels[02][11:10] = 2'b11;
		  if (RedPixels[03][10] == 1'b0 & GrnPixels[03][10] == 1'b0 ) begin
				RedPixels[00][11:10] = 2'b00;
				RedPixels[01][11:10] = 2'b00;
				RedPixels[02][11:10] = 2'b00;
				RedPixels[03][11:10] = 2'b11;
				RedPixels[04][11:10] = 2'b11;
				RedPixels[05][11:10] = 2'b11;
				if (RedPixels[06][10] == 1'b0 & GrnPixels[06][10] == 1'b0 ) begin
						RedPixels[03][11:10] = 2'b00;
						RedPixels[04][11:10] = 2'b00;
						RedPixels[05][11:10] = 2'b00;
						RedPixels[06][11:10] = 2'b11;
						RedPixels[07][11:10] = 2'b11;
						RedPixels[08][11:10] = 2'b11;
						
						if (RedPixels[09][10] == 1'b0 & GrnPixels[09][10] == 1'b0 ) begin
						RedPixels[06][11:10] = 2'b00;
						RedPixels[07][11:10] = 2'b00;
						RedPixels[08][11:10] = 2'b00;
						RedPixels[09][11:10] = 2'b11;
						RedPixels[10][11:10] = 2'b11;
						RedPixels[11][11:10] = 2'b11;
						
						if (RedPixels[12][10] == 1'b0 & GrnPixels[12][10] == 1'b0 ) begin
						RedPixels[09][11:10] = 2'b00;
						RedPixels[10][11:10] = 2'b00;
						RedPixels[11][11:10] = 2'b00;
						RedPixels[12][11:10] = 2'b11;
						RedPixels[13][11:10] = 2'b11;
						RedPixels[14][11:10] = 2'b11;
					end
					end
				end
				*/
				
	end else begin
			//i = i+1;
		  if (inputKey[0] == 1 & (~RST)) begin
		  RedPixels[00][2:1] = 2'b11;
		  RedPixels[01][2:1] = 2'b11;
		  RedPixels[02][2:1] = 2'b11;
		  if (RedPixels[03][1] == 1'b0 & GrnPixels[03][1] == 1'b0) begin
				RedPixels[00][2:1] = 2'b00;
				RedPixels[01][2:1] = 2'b00;
				RedPixels[02][2:1] = 2'b00;
				RedPixels[03][2:1] = 2'b11;
				RedPixels[04][2:1] = 2'b11;
				RedPixels[05][2:1] = 2'b11;
				if (RedPixels[06][1] == 1'b0 & GrnPixels[06][1] == 1'b0) begin
						RedPixels[03][2:1] = 2'b00;
						RedPixels[04][2:1] = 2'b00;
						RedPixels[05][2:1] = 2'b00;
						RedPixels[06][2:1] = 2'b11;
						RedPixels[07][2:1] = 2'b11;
						RedPixels[08][2:1] = 2'b11;
						
						if (RedPixels[09][1] == 1'b0 & GrnPixels[09][1] == 1'b0) begin
						RedPixels[06][2:1] = 2'b00;
						RedPixels[07][2:1] = 2'b00;
						RedPixels[08][2:1] = 2'b00;
						RedPixels[09][2:1] = 2'b11;
						RedPixels[10][2:1] = 2'b11;
						RedPixels[11][2:1] = 2'b11;
						
						if (RedPixels[12][1] == 1'b0 & GrnPixels[12][1] == 1'b0) begin
						RedPixels[09][2:1] = 2'b00;
						RedPixels[10][2:1] = 2'b00;
						RedPixels[11][2:1] = 2'b00;
						RedPixels[12][2:1] = 2'b11;
						RedPixels[13][2:1] = 2'b11;
						RedPixels[14][2:1] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[1] == 1 & (~RST)) begin
		  RedPixels[00][5:4] = 2'b11;
		  RedPixels[01][5:4] = 2'b11;
		  RedPixels[02][5:4] = 2'b11;
		  if (RedPixels[03][4] == 1'b0 & GrnPixels[03][4] == 1'b0) begin
				RedPixels[00][5:4] = 2'b00;
				RedPixels[01][5:4] = 2'b00;
				RedPixels[02][5:4] = 2'b00;
				RedPixels[03][5:4] = 2'b11;
				RedPixels[04][5:4] = 2'b11;
				RedPixels[05][5:4] = 2'b11;
				if (RedPixels[06][4] == 1'b0 & GrnPixels[06][4] == 1'b0) begin
						RedPixels[03][5:4] = 2'b00;
						RedPixels[04][5:4] = 2'b00;
						RedPixels[05][5:4] = 2'b00;
						RedPixels[06][5:4] = 2'b11;
						RedPixels[07][5:4] = 2'b11;
						RedPixels[08][5:4] = 2'b11;
						
						if (RedPixels[09][4] == 1'b0 & GrnPixels[09][4] == 1'b0) begin
						RedPixels[06][5:4] = 2'b00;
						RedPixels[07][5:4] = 2'b00;
						RedPixels[08][5:4] = 2'b00;
						RedPixels[09][5:4] = 2'b11;
						RedPixels[10][5:4] = 2'b11;
						RedPixels[11][5:4] = 2'b11;
						
						if (RedPixels[12][4] == 1'b0 & GrnPixels[12][4] == 1'b0) begin
						RedPixels[09][5:4] = 2'b00;
						RedPixels[10][5:4] = 2'b00;
						RedPixels[11][5:4] = 2'b00;
						RedPixels[12][5:4] = 2'b11;
						RedPixels[13][5:4] = 2'b11;
						RedPixels[14][5:4] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[2] == 1 & (~RST)) begin
		  RedPixels[00][8:7] = 2'b11;
		  RedPixels[01][8:7] = 2'b11;
		  RedPixels[02][8:7] = 2'b11;
		  if (RedPixels[03][7] == 1'b0 & GrnPixels[03][7] == 1'b0) begin
				RedPixels[00][8:7] = 2'b00;
				RedPixels[01][8:7] = 2'b00;
				RedPixels[02][8:7] = 2'b00;
				RedPixels[03][8:7] = 2'b11;
				RedPixels[04][8:7] = 2'b11;
				RedPixels[05][8:7] = 2'b11;
				if (RedPixels[06][7] == 1'b0 & GrnPixels[06][7] == 1'b0) begin
						RedPixels[03][8:7] = 2'b00;
						RedPixels[04][8:7] = 2'b00;
						RedPixels[05][8:7] = 2'b00;
						RedPixels[06][8:7] = 2'b11;
						RedPixels[07][8:7] = 2'b11;
						RedPixels[08][8:7] = 2'b11;
						
						if (RedPixels[09][7] == 1'b0 & GrnPixels[09][7] == 1'b0) begin
						RedPixels[06][8:7] = 2'b00;
						RedPixels[07][8:7] = 2'b00;
						RedPixels[08][8:7] = 2'b00;
						RedPixels[09][8:7] = 2'b11;
						RedPixels[10][8:7] = 2'b11;
						RedPixels[11][8:7] = 2'b11;
						
						if (RedPixels[12][7] == 1'b0 & GrnPixels[12][7] == 1'b0) begin
						RedPixels[09][8:7] = 2'b00;
						RedPixels[10][8:7] = 2'b00;
						RedPixels[11][8:7] = 2'b00;
						RedPixels[12][8:7] = 2'b11;
						RedPixels[13][8:7] = 2'b11;
						RedPixels[14][8:7] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[3] == 1 & (~RST)) begin
		  RedPixels[00][11:10] = 2'b11;
		  RedPixels[01][11:10] = 2'b11;
		  RedPixels[02][11:10] = 2'b11;
		  if (RedPixels[03][10] == 1'b0 & GrnPixels[03][10] == 1'b0) begin
				RedPixels[00][11:10] = 2'b00;
				RedPixels[01][11:10] = 2'b00;
				RedPixels[02][11:10] = 2'b00;
				RedPixels[03][11:10] = 2'b11;
				RedPixels[04][11:10] = 2'b11;
				RedPixels[05][11:10] = 2'b11;
				if (RedPixels[06][10] == 1'b0 & GrnPixels[06][10] == 1'b0) begin
						RedPixels[03][11:10] = 2'b00;
						RedPixels[04][11:10] = 2'b00;
						RedPixels[05][11:10] = 2'b00;
						RedPixels[06][11:10] = 2'b11;
						RedPixels[07][11:10] = 2'b11;
						RedPixels[08][11:10] = 2'b11;
						
						if (RedPixels[09][10] == 1'b0 & GrnPixels[09][10] == 1'b0) begin
						RedPixels[06][11:10] = 2'b00;
						RedPixels[07][11:10] = 2'b00;
						RedPixels[08][11:10] = 2'b00;
						RedPixels[09][11:10] = 2'b11;
						RedPixels[10][11:10] = 2'b11;
						RedPixels[11][11:10] = 2'b11;
						
						if (RedPixels[12][10] == 1'b0 & GrnPixels[12][10] == 1'b0) begin
						RedPixels[09][11:10] = 2'b00;
						RedPixels[10][11:10] = 2'b00;
						RedPixels[11][11:10] = 2'b00;
						RedPixels[12][11:10] = 2'b11;
						RedPixels[13][11:10] = 2'b11;
						RedPixels[14][11:10] = 2'b11;
					end
					end
				end
				end
	 end
	 
	 
	 
		  if (inputKey[4] == 1 & (~RST)) begin
		  GrnPixels[00][2:1] = 2'b11;
		  GrnPixels[01][2:1] = 2'b11;
		  GrnPixels[02][2:1] = 2'b11;
		  if (RedPixels[03][1] == 1'b0 & GrnPixels[03][1] == 1'b0) begin
				GrnPixels[00][2:1] = 2'b00;
				GrnPixels[01][2:1] = 2'b00;
				GrnPixels[02][2:1] = 2'b00;
				GrnPixels[03][2:1] = 2'b11;
				GrnPixels[04][2:1] = 2'b11;
				GrnPixels[05][2:1] = 2'b11;
				if (RedPixels[06][1] == 1'b0 & GrnPixels[06][1] == 1'b0) begin
						GrnPixels[03][2:1] = 2'b00;
						GrnPixels[04][2:1] = 2'b00;
						GrnPixels[05][2:1] = 2'b00;
						GrnPixels[06][2:1] = 2'b11;
						GrnPixels[07][2:1] = 2'b11;
						GrnPixels[08][2:1] = 2'b11;
						
						if (RedPixels[09][1] == 1'b0 & GrnPixels[09][1] == 1'b0) begin
						GrnPixels[06][2:1] = 2'b00;
						GrnPixels[07][2:1] = 2'b00;
						GrnPixels[08][2:1] = 2'b00;
						GrnPixels[09][2:1] = 2'b11;
						GrnPixels[10][2:1] = 2'b11;
						GrnPixels[11][2:1] = 2'b11;
						
						if (RedPixels[12][1] == 1'b0 & GrnPixels[12][1] == 1'b0) begin
						GrnPixels[09][2:1] = 2'b00;
						GrnPixels[10][2:1] = 2'b00;
						GrnPixels[11][2:1] = 2'b00;
						GrnPixels[12][2:1] = 2'b11;
						GrnPixels[13][2:1] = 2'b11;
						GrnPixels[14][2:1] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[5] == 1 & (~RST)) begin
		  GrnPixels[00][5:4] = 2'b11;
		  GrnPixels[01][5:4] = 2'b11;
		  GrnPixels[02][5:4] = 2'b11;
		  if (RedPixels[03][4] == 1'b0 & GrnPixels[03][4] == 1'b0) begin
				GrnPixels[00][5:4] = 2'b00;
				GrnPixels[01][5:4] = 2'b00;
				GrnPixels[02][5:4] = 2'b00;
				GrnPixels[03][5:4] = 2'b11;
				GrnPixels[04][5:4] = 2'b11;
				GrnPixels[05][5:4] = 2'b11;
				if (RedPixels[06][4] == 1'b0 & GrnPixels[06][4] == 1'b0) begin
						GrnPixels[03][5:4] = 2'b00;
						GrnPixels[04][5:4] = 2'b00;
						GrnPixels[05][5:4] = 2'b00;
						GrnPixels[06][5:4] = 2'b11;
						GrnPixels[07][5:4] = 2'b11;
						GrnPixels[08][5:4] = 2'b11;
						
						if (RedPixels[09][4] == 1'b0 & GrnPixels[09][4] == 1'b0) begin
						GrnPixels[06][5:4] = 2'b00;
						GrnPixels[07][5:4] = 2'b00;
						GrnPixels[08][5:4] = 2'b00;
						GrnPixels[09][5:4] = 2'b11;
						GrnPixels[10][5:4] = 2'b11;
						GrnPixels[11][5:4] = 2'b11;
						
						if (RedPixels[12][4] == 1'b0 & GrnPixels[12][4] == 1'b0) begin
						GrnPixels[09][5:4] = 2'b00;
						GrnPixels[10][5:4] = 2'b00;
						GrnPixels[11][5:4] = 2'b00;
						GrnPixels[12][5:4] = 2'b11;
						GrnPixels[13][5:4] = 2'b11;
						GrnPixels[14][5:4] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[6] == 1 & (~RST)) begin
		  GrnPixels[00][8:7] = 2'b11;
		  GrnPixels[01][8:7] = 2'b11;
		  GrnPixels[02][8:7] = 2'b11;
		  if (RedPixels[03][7] == 1'b0 & GrnPixels[03][7] == 1'b0) begin
				GrnPixels[00][8:7] = 2'b00;
				GrnPixels[01][8:7] = 2'b00;
				GrnPixels[02][8:7] = 2'b00;
				GrnPixels[03][8:7] = 2'b11;
				GrnPixels[04][8:7] = 2'b11;
				GrnPixels[05][8:7] = 2'b11;
				if (RedPixels[06][7] == 1'b0 & GrnPixels[06][7] == 1'b0) begin
						GrnPixels[03][8:7] = 2'b00;
						GrnPixels[04][8:7] = 2'b00;
						GrnPixels[05][8:7] = 2'b00;
						GrnPixels[06][8:7] = 2'b11;
						GrnPixels[07][8:7] = 2'b11;
						GrnPixels[08][8:7] = 2'b11;
						
						if (RedPixels[09][7] == 1'b0 & GrnPixels[09][7] == 1'b0) begin
						GrnPixels[06][8:7] = 2'b00;
						GrnPixels[07][8:7] = 2'b00;
						GrnPixels[08][8:7] = 2'b00;
						GrnPixels[09][8:7] = 2'b11;
						GrnPixels[10][8:7] = 2'b11;
						GrnPixels[11][8:7] = 2'b11;
						
						if (RedPixels[12][7] == 1'b0 & GrnPixels[12][7] == 1'b0) begin
						GrnPixels[09][8:7] = 2'b00;
						GrnPixels[10][8:7] = 2'b00;
						GrnPixels[11][8:7] = 2'b00;
						GrnPixels[12][8:7] = 2'b11;
						GrnPixels[13][8:7] = 2'b11;
						GrnPixels[14][8:7] = 2'b11;
					end
					end
				end
		  end
		end
		else if (inputKey[7] == 1 & (~RST)) begin
		  GrnPixels[00][11:10] = 2'b11;
		  GrnPixels[01][11:10] = 2'b11;
		  GrnPixels[02][11:10] = 2'b11;
		  if (RedPixels[03][10] == 1'b0 & GrnPixels[03][10] == 1'b0) begin
				GrnPixels[00][11:10] = 2'b00;
				GrnPixels[01][11:10] = 2'b00;
				GrnPixels[02][11:10] = 2'b00;
				GrnPixels[03][11:10] = 2'b11;
				GrnPixels[04][11:10] = 2'b11;
				GrnPixels[05][11:10] = 2'b11;
				if (RedPixels[06][10] == 1'b0 & GrnPixels[06][10] == 1'b0) begin
						GrnPixels[03][11:10] = 2'b00;
						GrnPixels[04][11:10] = 2'b00;
						GrnPixels[05][11:10] = 2'b00;
						GrnPixels[06][11:10] = 2'b11;
						GrnPixels[07][11:10] = 2'b11;
						GrnPixels[08][11:10] = 2'b11;
						
						if (RedPixels[09][10] == 1'b0 & GrnPixels[09][10] == 1'b0) begin
						GrnPixels[06][11:10] = 2'b00;
						GrnPixels[07][11:10] = 2'b00;
						GrnPixels[08][11:10] = 2'b00;
						GrnPixels[09][11:10] = 2'b11;
						GrnPixels[10][11:10] = 2'b11;
						GrnPixels[11][11:10] = 2'b11;
						
						if (RedPixels[12][10] == 1'b0 & GrnPixels[12][10] == 1'b0) begin
						GrnPixels[09][11:10] = 2'b00;
						GrnPixels[10][11:10] = 2'b00;
						GrnPixels[11][11:10] = 2'b00;
						GrnPixels[12][11:10] = 2'b11;
						GrnPixels[13][11:10] = 2'b11;
						GrnPixels[14][11:10] = 2'b11;
					end
					end
				end
		  end
		end
	end
end
	
endmodule 





module LED_test_testbench();
	logic clk;
	logic RST;
	logic [15:0][15:0] RedPixels, GrnPixels;
	logic [7:0] inputKey;
	logic [1:0] SW;
	
	LED_test dut14 (clk, RST, RedPixels, GrnPixels, inputKey, SW);
	
	
	 // Set up a simulated clock.   
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end
   
 // Test the design.
integer i; 
 initial begin   
 
 
	for(i = 0; i <256; i++) begin
    RST <= 1; @(posedge clk); 
    RST <= 0; inputKey = i; SW[0] <= 0; SW[1] <= 0; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     
			SW [0] <= 1; @(posedge clk);   
                      @(posedge clk); 
							                      @(posedge clk);   
                      @(posedge clk);
							                      @(posedge clk);   
                SW[1] <= 1;      @(posedge clk);
							                      @(posedge clk);   
                      @(posedge clk);
							                      @(posedge clk);   
                      @(posedge clk);
							                      @(posedge clk);   
                 SW[0] <= 0; @(posedge clk);

				
				
	  end
  
  $stop; // End the simulation.  
 end 
 
 endmodule 
