`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 06:09:54 PM
// Design Name: 
// Module Name: Generic_decoder
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


module Generic_decoder
    #(parameter N = 3)(
    input [N-1 : 0] x,
    input EN,
    output reg [2**N-1:0] y
    );
    
    always @(x,EN) begin
        y = {2**N{1'b0}};
        if (EN) begin
            y[x] = 1'b1;
        end
    end
    
endmodule
