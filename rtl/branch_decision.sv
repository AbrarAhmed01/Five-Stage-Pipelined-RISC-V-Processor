`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2024 07:36:24 PM
// Design Name: 
// Module Name: branch_decision
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


module branch_decision(
    input [8:0]Inst,
    input BrEq,
    input BrLT,
    output logic BrUn,
    output logic ASel,
    output logic PCSel
    );
    
    always@(*)
    begin
        if(Inst[4:0] == 24 && Inst[6] == 1'b1)
        begin
            BrUn = 1'b1;
        end
        
        else
        begin
            BrUn = 1'b0;
        end
    end
    
    always @(*)
    begin
        if(Inst[4:0] == 27)
        begin
            ASel = 1'b1;
            PCSel = 1'b1;
        end
        
        else if(Inst[4:0] == 25)
        begin
            ASel = 1'b0;
            PCSel = 1'b1;
        end
        
        else if(Inst[4:0] == 24)
        begin
            if(Inst[7:5] == 3'b000 && BrEq == 1'b1)
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else if(Inst[7:5] == 3'b001 && BrEq == 1'b0)
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else if(Inst[7:5] == 3'b100 && BrLT == 1'b1)
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else if(Inst[7:5] == 3'b101 && (BrEq == 1'b1 || BrLT == 1'b0))
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else if(Inst[7:5] == 3'b110 && BrLT == 1'b1)
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else if(Inst[7:5] == 3'b111 && (BrEq == 1'b1 || BrLT == 1'b0))
            begin
                ASel = 1'b1;
                PCSel = 1'b1;
            end
            
            else
            begin
                ASel = 1'b1;
                PCSel = 1'b0;
            end
            
        end
        
        else if(Inst[4:0] == 13 || Inst[4:0] == 5)
        begin
            ASel = 1'b1;
            PCSel = 1'b0;
        end
        
        else
        begin
            ASel = 1'b0;
            PCSel = 1'b0;
        end
        
    end
    
endmodule
