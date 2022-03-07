module sine (input [15:0] inp_angle, output [15:0] data_val); //theta in angle
	
	
	localparam ROM_DEPTH=64;  // number of entries in sine ROM for 0° to 90°
	localparam ROM_WIDTH=8;  // width of sine ROM data in bits
   
	reg [ROM_WIDTH-1:0] inp_sin_block [0:ROM_DEPTH-1];
	localparam integer pi_by_2 = 90;
	 
	 initial begin
	 $readmemh("sine_table_64x8.hex",inp_sin_block);
	 end
	 
	integer addr_id;
	reg [15:0] val;
	reg [15:0] theta;

	//assign theta = inp_angle;
	always @(*) begin
		
		if (inp_angle >= 4*pi_by_2) begin
			theta = inp_angle - 4*pi_by_2;
			//$display("%d",theta);
			end
		else if (inp_angle <= 0) begin
			theta = inp_angle + 4*pi_by_2;
			//$display("%d",theta);
			end
		else theta = inp_angle;
	end



	 always @(*) begin
	 
		if ((theta >= 0) && (theta < pi_by_2)) begin
			addr_id = (ROM_DEPTH*theta)/pi_by_2;
			
			//$display("1q:addr_id : %d",addr_id);
			end
		
		else if ((theta >= pi_by_2) && (theta < 2*pi_by_2)) begin
			addr_id = (ROM_DEPTH*(2*pi_by_2 - theta))/pi_by_2; //id = pi - theta
			//$display("2q:addr_id : %d",addr_id);
			end
			
		else if ((theta >= 2*pi_by_2) && (theta < 3*pi_by_2)) begin
			addr_id = (ROM_DEPTH*(theta - 2*pi_by_2 ))/pi_by_2; //id = theta - pi
			//$display("3q:addr_id : %d",addr_id);
			end
				
		else if ((theta >= 3*pi_by_2) && (theta < 4*pi_by_2)) begin
			addr_id = (ROM_DEPTH*(4*pi_by_2 - theta ))/pi_by_2; //id = theta - pi
			//$display("4q:addr_id : %d",addr_id);
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
	
	always@(*) begin
		if (addr_id > 63) begin
			addr_id = 63;
			end
		else if (addr_id < 0) begin
			addr_id = 0;
			end
	end
			
	assign data_val = val;
	 
endmodule
