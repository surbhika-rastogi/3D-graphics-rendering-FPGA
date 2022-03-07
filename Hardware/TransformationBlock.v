module TransformationBlock ();
	
	parameter n = 100;
	input [3-1,0] vertices [n-1:0];
	input [3-1,0] faces [n-1:0] ;
	input [3-1:0] displacement;
	input [3-1:0] angle; //in radians
	
// vertices - array of 3-element array (x,y,z cordinate of each vertex)
// faces - array of 3 element array (3 vertices index for each triangle)

	//rotation matrix using eulers angles
	//reg [3-1:0] rotation_matrix [3-1:
	
	always @(angle, displacement)
		begin
			
			//linear transformation
			for(i=0; i<cells-2; i=1+1) begin
				vertices[i] = vertices[i] + displacement;
			end
			
			