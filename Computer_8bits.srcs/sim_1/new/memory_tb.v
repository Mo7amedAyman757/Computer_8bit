`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2025 07:03:28 PM
// Design Name: 
// Module Name: memory_tb
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


module memory_tb(

    );
    
    //1- Declare local wire and reg
    localparam ADDR_WIDTH = 12, DATA_WIDTH = 16; 
    reg clk, RD, WR;
    reg [DATA_WIDTH-1 : 0] D_in; 
    reg [ADDR_WIDTH-1 : 0] ADDR;
    wire [DATA_WIDTH-1 : 0] D_out;
    
    //2- Instantiate the module under test
    memory #(.ADDR_WIDTH(ADDR_WIDTH),.DATA_WIDTH(DATA_WIDTH)) uut(
        .clk(clk),
        .rd(RD),
        .wr(WR),
        .D_in(D_in),
        .ADDR(ADDR),
        .D_out(D_out)
    );
    
    //3- General stimuli using always and initials
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
        //Initialization
          clk = 0;
          RD = 0;
          WR = 0;
          ADDR = -1;
          D_in = 0;
          
         // Write data to first few memory locations
         repeat (4) 
         begin
          WR = 1;
          RD = 0;
          D_in = $random; // random 16-bit value
          @(posedge clk);        
          ADDR = ADDR + 1;
         end
         
         // Disable write
         @(posedge clk);
         WR = 0;
         
         // Read back data
        ADDR = -1;
        repeat (4) 
        begin
          @(posedge clk);
          RD = 1;
          ADDR = ADDR + 1;
        end
        
      @(negedge clk) $stop;   
     end
endmodule
