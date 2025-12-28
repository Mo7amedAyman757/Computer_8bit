`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:16:40 PM
// Design Name: 
// Module Name: generic_reg_tb
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


module generic_reg_tb(

    );
    //1- Declare local wire and reg
    localparam n = 16;
    reg clk, reset, LD, CLR, INC;
    reg [n-1: 0] D_in;
    wire [n-1: 0] D_out;
    
    
    //2- Instantiate the module under test
    Generic_Reg #(.N(n)) uut(
        .clk(clk),
        .reset(reset),
        .LD(LD),
        .CLR(CLR),
        .INC(INC),
        .D(D_in),
        .Q(D_out)
    );
    
    //3- General stimuli uing always and initial
    localparam T = 20; // clock period
    always
    begin
        clk = 1'b0;
        # (T / 2);
        clk = 1'b1;
        # (T / 2);
    end
    
    initial
    begin
    
    // initialization
        LD = 0;
        CLR = 0;
        INC = 0;
        D_in = 0;
        reset = 0;
        
        @(posedge clk) CLR = 1;
        reset = 1;
        @(negedge clk) CLR = 0;
        LD = 1;
        D_in = 16;
        
        @(negedge clk) INC = 1;
        LD = 0;
        
        @(negedge clk) INC = 0;
        LD = 0;
        CLR = 1;
        
        @(negedge clk) $stop;
     
    end
    
endmodule
