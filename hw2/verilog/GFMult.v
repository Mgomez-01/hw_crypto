module GFMult (
	       input wire	 clk, // Clock input
	       input wire	 reset, // Asynchronous reset input
	       input wire [2:0]	 A, // 3-bit input of the Multiplier
	       input wire [2:0]	 B, // 3-bit input of the Multiplier
	       output reg [2:0] Z // 3-bit output of the Multiplier
	       
	       );
   wire				 s0, s1, s2, s3, s4;

   assign s0 = A[0]&B[0];
   assign s1 = A[1]&B[0] ^ A[0]&B[1];
   assign s2 = A[2]&B[0] ^ A[1]&B[1] ^ A[0]&B[2];
   assign s3 = A[2]&B[1] ^ A[1]&B[2];
   assign s4 = A[2]&B[2];
   
always@(posedge reset, negedge clk) begin
   if(reset) begin
      Z <= 3'b0;
   end   
   else begin
      Z[0] <= (s0 ^ s3 ^ s4);
      Z[1] <= (s1 ^ s4);
      Z[2] <= (s2 ^ s3 ^ s4);      
   end 
end
   
endmodule
