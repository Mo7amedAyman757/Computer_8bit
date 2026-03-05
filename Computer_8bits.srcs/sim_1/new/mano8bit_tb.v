`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2026 02:10:25 PM
// Design Name: 
// Module Name: mano8bit_tb
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


module mano8bit_tb(

    );

    //1- Declare local reg and wire
    reg clk, reset;
    reg [7:0] in;
    wire [7:0] out;

    //2- Instantiate the Unit Under Test (UUT)
    Mano_8bit uut (
        .clk(clk),
        .reset(reset),
        .in_data(in),
        .out_data(out)
    );

    //3- Generate clock
    localparam T = 20;
    always begin
        clk = 1'b0;
        #(T/2);
        clk = 1'b1;
        #(T/2); // Toggle clock every 5 time units
    end
    
    initial
    begin
        reset = 1'b0;
        #5 reset = 1'b1;
        in = 8'b0010;
    end
    
    
endmodule
