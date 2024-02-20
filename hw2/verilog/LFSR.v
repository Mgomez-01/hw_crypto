
`include "./my_DFF.v"

module LFSR(
    input wire clk,    // Clock input
    input wire reset,  // Asynchronous reset input
    output wire [4:0] q // 5-bit output of the LFSR
);

// Wires for internal connections
wire feedback;

// Instantiate the DFF modules
my_DFF dff0 (.clk(clk), .rst(reset), .rst_val(1'b0), .D(feedback), .Q(q[0]));
my_DFF dff1 (.clk(clk), .rst(reset), .rst_val(1'b0), .D(q[0]),    .Q(q[1]));
my_DFF dff2 (.clk(clk), .rst(reset), .rst_val(1'b1), .D(q[1]),    .Q(q[2]));
my_DFF dff3 (.clk(clk), .rst(reset), .rst_val(1'b0), .D(q[2]),    .Q(q[3]));
my_DFF dff4 (.clk(clk), .rst(reset), .rst_val(1'b0), .D(q[3]),    .Q(q[4]));
// Generate feedback from the XOR of bit 4 (q[4]) and bit 1 (q[1])
assign feedback = q[4] ^ q[1];


endmodule
