module MM (
	   input wire [2:0] A,
	   input wire [2:0] B,
	   input wire	   clk,
	   input wire	   reset,
	   output reg [2:0] Z
	   );

   // add in the signals that are combinational below for MM block.

   // this represents the P(x) or 1*x^3 + 1*x^2 + 0*x + 1*1 = 4'b1101
   // a^-k = a^-3 or the cube of the inverse of a, or the inverse of the cube of a.
   // inv of cube is a^4 = a*(a^3) = a*(a^2 + 1) = a^3 + a = a^2 + a + 1 = 0111
   wire [3:0]		    _P = 4'b1101;
   reg [3:0]		    mid0_0;
   reg [3:0]		    mid0_1;
   reg [3:0]		    mid0_2;

   reg [3:0]		    mid1_0;
   reg [3:0]		    mid1_1;
   reg [3:0]		    mid1_2;

   reg [3:0]		    mid2_0;
   reg [3:0]		    mid2_1;
   reg [3:0]		    mid2_2;
   

   
   // previously clocked on posedge reset and negedge clk
   always@(*) begin
      if(reset) begin
	 Z = 3'b0;
	 // mid0_0 <= 4'b0;
	 // mid0_1 <= 4'b0;
	 // mid0_2 <= 4'b0;

	 // mid1_0 <= 4'b0;
	 // mid1_1 <= 4'b0;
	 // mid1_2 <= 4'b0;

	 // mid2_0 <= 4'b0;
	 // mid2_1 <= 4'b0;
	 // mid2_2 <= 4'b0; 
      end
      else begin
	 // mid0_0 <= 4'b0 ^ ({4{A[0]}} & B);
         // mid0_1 <= mid0_0 ^ ({4{mid0_0[0]}} & _P); // This relies on previous step's result
         // mid0_2 <= mid0_1 >> 1;
	 
         // mid1_0 <= mid0_2[1] ^ ({4{A[1]}} & B); // This starts with the result of mid0_2
         // mid1_1 <= mid1_0 ^ ({4{mid1_0[0]}} & _P);
         // mid1_2 <= mid1_1 >> 1;

         // mid2_0 <= mid1_2[2] ^ ({4{A[2]}} & B);
         // mid2_1 <= mid2_0 ^ ({4{mid2_0[0]}} & _P);
         // mid2_2 <= mid2_1 >> 1;
	 mid0_0 = 4'b0^({4{A[0]}}&B);
	 mid0_1 = mid0_0^({4{mid0_0[0]}}&_P);
	 mid0_2 = mid0_1 >> 1'b1;


	 mid1_0 = mid0_2[1]^({4{A[1]}}&B);
	 mid1_1 = mid1_0^({4{mid1_0[0]}}&_P);
	 mid1_2 = mid1_1 >> 1'b1;


	 mid2_0 = mid1_2[2]^({4{A[2]}}&B);
	 mid2_1 = mid2_0^({4{mid2_0[0]}}&_P);
	 mid2_2 = mid2_1 >> 1'b1;
 	 
	 Z = mid2_2[2:0];      
      // Z[1] <= Z[1]^({A[1],A[1],A[1]}&B);      
      // Z[2] <= Z[2]^({A[2],A[2],A[2]}&B);
      end
   end
endmodule // MM
