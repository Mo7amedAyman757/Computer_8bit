`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:17:34 PM
// Design Name: 
// Module Name: generic_mux
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


module generic_mux
    #(parameter N = 16)(
        input[N-5:0] x0,x1,x2, // AR and PC are 12-bits
        input[N-1:0] x3,x4,x5,x6,x7, // DR,AC,IR,TR,MEM
        input [2:0] s,
        output reg [N-1:0] w
    );
    
    always @(*) begin
        case(s)
            3'b000: w = x0;
            3'b001: w = {4'b0,x1};
            3'b010: w = {4'b0,x2};
            3'b011: w = x3;
            3'b100: w = x4;
            3'b101: w = x5;
            3'b110: w = x6;
            3'b111: w = x7;
            default: w = {N{1'b0}};
        endcase
    end
    
endmodule
