`timescale 1ns / 1ps
`include "../MasMult.v"
module TB_MasMult;

   reg        clk;
   reg	      clk2;
   reg	      reset;
   reg [2:0]  A;
   reg [2:0]  B;
   wire [2:0] Z;

   MasMult uut(.A(A),.B(B),.clk(clk),.reset(reset),.Z(Z));
  
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
   $display("Time\tClk\tA\tB\tZ\n");
   //$fwrite(file,"\tTime\tClk\tA\tB\tZ\n");
   $monitor("%g\t%g\t%b\t%b\t%b\n", $time, clk, A, B, Z);
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
