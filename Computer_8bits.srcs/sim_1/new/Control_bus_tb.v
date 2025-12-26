`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:16:32 PM
// Design Name: 
// Module Name: Control_bus_tb
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


module Control_bus_tb(

    );
    
     //1- Delcare local reg and wire
    reg [7:0] x;
    reg [15:0] In0, In1, In2, In3, In4, In5, In6, In7;
    reg EN;
    wire [15 : 0] y;
    
    //2- Instantiate the module under test
    Control_bus #(.mux(16), .encod(8)) uut(
        .x(x),
        .In0(In0),
        .In1(In1),
        .In2(In2),
        .In3(In3),
        .In4(In4),
        .In5(In5),
        .In6(In6),
        .In7(In7),
        .EN(EN),
        .y(y)
    );
    
     // Test sequence
    initial
    begin
        // Initialize inputs
        EN  = 1'b1;
        x   = 8'b00000000;

        // Assign distinct values to each input
        In0 = 16'h0001;
        In1 = 16'h0010;
        In2 = 16'h0100;
        In3 = 16'h1000;
        In4 = 16'hAAAA;
        In5 = 16'h5555;
        In6 = 16'h0F0F;
        In7 = 16'hF0F0;
        
        // Step through each encoder input (one-hot)
        x = 8'b00000001; #10;
        x = 8'b00000010; #10;
        x = 8'b00000100; #10;
        x = 8'b00001000; #10;
        x = 8'b00010000; #10;
        x = 8'b00100000; #10;
        x = 8'b01000000; #10;
        x = 8'b10000000; #10;

        // Disable encoder
        EN = 1'b0; 
        x  = 8'b00000010; #10;
        
     end  
endmodule
