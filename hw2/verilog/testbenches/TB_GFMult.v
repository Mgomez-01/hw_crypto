`timescale 1ns / 1ps
`include "../GFMult.v"
module TB_GFMult;


   reg [2:0]   A,B;
   wire [2:0]  Z;
   reg	       clk;
   reg	       reset;
   integer     file;

   
   
   
   GFMult uut (.A(A), .B(B), .Z(Z), .reset(reset), .clk(clk)
);
   // Clock generation
initial begin
    clk = 0;
    forever #25 clk = ~clk; // Generate a clock with a period of 10ns
end
   always@(posedge clk) begin
      A = A + 1;
      if(A == 0) begin
	 B = B + 1;
      end
   end

   always@ (A, B, Z) begin
      $display("%g\t%b\t%b\t%b", $time, A, B, Z);
      $fwrite(file, "%g\t%b\t%b\t%b\n", $time, A, B, Z);
   end
   
// Test sequence
initial begin
    // Initialize simulation
   file = $fopen("TB_GFMult.log", "w");
   $display("Time\tA\tB\tZ");
   $fwrite(file,"Time\tA\tB\tZ\n");
   clk = 0;
   B = 3'd0;
   A = 3'd0;
   // Reset sequence
   reset = 1; // Activate reset
   #10;       // Hold reset for 10ns
   reset = 0; // Deactivate reset to start the LFSR
   B = 3'd0;
   A = 3'd0;

    // Let the LFSR run for a while
    #3150;
   $fclose(file); 
   $finish;
   
end


endmodule
