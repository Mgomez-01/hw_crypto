`timescale 1ns / 1ps
`include "../MM.v"
module TB_MM;

   reg        clk;
   reg	      clk2;
   reg	      reset;
   reg [2:0]  A;
   reg [2:0]  B;
   wire [2:0] Z0;
   wire [2:0] Z1;
   wire [2:0] Z2;
   wire [2:0] Z3;
   // P is the poly x^3 + x^2 + 1
   reg [2:0]  P = 3'b111;
   // P_inv is the poly 1 + x^-1 + x^-3
   reg [2:0]  P_inv = 3'b011;
   

   MM uut0 (.A(P),.B(A),.clk(clk),.reset(reset),.Z(Z0));
   MM uut1 (.A(P),.B(B),.clk(clk),.reset(reset),.Z(Z1));
   MM uut2 (.A(Z0),.B(Z1),.clk(clk),.reset(reset),.Z(Z2));
   MM uut3 (.A(Z2),.B(3'b001),.clk(clk),.reset(reset),.Z(Z3));


     // Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a clock with a period of 10ns
end

     // Clock generation
initial begin
    clk2 = 0;
    forever #20 clk2 = ~clk2; // Generate a clock with a period of 10ns
end

   always@(posedge clk2) begin
      A = A + 1;
      if(A == 0) begin
	 B = B + 1;
      end
   end

// Test sequence
initial begin
   // Initialize simulation
   //file = $fopen("TB_MM.log", "w");
   //file2 = $fopen("MM_results.log", "w");
   $display("Time\tClk\tA\tB\tZ0\tZ1\tZ2\tZ3");
   //$fwrite(file,"\tTime\tClk\tA\tB\tZ\n");
   $monitor("%g\t%g\t%b\t%b\t%b\t%b\t%b\t%b", $time, clk, A, B, Z0, Z1, Z2, Z3);
   // Reset sequence
   reset = 1; // Activate reset
   #25;       // Hold reset for 10ns
   A = 3'b0;
   B = 3'b0;
   reset = 0; // Deactivate reset to start the LFSR
   

    // Let the LFSR run for a while
    #16500;

    // End simulation
   $display("End of simulation @ %g ns", $time);
   //$fwrite(file,"End of simulation @ %g ns", $time);
   $finish;
   
end // initial begin

   
endmodule
