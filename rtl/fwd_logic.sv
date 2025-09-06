`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 09/24/2024 09:56:43 AM
// Design Name: 
// Module Name: fwd_logic
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


module fwd_logic(
    input [4:0] EX_MEM_Rd,
    input [4:0] MEM_WB_Rd,
    input [4:0] ID_EX_Rs1,
    input [4:0] ID_EX_Rs2,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    output logic [1:0] fwd_A,
    output logic [1:0] fwd_B
    );
    
    always @(*)
    begin
        if((EX_MEM_Rd == ID_EX_Rs1) && EX_MEM_RegWrite == 1'b1 && EX_MEM_Rd != 0)
        begin
            fwd_A = 2'b10;
        end
        
        else if((MEM_WB_Rd == ID_EX_Rs1) && MEM_WB_RegWrite == 1'b1 && MEM_WB_Rd != 0)
        begin
            fwd_A = 2'b01;
        end
        
        else
        begin
            fwd_A = 2'b00;
        end
        
        if((EX_MEM_Rd == ID_EX_Rs2) && EX_MEM_RegWrite == 1'b1 && EX_MEM_Rd != 0)
        begin
            fwd_B = 2'b10;
        end
        
        else if((MEM_WB_Rd == ID_EX_Rs2) && MEM_WB_RegWrite == 1'b1 && MEM_WB_Rd != 0)
        begin
            fwd_B = 2'b01;
        end
        
        else
        begin
            fwd_B = 2'b00;
        end
    end    
    
endmodule