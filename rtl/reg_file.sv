`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 09:45:42 AM
// Design Name: 
// Module Name: register_file
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


module reg_file
(
    input clk,
    input RegWEn,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rs3,
    input [31:0]dataW,
    output logic [31:0]data1,
    output logic [31:0]data2
);
      
    logic [31:0]register_file[0:31];
    
    initial begin
        register_file = '{default: 32'b0};  // Assign zero to all elements
    end
    
    assign data1 = register_file[rs1];
    assign data2 = register_file[rs2];
    
    always @(negedge clk)
    begin
        if (RegWEn == 1'b1)
        begin
            if(rs3 != 4'b0000)
            begin
                register_file[rs3] <= dataW;
            end
        end
    end
endmodule
