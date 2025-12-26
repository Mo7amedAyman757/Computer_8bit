`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 06:54:43 PM
// Design Name: 
// Module Name: memory
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


module memory
    #(parameter DATA_WIDTH = 16, ADDR_WIDTH = 12)(
    input clk,
    input wr,
    input rd,
    input [DATA_WIDTH-1 : 0] D_in,
    input [ADDR_WIDTH-1 : 0] ADDR,
    output reg [DATA_WIDTH-1 : 0] D_out
    );
    localparam DEPTH = 1 << ADDR_WIDTH;
    reg [DATA_WIDTH-1 : 0] mem [0: DEPTH -1];
    
    always @(posedge clk) begin
        // WRITE
        if(wr) 
        mem[ADDR] <= D_in;         
        
        // READ
        if (rd) 
        D_out <= mem[ADDR];
        
    end
   
endmodule
