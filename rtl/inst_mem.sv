`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 10:25:03 AM
// Design Name: 
// Module Name: instruction_memory
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


module inst_mem
(
    input [29:0]addr,
    output logic [31:0]dataR
);
    
    logic [31:0]i_mem[0:25500];
    
    initial begin
        $readmemh("/home/cc/CAO/lab 25/sim/seed/test.hex", i_mem); // For Hex File
    end
    
   assign dataR = i_mem[addr];      //0x80000000 - addr

endmodule
