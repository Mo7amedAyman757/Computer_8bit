`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2025 04:32:51 PM
// Design Name: 
// Module Name: Control_unit
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


module Control_unit(
    input [7:0] D,
    input I,
    input [11:0] IR_bit,
    input [15:0] T_seqe,
    input R_in,
    input E_in,
    input FGI,
    input FGO,

    input [15:0] AC, DR,
    
    // Bus
    output reg [7:0] x,
    output reg Bus_en,
    output reg opcode_en,I_en,
    
    // Registers
    output reg AR_LD, AR_INC, AR_CLR,
    output reg PC_LD, PC_INC, PC_CLR,
    output reg DR_LD, DR_INC,
    output reg AC_LD, AC_INC, AC_CLR,
    output reg IR_LD,
    output reg TR_LD,
    
    // ALU
    output reg AND_op, ADD_op, LDA_op,
    output reg CMA_op, CME_op,
    output reg CIR_op, CIL_op,
    output reg INP_op,
    
    output reg E_CLR,
    
    //memory
    output reg mem_wr,mem_rd,
    
     // I/O
    output reg INPR_LD, OUTR_LD,
    
    // Sequence Counter
    output reg seq_CLR,
    
    // HLT
    output reg HLT,
    
    output reg FGI_CLR, FGO_CLR,
    
    output reg IEN_J, IEN_K
    
    );
    
    always @(*) begin
        // ---------------- DEFAULTS ----------------
        AR_LD=0; AR_INC=0; AR_CLR=0;
        PC_LD=0; PC_INC=0; PC_CLR=0;
        DR_LD=0; DR_INC=0;
        AC_LD=0; AC_INC=0; AC_CLR=0;
        IR_LD=0; TR_LD=0;
    
        AND_op=0; ADD_op=0; LDA_op=0;
        CMA_op=0; CME_op=0;
        CIR_op=0; CIL_op=0;
        INP_op=0;
        E_CLR = 0;
        
        opcode_en = 0; I_en = 0;
        
        Bus_en=0; x=3'b000;
        mem_rd=0; mem_wr=0;
        INPR_LD=0; OUTR_LD=0;
        seq_CLR=0;
        HLT = 0;
        FGI_CLR = 0; FGO_CLR = 0;
        IEN_J = 1'b0; IEN_K = 1'b1;

        // ================= FETCH =================    
        if(~R_in & T_seqe[0]) begin
            x = 3'b010;
            Bus_en = 1'b1;
            AR_LD = 1'b1;
        end
        
        else if(~R_in & T_seqe[1]) begin
            mem_rd = 1'b1;
            x = 3'b111;
            Bus_en = 1'b1;
            IR_LD = 1'b1;
            PC_INC = 1'b1;
        end
        
        else if(~R_in & T_seqe[2]) begin
            opcode_en = 1'b1;
            I_en = 1'b1;
            x = 3'b101;
            Bus_en = 1'b1;
            AR_LD = 1'b1;
        end
        
        // ================= Indirect =================   
        else if (~D[7] & I & T_seqe[3]) begin
            mem_rd = 1'b1;
            x = 3'b111;
            Bus_en = 1'b1;
            AR_LD = 1'b1;
        end
        
        // =================MEM REF=================  
        // AND
        else if(D[0] & T_seqe[4]) begin
            mem_rd = 1'b1;
            x = 3'b111;   
            Bus_en = 1'b1;
            DR_LD = 1; 
        end 
        else if(D[0] & T_seqe[5]) begin 
            AND_op = 1'b1;  
            AC_LD = 1'b1;
            seq_CLR = 1; 
        end 
        
        // ADD
        else if(D[1] & T_seqe[4]) begin
            mem_rd = 1'b1;
            x = 3'b111;   
            Bus_en = 1'b1;
            DR_LD = 1; 
        end 
        else if(D[1] & T_seqe[5]) begin 
            ADD_op = 1'b1;  
            AC_LD = 1'b1;
            seq_CLR = 1; 
        end 
        
        // LDA
        else if(D[2] & T_seqe[4]) begin
            mem_rd = 1'b1;
            x = 3'b111;   
            Bus_en = 1'b1;
            DR_LD = 1; 
        end 
        else if(D[2] & T_seqe[5]) begin 
            LDA_op = 1'b1;  
            AC_LD = 1'b1;
            seq_CLR = 1; 
        end 
        
        // STA
        else if(D[3] & T_seqe[4]) begin
            mem_wr = 1'b1;
            x = 3'b100;   
            Bus_en = 1'b1;
            seq_CLR = 1; 
        end 
        
        // BUN
        else if(D[4] & T_seqe[4]) begin
            x = 3'b001;   
            Bus_en = 1'b1;
            PC_LD = 1'b1; 
            seq_CLR = 1'b1;
        end 
        
        // BSA 
        else if(D[5] & T_seqe[4]) begin
            mem_wr = 1'b1;
            x = 3'b010;   
            Bus_en = 1'b1;
            AR_INC = 1'b1; 
        end 
        else if(D[5] & T_seqe[5]) begin 
            x = 3'b001;   
            Bus_en = 1'b1;
            PC_LD = 1;
            seq_CLR = 1;
        end 
        
        // ISZ 
        else if(D[6] & T_seqe[4]) begin
            mem_rd = 1'b1;
            x = 3'b111;   
            Bus_en = 1'b1;
            DR_LD = 1'b1; 
        end 
        else if(D[6] & T_seqe[5]) begin 
            DR_INC = 1'b1; 
        end 
        else if(D[6] & T_seqe[6]) begin 
            mem_wr = 1'b1;
            x = 3'b011;   
            Bus_en = 1'b1;
            if(DR == 16'd0)  
                PC_INC = 1'b1;
            seq_CLR = 1;
        end 
        
        // =================REG REF=================
        else if (D[7] & ~I & T_seqe[3]) begin
            case (IR_bit[11:0]) 
                12'h800: AC_CLR = 1'b1;            // CLA
                12'h400: E_CLR  = 1'b1;            // CLE
                12'h200: CMA_op = 1'b1;            // CMA
                12'h100: CME_op = 1'b1;            // CME
                12'h080: CIR_op = 1'b1;            // CIR
                12'h040: CIL_op = 1'b1;            // CIL
                12'h020: AC_INC = 1'b1;            // INC
        
                12'h010: if (!AC[15]) PC_INC = 1'b1; // SPA
                12'h008: if ( AC[15]) PC_INC = 1'b1; // SNA
                12'h004: if ( AC == 16'd0) PC_INC = 1'b1; // SZA
                12'h002: if (!E_in) PC_INC = 1'b1;  // SZE
        
                12'h001: HLT = 1'b1;               // HLT
                
                default: ;
            endcase
            
            seq_CLR = 1'b1;
        end
        
        // =================I/O REF=================
        else if (D[7] & I & T_seqe[3]) begin
            
            // INP
            if(IR_bit[11] & FGI) begin
                INPR_LD = 1'b1;
                AC_LD = 1'b1;
                FGI_CLR = 1'b1;
            end
            
            // OUT
            if(IR_bit[10] & FGO) begin
                OUTR_LD = 1;
                FGO_CLR = 1'b1;
            end
            
            // SKI
            if(IR_bit[9]) begin
                if(FGI == 1'b1) 
                    PC_INC = 1'b1;
            end
            
            // SKO
            if(IR_bit[8]) begin
                if(FGO == 1'b1) 
                    PC_INC = 1'b1;
            end
            
            // ION
            if(IR_bit[7]) begin
                IEN_J = 1'b1;
                IEN_K = 1'b0;
            end
            
            // IOF
            if(IR_bit[6]) begin
                IEN_J = 1'b0;
                IEN_K = 1'b1;
            end
            
            seq_CLR = 1'b1;
        end
        
        // ================= INTERRUPT CYCLE =================
        if (R_in && T_seqe[0]) begin
            AR_CLR = 1'b0;
            x = 3'b010;
            Bus_en = 1'b1;
            TR_LD = 1'b1;
        end
        
        else if (R_in && T_seqe[1]) begin
            mem_wr = 1'b1;
            x = 3'b101;
            Bus_en = 1'b1;
            PC_CLR = 1'b1;
        end
        
        else if (R_in && T_seqe[2]) begin
            PC_INC = 1'b1;
            seq_CLR = 1'b1;
        end
    end

endmodule
