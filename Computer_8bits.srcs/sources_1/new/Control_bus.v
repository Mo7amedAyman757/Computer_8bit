`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:16:05 PM
// Design Name: 
// Module Name: Control_bus
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


module Control_bus
    #(parameter mux = 16, encod = 8)(
        input [encod-1:0] x,
        input [mux-1 : 0] In0, In1, In2, In3, In4, In5, In6, In7,
        input EN,
        output [mux-1 : 0] y
    );
    
    wire [$clog2(encod)-1 : 0] sel;
    
    Generic_encoder #(.N(encod)) uut1(
        .x(x),
        .EN(EN),
        .y(sel)
    );
    
    generic_mux #(.N(mux)) uut2(
        .x0(In0),
        .x1(In1),
        .x2(In2),
        .x3(In3),
        .x4(In4),
        .x5(In5),
        .x6(In6),
        .x7(In7),
        .s(sel),
        .w(y)
    );
    
    
endmodule
