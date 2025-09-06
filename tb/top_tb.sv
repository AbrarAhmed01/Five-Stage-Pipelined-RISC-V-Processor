`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 10:52:32 PM
// Design Name: 
// Module Name: top_tb
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

module top_tb;

    logic clk, reset;     
    logic [31:0]out;

    top dut(.*);
    
    initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;
    end
    
    initial begin
    reset = 1'b1;
    
    #5;
    reset = 1'b0;
    
	#1000000;
    $finish();

end
endmodule
