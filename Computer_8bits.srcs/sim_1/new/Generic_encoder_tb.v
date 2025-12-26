`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:16:18 PM
// Design Name: 
// Module Name: Generic_encoder_tb
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


module Generic_encoder_tb(

    );
    
    //1- Delcare local reg and wire
    localparam n = 8;
    reg [n-1 : 0] x;
    reg EN;
    wire [$clog2(n)-1 : 0] y;
    
    //2- Instantiate the module under test
    Generic_encoder  #(.N(n)) uut(
        .x(x),
        .EN(EN),
        .y(y)
    );
    
    //3- General stimuli using always and initial
    initial 
    begin
       EN = 0;
       x = 1;
       
       #10;
       EN = 1;
       
       #10
       x = 4;
       
       #10
       x = 1;
       
       #10
       x = 8;
       
       #10
       x = 16;
       
       #10
       x = 32;
       
       #10
       x = 64;
       
       #10
       x = 128;
    
    end
endmodule
