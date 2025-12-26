`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 08:57:45 PM
// Design Name: 
// Module Name: D_ff
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


module D_ff(
    input clk,
    input reset,
    input D,
    output reg Q
    );
    
    always @(posedge clk) begin
        if(reset) 
            Q <= 1'b0;
        else
            Q <= D;   
    end   
    
endmodule
