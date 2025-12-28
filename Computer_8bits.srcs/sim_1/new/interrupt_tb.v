`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2025 10:58:42 PM
// Design Name: 
// Module Name: interrupt_tb
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


module interrupt_tb(

    );
    
    //1- Declare local wire and reg
    reg clk, reset, T0, T1, T2, IEN_J, IEN_K, FGI, FGO;
    wire R;
    
    //2- Instantiate the module under test
    Interrupt uut(
        .clk(clk),
        .reset(reset),
        .T0(T0),
        .T1(T1),
        .T2(T2),
        .J_in(IEN_J),
        .K_in(IEN_K),
        .FGI(FGI),
        .FGO(FGO),
        .R(R)
    );
    
    //3- General stimuli using always and initial
    localparam CLK_PERIOD  = 20;
    always
    begin
        clk = 1'b0;
        #(CLK_PERIOD  / 2);
        clk = 1'b1;
        #(CLK_PERIOD  / 2);
    end
    
    // -------------------------------------------------
    // 4. Mano timing task (T0 → T1 → T2 → idle)
    // -------------------------------------------------
    task mano_cycle;
    begin
        T0 = 1; T1 = 0; T2 = 0; #CLK_PERIOD;
        T0 = 0; T1 = 1; T2 = 0; #CLK_PERIOD;
        T0 = 0; T1 = 0; T2 = 1; #CLK_PERIOD;
        T0 = 0; T1 = 0; T2 = 0; #CLK_PERIOD;
    end
    endtask

    // -------------------------------------------------
    // 5. Test sequence
    // -------------------------------------------------
    initial begin
        // -------------------------
        // Initial values
        // -------------------------
        T0 = 0; T1 = 0; T2 = 0;
        IEN_J = 0; IEN_K = 0;
        FGI = 0; FGO = 0;
        reset = 1;

        // Apply reset
        #40;
        reset = 0;

        // -------------------------
        // TEST 1: Enable interrupts
        // -------------------------
        $display("TEST 1: Enable Interrupts");
        IEN_J = 1;
        #CLK_PERIOD;
        IEN_J = 0;

        // -------------------------
        // TEST 2: Interrupt request by FGI
        // -------------------------
        $display("TEST 2: FGI triggers interrupt");
        FGI = 1;
        #CLK_PERIOD;

        // R should become 1 here
        mano_cycle;   // T2 clears interrupt

        FGI = 0;

        // -------------------------
        // TEST 3: Interrupt request by FGO
        // -------------------------
        $display("TEST 3: FGO triggers interrupt");
        FGO = 1;
        #CLK_PERIOD;

        // R should become 1 here
        mano_cycle;

        FGO = 0;

        // -------------------------
        // TEST 4: Interrupt disabled (IEN = 0)
        // -------------------------
        $display("TEST 4: Interrupt disabled");
        IEN_K = 1;
        #CLK_PERIOD;
        IEN_K = 0;

        FGI = 1;
        #CLK_PERIOD;  // R must stay 0

        mano_cycle;
        FGI = 0;

        // -------------------------
        // End simulation
        // -------------------------
        #100;
        $display("Simulation completed successfully.");
        $stop;
    end

    
endmodule
