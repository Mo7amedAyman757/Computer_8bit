`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 06:17:53 PM
// Design Name: 
// Module Name: Generic_decoder_tb
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


module Generic_decoder_tb(

    );
    
    //1- Delcare local reg and wire
    localparam n = 2;
    reg [n-1 : 0] x_tb;
    reg EN_tb;
    wire [2**n -1: 0] y_tb;
    
    //2- Instantiate the module under test
     Generic_decoder  #(.N(n)) uut(
        .x(x_tb),
        .EN(EN_tb),
        .y(y_tb)
    );
    
    
    //3- GEN_tberal stimuli using always and initial
    initial 
    begin
       x_tb = 0;
       EN_tb = 0;
       #10
       EN_tb = 1;
       #10
       x_tb = 1;
       EN_tb = 1;
       #10
       x_tb = 2;
       EN_tb = 1;
       #10
       x_tb = 3;
       EN_tb = 1;
    end
    
    
endmodule
