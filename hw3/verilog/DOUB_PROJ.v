`include "GFSQR.v"

module DOUB_PROJ (
	   input wire [2:0] X1,
	   input wire [2:0] Y1,
	   input wire [2:0] Z1,
	   output wire [2:0] X3,
	   output wire [2:0] Y3,
	   output wire [2:0] Z3
	   );

   wire [2:0]		    A, B, YZ;
   wire [2:0]		    Zsq, Xsq, Asq;
   wire [2:0]		    Zsqsq, Xsqsq;
   wire [2:0]		    X1sq_YZ_A;
   wire [2:0]		    Temp_Y3_1;
   wire [2:0]		    Temp_Y3_2;
   
   MM     T0(.A(X1),.B(Z1),.Z(A)); //A = XZ
   MM     T1(.A(Y1),.B(Z1),.Z(YZ)); // YZ = Y1*Z1

   GFSQR  T2(.A(X1),.Z(Xsq));     //X^2
   GFSQR  T3(.A(Xsq),.Z(Xsqsq));  //X^4

   GFSQR  T4(.A(Z1),.Z(Zsq));     //Z^2
   GFSQR  T5(.A(Zsq),.Z(Zsqsq));  //Z^4

   assign B = Zsqsq ^ Xsqsq;
   
   MM     T6(.A(A),.B(B),.Z(X3)); // X3

   assign X1sq_YZ_A = Xsq ^ YZ ^ A; // (X^2 + YZ + A)

   MM    T7(.A(Xsqsq),.B(A),.Z(Temp_Y3_1)); // X^4 A

   MM    T8(.A(B),.B(X1sq_YZ_A),.Z(Temp_Y3_2)); // X^4 A

   assign Y3 = Temp_Y3_1 ^ Temp_Y3_2; // Y3
   
   GFSQR T9(.A(A),.Z(Asq)); // A^2

   MM    T10(.A(Asq),.B(A),.Z(Z3)); // Z3 = A^3 
   
   
endmodule // DOUB_PROJ
