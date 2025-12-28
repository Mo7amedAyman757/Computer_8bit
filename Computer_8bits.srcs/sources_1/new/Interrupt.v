`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:49:10 PM
// Design Name: 
// Module Name: Interrupt
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


module Interrupt(
    input clk, reset,
    input J_in,K_in,
    input T0,T1,T2,
    input FGI,FGO,
    output R
    );
    
    wire IEN;
    
    JK_ff IEN_uut(
     .clk(clk),
     .reset(reset),
     .J(J_in),
     .K(K_in),
     .Q(IEN)
    );
    
    wire J_R, K_R;
    wire R_fed;
    
    assign J_R = (~(T0 | T1 | T2)) & (FGI | FGO) & IEN;
    assign K_R = (R_fed & T2);
    
    JK_ff R_uut(
     .clk(clk),
     .reset(reset),
     .J(J_R),
     .K(K_R),
     .Q(R_fed)
    );
    
    assign R = R_fed;
endmodule
