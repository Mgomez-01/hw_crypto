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
   reg [3:0]  P = 3'b1101;
   // P_inv is the poly 1 + x^-1 + x^-3
   reg [3:0]  P_inv = 3'b1011;
   integer file;
   

   MM uut0 (.A(3'b001),.B(A),.clk(clk),.reset(reset),.Z(Z0));
   MM uut1 (.A(3'b001),.B(B),.clk(clk),.reset(reset),.Z(Z1));
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

always@(clk)
  begin
     $fwrite(file, "%g\t%b\t%b\t%b\n", $time, A, B, Z3);
  end


// Test sequence
initial begin
   // Initialize simulation
   file = $fopen("TB_MM.log", "w");
   //file2 = $fopen("MM_results.log", "w");
   $display("Time\tClk\tA\tB\tZ");
   $fwrite(file,"Time\tA\tB\tZ\n");
   $monitor("%g\t%g\t%b\t%b\t%b", $time, clk, A, B, Z3);
   // Reset sequence
   reset = 1; // Activate reset
   #10;       // Hold reset for 10ns
   A = 3'b010; // A = alpha
   B = 3'b100; // B = alpha^2
   // expecting Z = 3'b101
   reset = 0; // Deactivate reset to start the LFSR
   #10;
   // Use $display to show a message if the assertion fails
   if (Z3 !== 3'b101) begin
      $display("Assertion failed: Z is not 3'b101 as expected. Z=%b", Z3);
      $fwrite(file,"Assertion failed: Z is not 3'b101 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end 

   // Reset sequence
   reset = 1; // Activate reset
   #10;       // Hold reset for 10ns
   A = 3'b101; // A = alpha^2 + 1
   B = 3'b111; // B = alpha^2 + alpha + 1
   // expecting Z = 3'b101
   reset = 0; // Deactivate reset to start the LFSR
   #10;
   // Use $display to show a message if the assertion fails
   if (Z3 !== 3'b001) begin
      $display("Assertion failed: Z is not 3'b001 as expected. Z=%b", Z3);
      $fwrite(file, "Assertion failed: Z is not 3'b001 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end 

    // End simulation
   $display("End of simulation @ %g ns\nIf reached, no errors present in logic.", $time);
   $fwrite(file,"\nIf reached, no errors present in logic.\nEnd of simulation @ %g ns", $time);
   $fclose(file);
   $finish;
   
end // initial begin

   
endmodule
