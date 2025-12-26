`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 09:00:49 PM
// Design Name: 
// Module Name: JK_ff
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


module JK_ff(
    input clk,
    input reset,
    input J,K,
    output reg Q
    );
    
    always @ (posedge clk) begin
		if (reset) begin
			Q <= 0;
		end else begin
	  	    Q <= (J & ~Q) | (~K & Q);
	    end
    end
    
endmodule
