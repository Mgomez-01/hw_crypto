`include "./MM.v"

module GFSQR (
	   input wire [2:0] A,
	   output wire [2:0] Z
	   );

     wire [2:0] B = A;

   MM sqrer(.A(A),.B(B),.Z(Z));
   
endmodule // GFSQR
