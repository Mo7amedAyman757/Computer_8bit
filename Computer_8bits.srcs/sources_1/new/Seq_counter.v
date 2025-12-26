`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 05:57:26 PM
// Design Name: 
// Module Name: Seq_counter
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

module Seq_counter
    #(parameter N = 4)(
    input [3:0] clk,
    input reset, CLR,
    input S, //HLT
    output [2**4-1:0] T
    );
    
    wire [3:0] Q;
    
    Counter_4bit uut1(
        .clk(clk),
        .reset(reset),
        .CLR(CLR),
        .Q(Q)       
    );
    
    Generic_decoder #(.N(N)) uut2(
        .x(Q),
        .EN(S),
        .y(T)
    );  
    
endmodule
