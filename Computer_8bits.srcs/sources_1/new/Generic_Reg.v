`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:08:26 PM
// Design Name: 
// Module Name: Generic_Reg
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


module Generic_Reg
    #(parameter N = 16)(
    input clk,
    input reset,
    input LD,
    input INC,
    input CLR,
    input[N-1:0] D,
    output [N-1:0] Q
    );
    
    reg [N-1:0] Q_reg, Q_next;
    
    always @(posedge clk) begin
        if(~reset) 
            Q_reg <= {N{1'b0}};
        else
            Q_reg <= Q_next;
    end
    
    always @(*) begin 
        Q_next = Q_reg;
        if(LD)
            Q_next = D;
        else if(INC) 
            Q_next = Q_reg + 1'b1;
        else if(CLR)
            Q_next = {N{1'b0}};
        else
            Q_next = Q_reg;
    end
    assign Q = Q_reg;
endmodule
