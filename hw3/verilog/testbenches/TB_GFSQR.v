`timescale 1ns / 1ps
`include "../GFSQR.v"
module TB_GFSQR;

   reg [2:0]  A;
   wire [2:0] Z;
   integer file;

   GFSQR uut0 (.A(A),.Z(Z));
  
   always #10
     begin
	$fwrite(file, "%g\t%b\t%b\n", $time, A, Z);
     end
   
// Test sequence
initial begin
   // Initialize simulation
   file = $fopen("TB_GFSQR.log", "w");
   //file2 = $fopen("MM_results.log", "w");
   $display("Time\tA\tZ");
   $fwrite(file,"Time\tA\tZ\n");
   $monitor("%g\t%b\t%b", $time, A, Z);
   #10;       
   A = 3'b010; // A = alpha
   // expecting Z = 3'b100 or alpha^2
   #10;
   // Use $display to show a message if the assertion fails
   if (Z !== 3'b100) begin
      $display("Assertion failed: Z is not 3'b100 as expected. Z=%b", Z);
      $fclose(file);
      $stop; // Stop simulation
   end 

   #10;       
   A = 3'b001; // A =  1
   // expecting Z = 3'b001 or 1
   #10;
   // Use $display to show a message if the assertion fails
   if (Z !== 3'b001) begin
      $display("Assertion failed: Z is not 3'b001 as expected. Z=%b", Z);
      $fclose(file);
      $stop; // Stop simulation
   end 

   #10;       
   A = 3'b011; // A =  alpha + 1
   // expecting Z = 3'b101 or alpha^2 + 1
   #10;
   // Use $display to show a message if the assertion fails
   if (Z !== 3'b101) begin
      $display("Assertion failed: Z is not 3'b101 as expected. Z=%b", Z);
      $fclose(file);
      $stop; // Stop simulation
   end 

    // End simulation
   $display("End of simulation @ %g ns\nIf reached, no errors present in logic.", $time);
   $fwrite(file,"If reached, no errors present in logic.\nEnd of simulation @ %g ns", $time);
   $finish;
   
end // initial begin

   
endmodule
