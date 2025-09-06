`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 10:45:11 AM
// Design Name: 
// Module Name: pipe_reg
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


module pipe_reg
	#(parameter width = 64)
	(
		input [width-1:0]data_in,
		input clk,
		input write_enable,
		input reset,
		input clr,
		output logic [width-1:0]data_out
	);
	
	always@(posedge clk or posedge reset)
	begin
		if(reset == 1'b1 || clr == 1'b1)
		begin
			data_out <= 0;
		end
		
		else if(write_enable == 1'b1)
		begin
			data_out <= data_in;
		end
		
		else
		begin
			data_out <= data_out;
		end
	
	end
endmodule
