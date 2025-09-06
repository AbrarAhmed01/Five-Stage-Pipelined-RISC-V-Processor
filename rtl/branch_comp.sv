`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 09/13/2024 09:25:56 AM
// Design Name: 
// Module Name: branch_comp
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


module branch_comp(
    input [31:0]A,
    input [31:0]B,
    input BrUn,
    output logic Eq,
    output logic Lt 
    );
    
    always @(*)
    begin
        if (A == B)
        begin
            Eq = 1'b1;
            Lt = 1'b0;
        end
        
        else
        begin
            Eq = 1'b0;
            Lt = 1'b0;
        end
        
        if(BrUn == 1'b1)       //unisgned comparison
        begin
            if (A < B)
            begin
                Lt = 1'b1;
            end
            
            else
            begin
                Lt = 1'b0;
            end
        end
        
        else        //signed comparison
        begin
            if ($signed(A) < $signed(B))
            begin
                Lt = 1'b1;
            end
            
            else
            begin
                Lt = 1'b0;
            end
        end
        
    
    end
endmodule
