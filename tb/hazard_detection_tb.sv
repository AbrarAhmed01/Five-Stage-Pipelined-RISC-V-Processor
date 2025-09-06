`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 10:52:32 PM
// Design Name: 
// Module Name: hazard_detection_tb
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

module hazard_detection_tb;

// Inputs
reg [1:0] ID_EX_MemRead;
reg [4:0] ID_EX_Rd;
reg [4:0] IF_ID_Rs1;
reg [4:0] IF_ID_Rs2;

// Outputs
wire IF_ID_Write;
wire PCWrite;
wire ControlEn;

// Instantiate the Unit Under Test (UUT)
hazard_detection uut (
    .ID_EX_MemRead(ID_EX_MemRead),
    .ID_EX_Rd(ID_EX_Rd),
    .IF_ID_Rs1(IF_ID_Rs1),
    .IF_ID_Rs2(IF_ID_Rs2),
    .IF_ID_Write(IF_ID_Write),
    .PCWrite(PCWrite),
    .ControlEn(ControlEn)
);

initial begin
    // Initialize Inputs
    ID_EX_MemRead = 2'b00;
    ID_EX_Rd = 5'b0;
    IF_ID_Rs1 = 5'b0;
    IF_ID_Rs2 = 5'b0;

    // Wait for global reset
    #10;

    // Test Case 1: No hazard
    ID_EX_MemRead = 2'b01; // MemRead not active
    ID_EX_Rd = 5'd0;
    IF_ID_Rs1 = 5'd1;
    IF_ID_Rs2 = 5'd2;
    #10;

    // Test Case 2: Hazard detected (ID_EX_Rd matches IF_ID_Rs1)
    ID_EX_MemRead = 2'b00; // MemRead active
    ID_EX_Rd = 5'd5;       // Rd matches Rs1
    IF_ID_Rs1 = 5'd5;
    IF_ID_Rs2 = 5'd10;
    #10;

    // Test Case 3: Hazard detected (ID_EX_Rd matches IF_ID_Rs2)
    ID_EX_MemRead = 2'b00; // MemRead active
    ID_EX_Rd = 5'd8;       // Rd matches Rs2
    IF_ID_Rs1 = 5'd3;
    IF_ID_Rs2 = 5'd8;
    #10;

    // Test Case 4: No hazard (MemRead inactive)
    ID_EX_MemRead = 2'b11; // MemRead inactive
    ID_EX_Rd = 5'd6;
    IF_ID_Rs1 = 5'd6;
    IF_ID_Rs2 = 5'd7;
    #10;

    // Test Case 5: No hazard (Rd and Rs1, Rs2 do not match)
    ID_EX_MemRead = 2'b00;
    ID_EX_Rd = 5'd9;
    IF_ID_Rs1 = 5'd3;
    IF_ID_Rs2 = 5'd4;
    #10;

    // End simulation
    $stop;
end

endmodule