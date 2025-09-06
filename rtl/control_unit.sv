`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 09/17/2024 12:51:09 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [8:0]Inst,
    output logic PCSel,
    output logic [2:0]ImmSel,
    output logic BSel,
    output logic [3:0]ALUSel,
    output logic MemRW,
    output logic RegWEn,
    output logic [1:0]WBSel
    );
    
    always@(*)
    begin
        if(Inst[4:0] == 12)
        begin
            ALUSel = {Inst[7:5], Inst[8]};
        end
        
        else if(Inst[4:0] == 4 && Inst[7:5] == 3'b101)
        begin
            ALUSel = {Inst[7:5], Inst[8]};
        end
        
        else if(Inst[4:0] == 4)
        begin
            ALUSel = {Inst[7:5], 1'b0};
        end
        
        else if(Inst[4:0] == 5'b01101)	//lui instruction
        begin
            ALUSel = {1'b0, Inst[4:2]};
        end
        
        else
        begin
            ALUSel = 4'b0000;
        end
        
    end
    
    always@(*)
    begin
        if(Inst[4:0] == 12)
        begin
            BSel = 1'b0;
        end
        
        else
        begin
            BSel = 1'b1;
        end
    end
    
    always@(*)
    begin
        if(Inst[4:0] == 0)
        begin
            WBSel = 1'b00;
        end
        
        else if(Inst[4:0] == 25 || Inst[4:0] == 27)
        begin
            WBSel = 2'b10;
        end
        else
        begin
            WBSel = 1'b1;
        end
    end
    
    always@(*)
    begin
        if(Inst[4:0] == 8)
        begin
            MemRW = 1'b1;
        end
              
        else
        begin
            MemRW = 1'b0;
        end
    end
    
    always @(*)
    begin
        if(Inst[4:0] == 8 || Inst[4:0] == 24)
        begin
            RegWEn = 1'b0;
        end
        
        else
        begin
            RegWEn = 1'b1;
        end
    end
    
    always@(*)
    begin
        if(Inst[4:0] == 8)                  //S-Type
        begin
            ImmSel = 3'b000;
        end
        
        else if(Inst[4:0] == 27)            //J-Type
        begin
            ImmSel = 3'b001;
        end
        
        else if(Inst[4:0] == 24)             //B-Type
        begin
            ImmSel = 3'b010;
        end
        
        else if(Inst[4:0] == 13 ||Inst[4:0] == 5)    //U-Type
        begin
            ImmSel = 3'b011;
        end
        
        else                        //I-Type
        begin
            ImmSel = 3'b100;
        end
    end
endmodule
