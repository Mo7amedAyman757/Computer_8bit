`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:37:15 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb(

    );
    
    //1- Declare local reg and wire
    reg  clk,
         AR_LD,AR_INC,AR_CLR,
         DR_LD,DR_INC,
         IR_LD,
         TR_LD,
         AC_LD,AC_INC,AC_CLR,
         PC_INC,PC_LD,PC_CLR;
    reg [15:0] Bus;
    reg [15:0] ALU;
    wire [15:0] AC,DR,TR,IR;
    wire [11:0] PC,AR;
    
   //2- Instantiate module under test
    Reg_File #(.N(16), .M(12)) uut (
        .clk(clk),
        .AR_LD(AR_LD), .AR_INC(AR_INC), .AR_CLR(AR_CLR),
        .DR_LD(DR_LD),.DR_INC(DR_INC),
        .IR_LD(IR_LD),
        .TR_LD(TR_LD),
        .AC_LD(AC_LD), .AC_INC(AC_INC), .AC_CLR(AC_CLR),
        .PC_INC(PC_INC), .PC_LD(PC_LD), .PC_CLR(PC_CLR),
        .Bus_in(Bus),
        .ALU_in(ALU),
        .AC(AC), .DR(DR), .TR(TR), .IR(IR),
        .PC(PC), .AR(AR)
    );
    
    //3- General stimuli using always and initial
     localparam T = 20;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    
    initial
    begin
        // Initialize signals
        Bus = 16'h0000;
        ALU = 16'h0100;
        AR_LD=0; AR_INC=0; AR_CLR=0;
        DR_LD=0; DR_INC=0;
        IR_LD=0; TR_LD=0;
        AC_LD=0; AC_INC=0; AC_CLR=0;
        PC_INC=0; PC_LD=0; PC_CLR=0;
        
        #25;
        
        // Load AR with 12'hABC
        Bus = 16'h0ABC;
        AR_LD = 1; #20; AR_LD = 0;
        
        // Increment AR
        AR_INC = 1; #20; AR_INC = 0;
        
        // Clear AR
        AR_CLR = 1; #20; AR_CLR = 0;
        
        // Load DR
        Bus = 16'h1234;
        DR_LD = 1; #20; DR_LD = 0;
        
        // Increment DR
        DR_INC = 1; #20; DR_INC = 0;
        
        // Load AC
        Bus = 16'hABCD;
        AC_LD = 1; #20; AC_LD = 0;
        
        // Increment ACC
        AC_INC = 1; #20; AC_INC = 0;
        
        // Clear ACC
        AC_CLR = 1; #20; AC_CLR = 0;
        
        //Load PC
        Bus = 16'h0CFF; PC_LD = 1; #20; PC_LD = 0;
        
        //Clear PC
        Bus = 16'h0CFF; PC_CLR = 1; #20; PC_CLR = 0;
        
        //Increment PC
        Bus = 16'h0CFF; PC_INC = 1; #20; PC_INC = 0;
        
        //Load IR
        Bus = 16'h0C0F; IR_LD = 1; #20; IR_LD = 0;
        
        //Load TR
        Bus = 16'h0C0F; TR_LD = 1; #20; TR_LD = 0;
        #50;
        $stop;
    end
    
endmodule
