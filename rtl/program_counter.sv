`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 10:38:23 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter
(
    input clk,
    input reset,
    input enable,
    input load_enable,
    input [31:0] load,
    output logic [31:0] address_out
);
    
        logic [31:0] count;
        
        assign address_out = count;
        
        always @(posedge clk or posedge reset)
        begin
            if(reset == 1'b1 || count == -1)
            begin
                count <= 32'b10000000000000000000000000000100;
                //count <= 0;
            end
            
            else if(load_enable == 1'b1 && enable == 1'b1)
            begin
                count <= load;
            end
            
            else if(enable == 1'b1)
            begin
                count <= count + 4;
            end
            
            else
            begin
                count <= count;
            end
        end
endmodule
