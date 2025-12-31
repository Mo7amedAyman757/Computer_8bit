`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2025 09:44:57 AM
// Design Name: 
// Module Name: Adder_logic_circuit_tb
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


module Adder_logic_circuit_tb(

    );
    
    //1- Declare local reg and wire
    reg [15:0] AC_in;
    reg [15:0] DR_in;
    reg [7:0] INPR;
    reg E_in;
    reg AND_sig, ADD_sig, LDA_sig, CMA_sig, CME_sig, CIR_sig, CIL_sig,INPR_sig;
    wire [15:0] AC_out;
    wire E_out;
    
    //2- Instantiate module under test
    Adder_logic_circuit uut (
        .AC_in(AC_in),
        .DR_in(DR_in),
        .input_reg(INPR),
        .E_in(E_in),
        .AND(AND_sig),
        .ADD(ADD_sig),
        .LDA(LDA_sig),
        .CMA(CMA_sig),
        .CME(CME_sig),
        .CIR(CIR_sig),
        .CIL(CIL_sig),
        .INP(INPR_sig),
        .AC_out(AC_out),
        .E_out(E_out)
    );
    
     //3- General stimuli using always and initial
    initial begin
        // Initialize inputs
        AC_in = 16'h0000;
        DR_in  = 16'h0000;
        INPR   = 8'h00;
        E_in = 0;
        AND_sig = 0; ADD_sig = 0; LDA_sig = 0; CMA_sig = 0; CME_sig = 0; CIR_sig = 0; CIL_sig = 0; INPR_sig = 0;

        // Wait a little
        #10;

        // Test AND
        AC_in = 16'hF0F0;
        DR_in  = 16'h0FF0;
        AND_sig = 1; #10;
        AND_sig = 0;

        // Test ADD
        AC_in = 16'h1234;
        DR_in  = 16'h1111;
        ADD_sig = 1; #10;
        ADD_sig = 0;

        // Test LDA
        DR_in  = 16'hABCD;
        LDA_sig = 1; #10;
        LDA_sig = 0;

        // Test CMA
        AC_in = 16'h0F0F;
        CMA_sig = 1; #10;
        CMA_sig = 0;
        
        // Test CME
        CME_sig = 1; #10;
        CME_sig = 0;

        // Test CIR
        AC_in = 16'h8001;
        CIR_sig = 1; #10;
        CIR_sig = 0;

        // Test CIL
        AC_in = 16'h4002;
        CIL_sig = 1; #10;
        CIL_sig = 0;
        
        // Test INPR
        INPR = 8'h02;
        INPR_sig = 1; #10;
        INPR_sig = 0;

        $stop;
    end
    
endmodule
