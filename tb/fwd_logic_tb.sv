`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 10:52:32 PM
// Design Name: 
// Module Name: fwd_logic_tb
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

module fwd_logic_tb;

// Inputs
reg [4:0] EX_MEM_Rd;
reg [4:0] MEM_WB_Rd;
reg [4:0] ID_EX_Rs1;
reg [4:0] ID_EX_Rs2;
reg EX_MEM_RegWrite;
reg MEM_WB_RegWrite;

// Outputs
wire [1:0] fwd_A;
wire [1:0] fwd_B;

// Instantiate the Unit Under Test (UUT)
fwd_logic uut (
    .EX_MEM_Rd(EX_MEM_Rd),
    .MEM_WB_Rd(MEM_WB_Rd),
    .ID_EX_Rs1(ID_EX_Rs1),
    .ID_EX_Rs2(ID_EX_Rs2),
    .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .MEM_WB_RegWrite(MEM_WB_RegWrite),
    .fwd_A(fwd_A),
    .fwd_B(fwd_B)
);

initial begin
    // Initialize Inputs
    EX_MEM_Rd = 0;
    MEM_WB_Rd = 0;
    ID_EX_Rs1 = 0;
    ID_EX_Rs2 = 0;
    EX_MEM_RegWrite = 0;
    MEM_WB_RegWrite = 0;

    // Wait for global reset
    #10;
    
    // Test Case 1: No forwarding (all zeros)
    #10;
    EX_MEM_Rd = 5'd0;
    MEM_WB_Rd = 5'd0;
    ID_EX_Rs1 = 5'd0;
    ID_EX_Rs2 = 5'd0;
    EX_MEM_RegWrite = 1'b0;
    MEM_WB_RegWrite = 1'b0;
    
    #10;
    // Test Case 2: Forward from EX stage to Rs1 and Rs2
    EX_MEM_Rd = 5'd3;
    MEM_WB_Rd = 5'd0;
    ID_EX_Rs1 = 5'd3;
    ID_EX_Rs2 = 5'd3;
    EX_MEM_RegWrite = 1'b1;
    MEM_WB_RegWrite = 1'b0;
    
    #10;
    // Test Case 3: Forward from MEM stage to Rs1
    EX_MEM_Rd = 5'd0;
    MEM_WB_Rd = 5'd4;
    ID_EX_Rs1 = 5'd4;
    ID_EX_Rs2 = 5'd0;
    EX_MEM_RegWrite = 1'b0;
    MEM_WB_RegWrite = 1'b1;
    
    #10;
    // Test Case 4: Forward from both EX and MEM stages
    EX_MEM_Rd = 5'd5;
    MEM_WB_Rd = 5'd6;
    ID_EX_Rs1 = 5'd5;
    ID_EX_Rs2 = 5'd6;
    EX_MEM_RegWrite = 1'b1;
    MEM_WB_RegWrite = 1'b1;
    
    #10;

    // End simulation
    $stop;
end

endmodule