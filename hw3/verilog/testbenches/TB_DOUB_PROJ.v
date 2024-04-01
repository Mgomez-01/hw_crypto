`timescale 1ns / 1ps
`include "../DOUB_PROJ.v"
module TB_DOUB_PROJ;

   reg [2:0]  X1,Y1,Z1;
   wire [2:0] X3,Y3,Z3;
   integer file;

   DOUB_PROJ uut0 (.X1(X1),.Y1(Y1),.Z1(Z1),.X3(X3),.Y3(Y3),.Z3(Z3));
  
   always #10
     begin
	$fwrite(file, "%g\t%b\t%b\t%b\t%b\t%b\t%b\n", $time, X1, Y1, Z1, X3, Y3, Z3);
     end
   
// Test sequence
initial begin
   // Initialize simulation
   file = $fopen("TB_DOUB_PROJ.log", "w");
   //file2 = $fopen("MM_results.log", "w");
   $display("Time\tX1\tY1\tZ1\tX3\tY3\tZ3");
   $fwrite(file,"Time\tX1\tY1\tZ1\tX3\tY3\tZ3\n");
   $monitor("%g\t%b\t%b\t%b\t%b\t%b\t%b", $time, X1, Y1, Z1, X3, Y3, Z3);
   #10;       
   X1 = 3'b010; // 
   Y1 = 3'b001; // 
   Z1 = 3'b001; // 
   #10;
   // Use $display to show a message if the assertion fails
   if (Z3 !== 3'b101) begin
      $display("Assertion failed: Z is not 3'b100 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end 

   #10;
   // corresponding point is P1
   X1 = 3'b101; // A^2 + 1
   Y1 = 3'b011; // A + 1
   Z1 = 3'b001; // 1 
   // expecting Z = 3'b001 or 1
   #10;
   // Use $display to show a message if the assertion fails 
   if (Z3 !== 3'b100) begin
      $display("Assertion failed: Z is not 3'b001 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end 

   #10;       
   X1 = 3'b011; // A =  alpha + 1
   Y1 = 3'b001; // 
   Z1 = 3'b001; // 
  // expecting Z = 3'b101 or alpha^2 + 1
   #10;
   // Use $display to show a message if the assertion fails
   if (Z3 !== 3'b010) begin
      $display("Assertion failed: Z is not 3'b101 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end
   
   #10;       
   X1 = 3'b000; // A =  alpha + 1
   Y1 = 3'b001; // 
   Z1 = 3'b001; // 
  // expecting Z = 3'b101 or alpha^2 + 1
   #10;
   // Use $display to show a message if the assertion fails
   if (Z3 !== 3'b000) begin
      $display("Assertion failed: Z is not 3'b101 as expected. Z=%b", Z3);
      $fclose(file);
      $stop; // Stop simulation
   end 

    // End simulation
   $display("End of simulation @ %g ns\nIf reached, no errors present in logic.", $time);
   $fwrite(file,"If reached, no errors present in logic.\nEnd of simulation @ %g ns", $time);
   $finish;
   
end // initial begin

   
endmodule
