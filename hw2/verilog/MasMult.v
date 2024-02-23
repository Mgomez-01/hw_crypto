`include "MM.v"
module MasMult (
	   input wire [2:0] A,
	   input wire [2:0] B,
	   input wire	   clk,
	   input wire	   reset,
	   output wire [2:0] Z
	   );

   wire [2:0]		    T0;
   wire [2:0]		    T1;
   wire [2:0]		    T2;
   reg [2:0]		    P = 3'b111;
   
   MM uut0 (.A(P),.B(A),.clk(clk),.reset(reset),.Z(T0));
   MM uut1 (.A(P),.B(B),.clk(clk),.reset(reset),.Z(T1));
   MM uut2 (.A(T0),.B(T1),.clk(clk),.reset(reset),.Z(T2));
   MM uut3 (.A(T2),.B(3'b001),.clk(clk),.reset(reset),.Z(Z));
   
endmodule
