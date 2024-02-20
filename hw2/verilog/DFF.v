module DFF (
    input wire clk, // Clock input
    input wire rst, // Asynchronous reset input, active high
    input wire rst_val, // Asynchronous reset value
    input wire D, // Data input D
    output reg Q       // Output Q
);

    // Describe the behavior of the DFF with always block.
   // on all posedges of clock or reset, we run this always block
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Q <= rst_val; // Reset Q to 0 when rst is high
        end
        else begin
            Q <= D; // On rising edge of clk, load D into Q
        end
    end

endmodule
