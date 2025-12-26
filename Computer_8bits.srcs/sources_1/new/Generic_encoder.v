`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:15:45 PM
// Design Name: 
// Module Name: Generic_encoder
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


module Generic_encoder
    #(parameter N = 8)(
        input [N-1:0] x,
        input EN,
        output reg [$clog2(N)-1 : 0] y
    );
    
    always @(x,EN) begin
        y = 'b0;
        if(EN) 
            case(x)
                8'b00000001: y = 3'b000;
                8'b00000010: y = 3'b001;
                8'b00000100: y = 3'b010;
                8'b00001000: y = 3'b011;
                8'b00010000: y = 3'b100;
                8'b00100000: y = 3'b101;
                8'b01000000: y = 3'b110;
                8'b10000000: y = 3'b111;   
                default:     y = 3'bxxx;
            endcase
           
    end
        
endmodule
