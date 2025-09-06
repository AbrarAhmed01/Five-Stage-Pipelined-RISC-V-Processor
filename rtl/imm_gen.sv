`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2024 10:16:34 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen
(
    input [31:0] imm,
    input [2:0]ImmSel,
    output logic [31:0]sign_extend_value
);
    logic [11:0]immediate;
    
        
    always@(*)
    begin
        if(ImmSel == 3'b000)                  //S-Type
        begin
            immediate = {imm[31:25], imm[11:7]};
            sign_extend_value = {{20{immediate[11]}}, immediate[11:0]};
        end
        
        else if(ImmSel == 3'b001)            //J-Type
        begin
            sign_extend_value = {{12{imm[31]}}, imm[19:12], imm[20], imm[30:21], 1'b0};
        end
        
        else if(ImmSel == 3'b010)             //B-Type
        begin
            sign_extend_value = {{20{imm[31]}}, imm[31:25], imm[11:7]};
        end
        
        else if(ImmSel == 3'b011)    //U-Type
        begin
            sign_extend_value = {imm[31:12], 12'b0};
        end
        
        else                        //I-Type
        begin
            immediate = imm[31:20];
            sign_extend_value = {{20{immediate[11]}}, immediate[11:0]};
        end
    end
endmodule
