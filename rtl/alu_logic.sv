`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 09:53:38 AM
// Design Name: 
// Module Name: alu
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


module alu_logic
(
    input [31:0]rs1,
    input [31:0]rs2,
    input [3:0]opcode,
    output logic [31:0]rd
);
    
    always @(*)
    begin
        case(opcode)
            4'b0000: rd = rs1 + rs2;                        // add
            4'b0001: rd = rs1 - rs2;                        // sub
            4'b0010: rd = rs1 << rs2[4:0];                  // sll
            4'b0011: rd = rs2;								//lui
            4'b0100:
                begin
                    rd = $signed(rs1) < $signed(rs2) ? 32'b1 : 32'b0;      // slt (set less than
                end
            4'b0110: 
                begin
                    rd = (rs1 < rs2) ? 32'b1 : 32'b0;    // sltu (set less than unsigned 
                end
            4'b1000: rd = rs1 ^ rs2;                        // xor
            4'b1010: rd = rs1 >> rs2[4:0];                  // srl
            4'b1011: rd = $signed(rs1) >>> rs2[4:0];                 // sra(shift right arithmetic)
            4'b1100: rd = rs1 | rs2;                        // or
            4'b1110: rd = rs1 & rs2;                        // and
            default: rd = 32'b0;                            // Default case
        endcase
    end
    
endmodule
