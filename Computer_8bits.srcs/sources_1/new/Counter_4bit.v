`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 06:27:15 PM
// Design Name: 
// Module Name: Counter_4bit
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


module Counter_4bit(
    input clk,
    input reset,
    input CLR,
    output reg [3:0] Q
    );
    
    always @(posedge clk) begin
        if(!reset || CLR) begin
            Q <= {4{1'b0}};
        end else begin
            Q <= Q + 1'b1;
        end
    end
    
endmodule
