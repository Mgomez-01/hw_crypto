module GFADD (
	   input wire [2:0] A,
	   input wire [2:0] B,
	   output reg [2:0] Z
	   );

always@(*)
  begin
     Z = A ^ B;
  end 
endmodule // GFADD
