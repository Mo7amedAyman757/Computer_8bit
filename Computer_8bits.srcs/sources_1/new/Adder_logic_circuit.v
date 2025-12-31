`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 10:59:33 PM
// Design Name: 
// Module Name: Adder_logic_circuit
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


module Adder_logic_circuit(
    input [7:0] input_reg,
    input [15:0] DR_in, AC_in,
    input E_in,
    input AND,ADD,LDA,CMA,CME,CIR,CIL,INP,
    output reg E_out,
    output reg [15:0] AC_out
    );
    
    always @(*) begin 
        AC_out = AC_in;
        E_out  = E_in;
        if (AND)
            AC_out = AC_in & DR_in;
        else if (ADD)
            {E_out,AC_out} = AC_in + DR_in;
        else if (LDA)
            AC_out = DR_in;
        else if (CMA)
            AC_out = ~AC_in;
        else if (CME)
            E_out = ~E_in;
        else if (CIR) begin
            AC_out = {E_in, AC_in[15:1]};
            E_out = AC_in[0];
        end
        else if (CIL) begin
            AC_out = {AC_in[14:0], E_in};
            E_out = AC_in[15];
        end
        else if (INP) begin
            AC_out = {8'b0,input_reg};
        end
        else begin
            AC_out = AC_in; // default hold
            E_out = E_in;   // default hold
        end 
    end
   
endmodule
