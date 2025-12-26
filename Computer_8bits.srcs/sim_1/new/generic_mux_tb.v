`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:17:53 PM
// Design Name: 
// Module Name: generic_mux_tb
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


module generic_mux_tb(

    );
    
    //1- Delcare local reg and wire
    localparam n =16;
    reg [n-5 : 0] x0, x1, x2;
    reg [n-1 : 0] x3, x4, x5, x6, x7;
    reg [$clog2(n)-2 : 0] s;
    wire [n-1 : 0] w;
    
    //2- Instantiate the module under test
    generic_mux  #(.N(n)) uut(
        .x0(x0),
        .x1(x1),
        .x2(x2),
        .x3(x3),
        .x4(x4),
        .x5(x5),
        .x6(x6),
        .x7(x7),
        .s(s),
        .w(w)
    );
    
    //3- General stimuli using always and initial
    initial 
    begin
       x0 = 16'h0001;;
       x1 = 16'h0010;
       x2 = 16'h0100;
       x3 = 16'h1000;
       x4 = 16'hAAAA;
       x5 = 16'h5555;
       x6 = 16'h0F0F;
       x7 = 16'hF0F0;
       
       for (s = 0; s < 8; s = s + 1)
        begin
            #10;
        end    
    end
    
endmodule
