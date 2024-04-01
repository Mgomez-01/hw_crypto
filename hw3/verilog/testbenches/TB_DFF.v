//-----------------------------------------------------------------------------
// Title         : DFF Testbench
// Project       : HW 2 - HW Cryptography
//-----------------------------------------------------------------------------
// File          : TB_DFF.v
// Author        : Miguel  <speedy@zbookThrone>
// Created       : 14.02.2024
// Last modified : 14.02.2024
//-----------------------------------------------------------------------------
// Description :
// 
//-----------------------------------------------------------------------------
// Copyright (c) 2024 by UofU This model is the confidential and
// proprietary property of UofU and the possession or use of this
// file requires a written license from UofU.
//------------------------------------------------------------------------------
// Modification history :
// 14.02.2024 : created
//-----------------------------------------------------------------------------

 
`timescale 1ns / 1ps
`include "../my_DFF.v"

module DFF_tb; // Test bench module, no ports needed

   // Test bench internal signals
   reg clk;
   reg	rst;
   reg	D;
   wire	Q;
   integer count = 0;
   
    // Instantiate the DFF module
    my_DFF uut (
        .clk(clk),
        .rst(rst),
        .D(D),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0; // Initial clock value
        forever #1 clk = ~clk; // Toggle clock every 5 ns
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1; // Apply reset
        D = 0;
        #5; // Wait for 10 ns
        
        rst = 0; // Release reset
        D = 1;
        #5; // Wait for 10 ns to observe D flip-flop capturing this value
        
        D = 0;
        #5; // Wait for 10 ns
        
        D = 1;
        #5; // Change D to see the effect on the next clock edge
        
    end
    // Optional: Monitor changes
    initial begin
        $monitor("Time=%t, clk=%b, rst=%b, D=%b, Q=%b", $time, clk, rst, D, Q);
    end

      // Counter and simulation stop logic
    initial begin
        while (count <= 10) begin
            @(posedge clk); // Wait for the positive edge of clk
            count = count + 1; // Increment count
        end
        $display("Count reached 10, stopping simulation.");
        $stop; // Stop the simulation when count reaches 10    
		  end
   
endmodule
