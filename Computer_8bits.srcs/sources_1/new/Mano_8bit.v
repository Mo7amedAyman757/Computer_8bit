`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2025 11:27:28 PM
// Design Name: 
// Module Name: Mano_8bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Mano_8bit(
    input clk,
    input reset,
    input [7:0] in_data,
    output [7:0] out_data
    );
    
    ///////////////////////////////
    //------Sequence counter-----//
    ///////////////////////////////
    wire [15:0] T_seq;
    wire Seq_Clear;
    wire HLT_in;
    Seq_counter #(.N(4)) counter_uut(
        .clk(clk),
        .reset(reset), 
        .CLR(Seq_Clear),
        .S(HLT_in), //HLT
        .T(T_seq)
    );
    
    ///////////////////////////////
    //-----------Memory---------//
    ///////////////////////////////
    wire [15:0] MEM_out;
    wire memb_wr, memb_rd;
    memory #(.DATA_WIDTH(16),.ADDR_WIDTH(12)) mem_uut(
     .clk(clk),
     .wr(memb_wr),
     .rd(memb_rd),
     .D_in(bus_out),
     .ADDR(AR_reg),
     .D_out(MEM_out)
    );
    
    ///////////////////////////////
    //--------Adder_logic--------//
    ///////////////////////////////
    wire [15:0] ALU_out;
    wire E_flag;
    wire E_data;
    wire AND_signal, ADD_signal, LDA_signal, CMA_signal, CME_signal, CIR_signal, CIL_signal, INP_signal;
    Adder_logic_circuit ALU_uut(
         .input_reg(in_reg),
         .DR_in(DR_reg),
         .AC_in(AC_reg),
         .E_in(E_flag),
         .AND(AND_signal),
         .ADD(ADD_signal),
         .LDA(LDA_signal),
         .CMA(CMA_signal),
         .CME(CME_signal),
         .CIR(CIR_signal),
         .CIL(CIL_signal),
         .INP(INP_signal),
         .E_out(E_data),
         .AC_out(ALU_out)
        );
        
      
    ///////////////////////////////
    //-------Control Unit-------//
    /////////////////////////////// 
    Control_unit CTRL_unit(
    .D(OP_code),
    .I(I_signal),
    .IR_bit(IR_reg[11:0]),
    .T_seqe(T_seq),
    .R_in(R_signal),
    .E_in(E_flag),
    .FGI(FGI_signal),
    .FGO(FGO_signal),

    .AC(AC_reg), 
    .DR(DR_reg),
    
    // Bus
    .x(bus_sel),
    .Bus_en(Bus_enable),
    .opcode_en(OP_en),
    .I_en(I_enable),
    
    // Registers
     .AR_LD(AR_LD),
     .AR_INC(AR_INC),
     .AR_CLR(AR_CLR),
     .PC_LD(PC_LD),
     .PC_INC(PC_INC),
     .PC_CLR(PC_CLR),
     .DR_LD(DR_LD),
     .DR_INC(DR_INC),
     .AC_LD(AC_LD),
     .AC_INC(AC_INC),
     .AC_CLR(AC_CLR),
     .IR_LD(IR_LD),
     .TR_LD(TR_LD),
    
    // ALU
     .AND_op(AND_signal), 
     .ADD_op(ADD_signal),
     .LDA_op(LDA_signal),
     .CMA_op(CMA_signal),
     .CME_op(CME_signal),
     .CIR_op(CIR_signal), 
     .CIL_op(CIL_signal),
     .INP_op(INP_signal),
    
     .E_CLR(E_clear),
    
    //memory
     .mem_wr(memb_wr),
     .mem_rd(memb_rd),
    
     // I/O
    .INPR_LD(LD_INPR), 
     .OUTR_LD(LD_OUTR),
    
    // Sequence Counter
     .seq_CLR(Seq_Clear),
    
    // HLT
     .HLT(HLT_Signal),
    
     .FGI_CLR(CLR_FGI), 
     .FGO_CLR(CLR_FGO),
    
     .IEN_J(IEN_JJ), 
     .IEN_K(IEN_KK)
    
    );    
    
    ///////////////////////////////
    //-------Register File-------//
    ///////////////////////////////
    wire [15:0] AC_reg,DR_reg,TR_reg,IR_reg;
    wire [11:0] PC_reg, AR_reg;
    
    // Register control
    wire AR_LD, AR_INC, AR_CLR;
    wire PC_LD, PC_INC, PC_CLR;
    wire DR_LD, DR_INC;
    wire AC_LD, AC_INC, AC_CLR;
    wire IR_LD, TR_LD;
    
    Reg_File #(.N(16),.M(12)) Register_uut(
     .clk(clk),
     .reset(reset),
     .Bus_in(bus_out),
     .ALU_in(ALU_out),
     .AR_LD(AR_LD),
     .AR_INC(AR_INC),
     .AR_CLR(AR_CLR),
     .PC_LD(PC_LD),
     .PC_INC(PC_INC),
     .PC_CLR(PC_CLR),
     .DR_LD(DR_LD),
     .DR_INC(DR_INC),
     .AC_LD(AC_LD),
     .AC_INC(AC_INC),
     .AC_CLR(AC_CLR),
     .IR_LD(IR_LD),
     .TR_LD(TR_LD),
     .AC(AC_reg),
     .DR(DR_reg),
     .TR(TR_reg),
     .IR(IR_reg),
     .PC(PC_reg),
     .AR(AR_reg)
    );
    
     ///////////////////////////////
    //--------Control Bus---------//
    ///////////////////////////////
    wire [15:0] bus_out;
    wire [7:0] bus_sel;
    wire Bus_enable;
    Control_bus#(.mux(16),.encod(8)) Bus_uut(
         .xc(bus_sel),
         .In0(16'b0), 
         .In1({4'b0,AR_reg}), 
         .In2({4'b0,PC_reg}), 
         .In3(DR_reg), 
         .In4(AC_reg), 
         .In5(IR_reg), 
         .In6(TR_reg), 
         .In7(MEM_out),
         .EN(Bus_enable),
         .y(bus_out)
    );
    
    ///////////////////////////////
    //---------Interrupt---------//
    ///////////////////////////////
    wire R_signal;
    wire IEN_JJ, IEN_KK;
    Interrupt INTR_uut(
     .clk(clk), 
     .reset(reset),
     .J_in(IEN_JJ),
     .K_in(IEN_KK),
     .T0(T_seq[0]),
     .T1(T_seq[1]),
     .T2(T_seq[2]),
     .FGI(FGI_signal),
     .FGO(FGO_signal),
     .R(R_signal)
    );
    
    ///////////////////////////////
    //-----------I_bit-----------//
    ///////////////////////////////
    wire I_signal;
    wire I_enable;
        D_ff I_uut(
         .clk(clk),
         .reset(reset),
         .EN(I_enable),
         .D(IR_reg[15]),
         .Q(I_signal)
        );
        
    ///////////////////////////////
    //---------E_flag---------//
    ///////////////////////////////
    wire E_clear;
        D_ff E_uut(
         .clk(clk),
         .reset(reset||E_clear),
         .EN(1'b1),
         .D(E_data),
         .Q(E_flag)
        );
  
  ///////////////////////////////
 //-------Input register------//
 ///////////////////////////////
 wire [7:0] in_reg;
 wire LD_INPR;
    Generic_Reg#(.N(8)) input_reg(
         .clk(clk),
         .reset(reset),
         .LD(LD_INPR),
         .INC(1'b0),
         .CLR(1'b0),
         .D(in_data),
         .Q(in_reg)
        );  
        
  //////////////////////////////
 //------output register-----//
 //////////////////////////////
 wire LD_OUTR;
 Generic_Reg#(.N(8)) output_reg(
         .clk(clk),
         .reset(reset),
         .LD(LD_OUTR),
         .INC(1'b0),
         .CLR(1'b0),
         .D(AC_reg[7:0]),
         .Q(out_data)
        );  
        
  //////////////////////////////
 //-----operation decoder-----//
 ////////////////////////////// 
 wire [7:0] OP_code;
 wire OP_en;
 Generic_decoder #(.N(3)) Decoder_Inst(
        .x(IR_reg[14:12]),
        .EN(OP_en),
        .y(OP_code)
    );  
    
    
 ///////////////////////////////
 //---------FGI_flag---------//
 ///////////////////////////////
 wire FGI_signal;
 wire CLR_FGI;
        D_ff FGI_uut(
         .clk(clk),
         .reset(reset || CLR_FGI),
         .EN(1'b1),
         .D(LD_INPR),
         .Q(FGI_signal)
        );
        
  ///////////////////////////////
 //---------FGO_flag---------//
 ///////////////////////////////
 wire FGO_signal;
 wire CLR_FGO = LD_OUTR;
        D_ff FGO_uut(
         .clk(clk),
         .reset(reset || CLR_FGO),
         .EN(1'b1),
         .D(1'b1),
         .Q(FGO_signal)
        );
 
  ///////////////////////////////
 //---------HLT_flag---------//
 ///////////////////////////////  
     wire HLT_Signal;     
     JK_ff HLT_uut(
         .clk(clk),
         .reset(reset),
         .J(~HLT_Signal),
         .K(HLT_Signal),
         .Q(HLT_in)
        );
  
endmodule
