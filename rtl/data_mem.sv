`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 09/12/2024 06:53:52 AM
// Design Name: 
// Module Name: data_mem
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


module data_mem
    (
        input clk,
        input [2:0]func3,
        input [31:0]addr,
        input [31:0]dataW,
        input MemRW,
        output logic [31:0]dataR
    );
    
    logic [7:0]d_mem[0:4096];
    
    
    initial begin
        d_mem = '{default: 32'b0};  // Assign zero to all elements
    end
    
   
    always @(posedge clk)
    begin
        if(MemRW == 1'b1)
        begin
            if(func3 == 0)
            begin
                d_mem[addr] <= dataW[7:0];
            end
            
            else if(func3 == 1)
            begin
                d_mem[addr]     <= dataW[7:0];
                d_mem[addr + 1] <= dataW[15:8];
            end
            
            else
            begin
                d_mem[addr]     <= dataW[7:0];
                d_mem[addr + 1] <= dataW[15:8];
                d_mem[addr + 2] <= dataW[23:16];
                d_mem[addr + 3] <= dataW[31:24];
            end
        end
        
    end
    
     // Memory Read Operation
    always @(*) begin
        if (MemRW == 1'b0) begin
            case (func3)
                3'b000: begin // Byte read, sign-extended
                    dataR <= {{24{d_mem[addr][7]}}, d_mem[addr]};
                end
                3'b001: begin // Half-word read, sign-extended
                    dataR <= {{16{d_mem[addr + 1][7]}}, d_mem[addr + 1], d_mem[addr]};
                end
                3'b100: begin // Byte read, zero-extended
                    dataR <= {24'b0, d_mem[addr]};
                end
                3'b101: begin // Half-word read, zero-extended
                    dataR <= {16'b0, d_mem[addr + 1], d_mem[addr]};
                end
                default: begin // Word read
                    dataR <= {d_mem[addr + 3], d_mem[addr + 2], d_mem[addr + 1], d_mem[addr]};
                end
            endcase
        end
    end
    
endmodule
