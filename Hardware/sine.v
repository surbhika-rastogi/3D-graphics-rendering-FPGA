module sine ( input theta, output data_val); //theta in radians

	localparam ROM_DEPTH=64;  // number of entries in sine ROM for 0° to 90°
	localparam ROM_WIDTH=8;  // width of sine ROM data in bits
   
	reg [ROM_WIDTH-1:0] inp_sin_block [0:ROM_DEPTH-1];
	localparam pi_by_2 = 1.5463;
	 
	 initial begin
	 $readmemh("sine_table_64x8.hex",inp_sin_block);
	 end
	 
	integer addr_id;
	reg val;
	 always @(theta) begin
	 
		if ((theta > 0) && (theta <= pi_by_2)) begin
			addr_id = (ROM_DEPTH/pi_by_2)*theta;
			end
		
		else if ((theta > pi_by_2) && (theta <= 2*pi_by_2)) begin
			addr_id = (ROM_DEPTH/pi_by_2)*(2*pi_by_2 - theta); //id = pi - theta
			end
			
		else if ((theta > 2*pi_by_2) && (theta <= 3*pi_by_2)) begin
			addr_id = (ROM_DEPTH/pi_by_2)*(theta - 2*pi_by_2 ); //id = theta - pi
			
			end
				
		else if ((theta > 3*pi_by_2) && (theta <= 4*pi_by_2)) begin
			addr_id = (ROM_DEPTH/pi_by_2)*(4*pi_by_2 - theta ); //id = theta - pi
			end
	 end
	 
	 always @(*) begin
	 
		if ((theta > 0) && (theta <= 2*pi_by_2)) begin
			val = inp_sin_block[addr_id];
			end
		
		else if ((theta > 2*pi_by_2) && (theta <= 4*pi_by_2)) begin
			val = -1.0000 * inp_sin_block[addr_id];
			end
	end
	
	assign data_val = val;
	 
endmodule
