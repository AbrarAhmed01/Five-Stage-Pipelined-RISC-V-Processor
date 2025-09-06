`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 09/24/2024 09:57:08 AM
// Design Name: 
// Module Name: hazard_detection
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


module hazard_detection(
    input program_jump,
    input [1:0]ID_EX_MemRead,
    input [4:0] ID_EX_Rd,
    input [4:0] IF_ID_Rs1,
    input [4:0] IF_ID_Rs2,
    output logic IF_ID_Write,
    output logic PCWrite,
    output logic ControlEn,
    output logic flush
    );
    
    
    always@(*)
    begin
        if(program_jump == 1'b1)
        begin
            IF_ID_Write = 1'b1;
            ControlEn = 1'b0;
            PCWrite = 1'b1;
            flush = 1'b1;
        end
        
        else if(ID_EX_MemRead == 2'b00 && (ID_EX_Rd != 0) && (IF_ID_Rs1 != 0) && (IF_ID_Rs2 != 0) && ((ID_EX_Rd == IF_ID_Rs1)||(ID_EX_Rd == IF_ID_Rs2)))
        begin
            IF_ID_Write = 1'b0;
            ControlEn = 1'b0;
            PCWrite = 1'b0;
            flush = 1'b0;
        end
        
        else
        begin
            IF_ID_Write = 1'b1;
            ControlEn = 1'b1;
            PCWrite = 1'b1;
            flush = 1'b0;
        end
    end
    
    
endmodule
