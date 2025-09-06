`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 10:45:11 AM
// Design Name: 
// Module Name: pipe_reg_tb
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


module pipe_reg_tb();

	logic [63:0]data_in;
	logic clk;
	logic write_enable;
	logic reset;
	logic [63:0]data_out;
	
	pipe_reg dut(.*);
	
	initial
	begin
	clk = 1'b0;
	forever 
		begin
			#10;
			clk = ~clk;
		end
	end
	
	
	initial 
	begin
		reset = 1'b1;
		write_enable = 1'b0;
			
		#5;
		reset = 0;
		
		#10;
		data_in = 4564;
		
		#10;
		write_enable = 1'b1;
		
		#10;
		write_enable = 1'b0;
		
		#10;
		data_in = 123485;
		write_enable = 1'b1;
		
		#10;
		write_enable = 1'b0;
		#1000000;
		
		$finish();
		
	end
	
endmodule
