`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 09:03:24 PM
// Design Name: 
// Module Name: D_ff_tb
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


module D_ff_tb(

    );
    
    // 1- Declare local wire and reg
    reg D, clk, reset;
    wire Q;
    
    // 2- Insataite block under test
    D_ff D0(
        .D(D),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );
    
    // 3- General stimuli using always and initial
    localparam T = 20; // clock period
    always
    begin
        clk = 1'b0;
        # (T / 2);
        clk = 1'b1;
        # (T / 2);
    end
    
    initial begin
    D     = 0;
    reset = 1;

    @(posedge clk);        // t = 10
    reset = 0;
    D     = 1;

    @(posedge clk);        // t = 30
    D = 0;

    @(posedge clk);        // t = 50
    reset = 1;

    @(posedge clk);        // t = 70
    reset = 0;
    D = 1;

    #10 $stop;
end

     
endmodule
