`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:20:35 PM
// Design Name: 
// Module Name: Reg_File
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


module Reg_File
    #(parameter N = 16, M = 12)(
    input clk,
    input reset,
    input [N-1:0] Bus_in,
    input [N-1:0] ALU_in,
    input AR_LD, AR_INC, AR_CLR,
    input PC_LD, PC_INC, PC_CLR,
    input DR_LD, DR_INC,
    input AC_LD, AC_INC, AC_CLR,
    input IR_LD,
    input TR_LD,
    output [N-1:0] AC,DR,TR,IR,
    output [M-1:0] PC,AR
    );
     //------------------------------------------//
    //-------------Address Register-------------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(M)) AR_reg(
     .clk(clk),
     .reset(reset),
     .LD(AR_LD),
     .INC(AR_INC),
     .CLR(AR_CLR),
     .D(Bus_in),
     .Q(AR)
    );
     //------------------------------------------//
    //--------------Program Counter-------------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(M)) PC_reg(
     .clk(clk),
     .reset(reset),
     .LD(PC_LD),
     .INC(PC_INC),
     .CLR(PC_CLR),
     .D(Bus_in),
     .Q(PC)
    );
    
     //------------------------------------------//
    //---------------Data Register--------------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(N)) DR_reg(
     .clk(clk),
     .reset(reset),
     .LD(DR_LD),
     .INC(DR_INC),
     .CLR(1'b0),
     .D(Bus_in),
     .Q(DR)
    );
    
     //------------------------------------------//
    //---------------Data Register--------------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(N)) AC_reg(
     .clk(clk),
     .reset(reset),
     .LD(AC_LD),
     .INC(AC_INC),
     .CLR(AC_CLR),
     .D(ALU_in),
     .Q(AC)
    );
    
     //------------------------------------------//
    //------------Instruction Register----------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(N)) IR_reg(
     .clk(clk),
     .reset(reset),
     .LD(IR_LD),
     .INC(1'b0),
     .CLR(1'b0),
     .D(Bus_in),
     .Q(IR)
    );
    
     //------------------------------------------//
    //-------------Temporary Register-----------//
    //-----------------------------------------//
    Generic_Reg
    #(.N(N)) TR_reg(
     .clk(clk),
     .reset(reset),
     .LD(TR_LD),
     .INC(1'b0),
     .CLR(1'b0),
     .D(Bus_in),
     .Q(TR)
    );
endmodule
