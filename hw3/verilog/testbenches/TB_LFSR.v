`timescale 1ns / 1ps
`include "../LFSR.v"
module LFSR_5bit_tb;

reg clk;
reg reset;
reg encrypting;
reg [4:0] initial_state;
reg [4:0] state_count; 
reg [4:0] C; 
reg [4:0] decrypted; 
reg [4:0] P;
wire [4:0] q;
integer file;
integer file2;
integer num_def;
   
// Instantiate the LFSR module
LFSR uut (
    .clk(clk),
    .reset(reset),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a clock with a period of 10ns
end
    // Continuous monitoring and writing to file
    always @(posedge clk or reset or q) begin
       // This will write to the file on changes to clk, reset, or q
       $fwrite(file, "%g\t%g\t%b\t%b\t%b\n", state_count, $time, clk, reset, q);
    end
    always @(posedge clk) begin
       // This will write to the file on changes to clk, reset, or q
       if(encrypting == 1'b1) begin
	  C = P^q;
	  decrypted[num_def] = C[num_def]^q[num_def];
	  $fwrite(file2, "%g\t%b\t%b\t%b\t%b\n", $time, P, q, C, decrypted);
	  if(state_count == 6) begin
	     $fclose(file);
	     $fclose(file2);
	     $finish; // all states reached. complete
	  end
	  num_def = num_def + 1;
       end
    end

   always@(q) begin
      state_count = state_count + 1;
   end
   
// Test sequence
initial begin
    // Initialize simulation
   file = $fopen("TB_LFSR.log", "w");
   file2 = $fopen("LFSR_results.log", "w");
   $display("State\tTime\tClk\tReset\tQ");
   $fwrite(file,"State\tTime\tClk\tReset\tQ\n");
   $fwrite(file2,"Time\tP\tQ\tC\tdecrypted\n");
   state_count = 4'b0;
   num_def = 0;
   P = 5'b01101;
   $monitor("%g\t%g\t%b\t%b\t%b", state_count, $time, clk, reset, q);
    // Reset sequence
    reset = 1; // Activate reset
    #10;       // Hold reset for 10ns
    reset = 0; // Deactivate reset to start the LFSR

    // Let the LFSR run for a while
    #1000;

    // End simulation
   $display("End of simulation @ %g ns", $time);
   $fwrite(file,"End of simulation @ %g ns", $time);
end // initial begin

   // Test sequence
initial begin
    // Initialize simulation
    reset = 1; // Assert reset
    #10;       // Wait for the reset to take effect
    reset = 0; // Release reset
    initial_state = q; // Capture the initial state after reset
    #10; // Wait a bit before starting checks

    // Run the LFSR for a while
repeat (2**5 - 1) begin // Run for the maximal length sequence
    @(posedge clk);
    // Check that LFSR never enters an all-zero state
    if (q == 5'b00000) begin
        $display("Error: LFSR entered all-zero state at time %t", $time);
        $fwrite(file,"Error: LFSR entered all-zero state at time %t\n", $time);
       $fclose(file); 
        $fwrite(file2,"Error: LFSR entered all-zero state at time %t\n", $time);
       $fclose(file2); 
       $stop; // Terminate the simulation
    end
    
    // After a full cycle, check if the LFSR returns to the initial state
    if ($time > 10 && q == initial_state) begin
       $display("Success: LFSR returned to initial state %b at time %t", initial_state, $time);
       $fwrite(file,"Success: LFSR returned to initial state %b at time %t\n", initial_state, $time);
        @(posedge clk); // Wait for one more clock cycle to confirm it's cycling
        if (q == initial_state) begin
            $display("Error: LFSR is stuck in initial state at time %t", $time);
	   $fwrite(file,"Error: LFSR is stuck in initial state at time %t\n", $time);
	   $fclose(file);
	   $fwrite(file2,"Error: LFSR is stuck in initial state at time %t\n", $time);
	   $fclose(file2);
	   $stop; // stop the simulation
        end
       // Now that we verified we can simulate the encryption with the xor of the bits.
       encrypting = 1;
    end
end
if(encrypting == 0) begin
// If the simulation reaches this point and not encrypting, the LFSR did not cycle correctly
$display("Error: LFSR did not cycle through a maximal length sequence.");
$fwrite(file,"Error: LFSR did not cycle through a maximal length sequence.\n");
      $fclose(file);
   $stop;

end   
end // initial begin
   

endmodule
