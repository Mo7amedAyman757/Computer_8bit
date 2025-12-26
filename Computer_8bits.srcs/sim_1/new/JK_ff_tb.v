`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 09:03:35 PM
// Design Name: 
// Module Name: JK_ff_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module JK_ff_tb;

    reg J, K, rst, clk;
    wire q;
    integer i;
    reg [3:0] dly;

    // Clock
    initial clk = 0;
    always #10 clk = ~clk;

    // Instantiate JK FF
    JK_ff u0 (
        .J(J),
        .K(K),
        .clk(clk),
        .reset(rst),
        .Q(q)
    );

    // 3- General stimuli using always and initial
    
    localparam T = 20; // clock period
    always
    begin
        clk = 1'b0;
        # (T / 2);
        clk = 1'b1;
        # (T / 2);
    end 
    
    initial
    begin
        J = 0;
        K = 0;
        rst = 1;
        #20 rst = 0; // release reset

        // test sequence
        #10 J = 0; K = 0; // Hold
        #20 J = 1; K = 0; // Set
        #20 J = 1; K = 1; // Toggle
        #20 J = 0; K = 1; // Reset
        #20 J = 0; K = 0; // Toggle again
        #50 $stop;

    end

endmodule

