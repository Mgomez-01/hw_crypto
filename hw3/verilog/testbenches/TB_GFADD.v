`timescale 1ns / 1ps
`include "../GFADD.v"
module TB_GFADD;

   reg [2:0]  A;
   reg [2:0]  B;
   wire [2:0] Z;
   integer file;

   GFADD uut0 (.A(A),.B(B),.Z(Z));
   
   always #10
  begin
     $fwrite(file, "%g\t%b\t%b\t%b\n", $time, A, B, Z);
  end
   
// Test sequence
initial begin
   // Initialize simulation
   file = $fopen("TB_GFADD.log", "w");
   //file2 = $fopen("MM_results.log", "w");
   $display("Time\tA\tB\tZ");
   $fwrite(file,"Time\tA\tB\tZ\n");
   $monitor("%g\t%b\t%b\t%b", $time, A, B, Z);
   #10;       
   A = 3'b010; // A = alpha
   B = 3'b100; // B = alpha^2
   // expecting Z = 3'b101
   #10;
   // Use $display to show a message if the assertion fails
   if (Z !== 3'b110) begin
      $display("Assertion failed: Z is not 3'b110 as expected. Z=%b", Z);
      $fclose(file);
      $stop; // Stop simulation
   end 

   #10;       
   A = 3'b101; // A = alpha^2 + 1
   B = 3'b111; // B = alpha^2 + alpha + 1
   // expecting Z = 3'b010
   #10;
   // Use $display to show a message if the assertion fails
   if (Z !== 3'b010) begin
      $display("Assertion failed: Z is not 3'b010 as expected. Z=%b", Z);
      $fclose(file);
      $stop; // Stop simulation
   end 

    // End simulation
   $display("End of simulation @ %g ns\nIf reached, no errors present in logic.", $time);
   $fwrite(file,"If reached, no errors present in logic.\nEnd of simulation @ %g ns", $time);
   $fclose(file); 
   $finish;
   
end // initial begin

   
endmodule
