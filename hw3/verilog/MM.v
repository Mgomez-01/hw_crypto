module MM (
	   input wire [2:0] A,
	   input wire [2:0] B,
	   input wire	   clk,
	   input wire	   reset,
	   output reg [2:0] Z
	   );

always@(*)
  begin
     Z[0] = (A[0] & B[0]) ^ (A[1] & B[2]) ^ (A[2] & B[1]) ^ (A[2] & B[2]);
     Z[1] = (A[0] & B[1]) ^ (A[1] & B[0]) ^ (A[2] & B[2]);
     Z[2] = (A[0] & B[2]) ^ (A[1] & B[2]) ^ (A[2] & B[0]) ^ (A[2] & B[2]) ^ (A[1] & B[1]) ^ (A[2] & B[1]);
  
  end 
endmodule // MM
