`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 06:27:32 PM
// Design Name: 
// Module Name: Counter_4bit_tb
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


module Counter_4bit_tb(

    );
     //1- Delcare local reg and wire
    reg clk_tb, reset_tb, CLR_tb;
    wire [3:0] Q_tb;
    
    //2- Instantiate the module under test
    Counter_4bit uut(
        .clk(clk_tb),
        .reset(reset_tb),
        .CLR(CLR_tb),
        .Q(Q_tb)
    );
    
    //3- General stimuli using always and initial
    localparam T = 20;
    always begin
        clk_tb = 1'b0;
        #(T / 2); 
        clk_tb = 1'b1;
        #(T / 2); 
    end
    
    initial 
    begin 
        //Initialize
        reset_tb = 1'b1;
        
        // Release clear, enable system 
        @(negedge clk_tb) reset_tb = 1'b0; 
        @(negedge clk_tb) reset_tb = 1'b1; 
        repeat(3) @(posedge clk_tb) CLR_tb = 1'b1; 
        @(posedge clk_tb) CLR_tb = 1'b0; 
        // Run through full sequence (16 cycles)
        repeat (16) @(posedge clk_tb); 
    end
    
endmodule
