`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NCDC
// Engineer: Abrar Ahmed
// 
// Create Date: 08/29/2024 10:45:11 AM
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input reset,
    output logic [31:0]out
    );
    
    logic BSel;
    logic RegWEn;
    logic [1:0] WBSel;
    logic MemRW;
    logic [31:0] addr;
    logic [31:0] dataR;
    
    logic BrUn;
    logic Eq;
    logic Lt; 
    logic EX_program_jump, EX_data1_sel;
    logic EX_BSel, EX_MemRW, EX_RegWEn;
    logic MEM_MemRW, MEM_RegWEn; 
    logic [1:0] MEM_WBSel, EX_WBSel;
    
    logic [3:0] ALUSel, EX_ALUSel;
    logic [2:0] ImmSel;
    logic [31:0]imm_gen;
    logic [4:0] rs3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [31:0] dataW;
    logic [31:0] data_WB;
    logic [31:0] data_mem_out;
    logic [31:0] data1_ALU;
    logic [31:0] data1;
    logic [31:0] data2;
    logic [31:0] data_ALU;
    logic [31:0] pipe_IF_addr;
    logic [31:0] pipe_dataR;
    logic [31:0] pipe_ID_addr;
    logic [31:0] pipe_data1;
    logic [31:0] pipe_data2;
    logic [31:0] pipe_imm_gen;
    logic [31:0] pipe_ID_dataR;
    logic [31:0] pipe_MEM_dataR;
    logic [31:0] pipe_MEM_addr, pipe_MEM_data2, pipe_MEM_dataW, pipe_MEM_WB_addr;
    logic WB_RegWEn;
    logic [1:0]WB_WBSel;
    logic [31:0] pipe_WB_dataR, pipe_WB_dataW, data_WB_out, pipe_WB_addr, pipe_WB_WB_addr;
    logic [1:0] fwd_A,fwd_B;
    logic [31:0] data_A_ALU, data_B_ALU;
    logic ControlEn, PCWrite, IF_ID_Write;
    logic signal_RegWEn, signal_MemRW;
    logic flush;
    logic [31:0] pipe_MEM_data1, pipe_WB_data1, pipe_WB_data2;
    
    assign out = data_WB;
    
    logic [31:0]inst_addr;
    
    assign inst_addr = addr - 32'b10000000000000000000000000000000;
    
    inst_mem instr_memory(
        .addr(inst_addr[31:2]),
        .dataR(dataR)
    );
    
    assign rs3 = pipe_WB_dataR[11:7];
    assign rs1 = pipe_dataR[19:15];
    assign rs2 = pipe_dataR[24:20];
    
    
    fwd_logic fwd_unit(
    .EX_MEM_Rd(pipe_MEM_dataR[11:7]),
    .MEM_WB_Rd(rs3),
    .ID_EX_Rs1(pipe_ID_dataR[19:15]),
    .ID_EX_Rs2(pipe_ID_dataR[24:20]),
    .EX_MEM_RegWrite(MEM_RegWEn),
    .MEM_WB_RegWrite(WB_RegWEn),
    .fwd_A(fwd_A),
    .fwd_B(fwd_B)
    );
    
    hazard_detection haz_det_unit(
    .program_jump(EX_program_jump),
    .ID_EX_MemRead(EX_WBSel),
    .ID_EX_Rd(pipe_ID_dataR[11:7]),
    .IF_ID_Rs1(rs1),
    .IF_ID_Rs2(rs2),
    .IF_ID_Write(IF_ID_Write),
    .PCWrite(PCWrite),
    .ControlEn(ControlEn),
    .flush(flush)
    );
    
    
    always@(*)
    begin
        if(ControlEn == 1'b0)
        begin
            signal_RegWEn = 1'b0;
            signal_MemRW = 1'b0;
        end
        
        else
        begin
            signal_RegWEn = RegWEn;
            signal_MemRW = MemRW;
        end
    end
    
    always@(*)
    begin
        if(EX_BSel == 1'b0)
        begin
            data_ALU = data_B_ALU;
        end
        
        else
        begin
            data_ALU = pipe_imm_gen;
        end
    end
    
    
    always@(*)
    begin
        if(WB_WBSel == 2'b00)
        begin
            data_WB = data_WB_out;
        end
        
        else if(WB_WBSel == 2'b10)
        begin
            data_WB = pipe_WB_WB_addr;
        end
        
        else
        begin
            data_WB = pipe_WB_dataW;
        end
    
    end
    
    assign pipe_MEM_WB_addr = pipe_MEM_addr + 4;
    
    program_counter pc
    (
        .clk(clk),
        .reset(reset),
        .enable(PCWrite),
        .load_enable(EX_program_jump),
        .load(dataW),
        .address_out(addr)
    );
    
    pipe_reg #(.width(64)) IF_ID
	(
		.data_in({addr, dataR}),
		.clk(clk),
		.write_enable(IF_ID_Write),
		.reset(reset),
		.clr(flush),
		.data_out({pipe_IF_addr, pipe_dataR})
	);
	
    
    reg_file rg
    (
        .clk(clk),
        .RegWEn(WB_RegWEn),
        .rs1(rs1),
        .rs2(rs2),
        .rs3(rs3),
        .dataW(data_WB),
        .data1(data1),
        .data2(data2)
    );
    
	pipe_reg #(.width(169)) ID_EX
	(
		.data_in({BSel, ALUSel, signal_MemRW, signal_RegWEn, WBSel, pipe_IF_addr, data1, data2, imm_gen, pipe_dataR}),
		.clk(clk),
		.write_enable(1'b1),
		.reset(reset),
		.clr(flush),
		.data_out({EX_BSel, EX_ALUSel, EX_MemRW, EX_RegWEn, EX_WBSel, pipe_ID_addr, pipe_data1, pipe_data2, pipe_imm_gen, pipe_ID_dataR})
	);
    
    
    branch_comp bran_com
    (
    .A(data_A_ALU),
    .B(data_B_ALU),
    .BrUn(BrUn),
    .Eq(Eq),
    .Lt(Lt) 
    );

    imm_gen imm_generator(
        .imm(pipe_dataR),
        .ImmSel(ImmSel),
        .sign_extend_value(imm_gen)
    );


    always @(*)
    begin
        if(EX_data1_sel == 1'b1)
        begin
            data1_ALU = pipe_ID_addr;
        end
        
        else
        begin
            data1_ALU = data_A_ALU;
        end
    
    end
    
    always @(*)
    begin
        case(fwd_A)
            2'b01:
                begin
                    data_A_ALU = data_WB;
                end
                
            2'b10:
                begin
                    data_A_ALU = pipe_MEM_dataW;
                end
                
            default:
                begin
                    data_A_ALU = pipe_data1;
                end
                
        endcase
    end
    
    always @(*)
    begin
        case(fwd_B)
            2'b01:
                begin
                    data_B_ALU = data_WB;
                end
                
            2'b10:
                begin
                    data_B_ALU = pipe_MEM_dataW;
                end
                
            default:
                begin
                    data_B_ALU = pipe_data2;
                end
                
        endcase
    end
    
    alu_logic ALU
    (
        .rs1(data1_ALU),
        .rs2(data_ALU),
        .opcode(EX_ALUSel),
        .rd(dataW)
    );
    
    
    pipe_reg #(.width(164)) EX_MEM
	(
		.data_in({EX_MemRW, EX_RegWEn, EX_WBSel, pipe_ID_addr, data_B_ALU, pipe_ID_dataR, dataW, data_A_ALU}),
		.clk(clk),
		.write_enable(1'b1),
		.reset(reset),
		.clr(1'b0),
		.data_out({MEM_MemRW, MEM_RegWEn, MEM_WBSel, pipe_MEM_addr, pipe_MEM_data2, pipe_MEM_dataR, pipe_MEM_dataW, pipe_MEM_data1})
	);
    
    
    data_mem data_memory
    (
        .clk(clk),
        .func3(pipe_MEM_dataR[14:12]),
        .addr(pipe_MEM_dataW),
        .dataW(pipe_MEM_data2),
        .MemRW(MEM_MemRW),
        .dataR(data_mem_out)
    );
    
    pipe_reg #(.width(227)) MEM_WB
	(
		.data_in({MEM_RegWEn, MEM_WBSel, pipe_MEM_dataR, pipe_MEM_dataW, data_mem_out, pipe_MEM_addr, pipe_MEM_data1, pipe_MEM_data2, pipe_MEM_WB_addr}),
		.clk(clk),
		.write_enable(1'b1),
		.reset(reset),
		.clr(1'b0),
		.data_out({WB_RegWEn, WB_WBSel, pipe_WB_dataR, pipe_WB_dataW, data_WB_out, pipe_WB_addr, pipe_WB_data1, pipe_WB_data2, pipe_WB_WB_addr})
	);
    
    branch_decision bran_dec_unit(
    .Inst({pipe_ID_dataR[30], pipe_ID_dataR[14:12], pipe_ID_dataR[6:2]}),
    .BrEq(Eq),
    .BrLT(Lt),
    .BrUn(BrUn),
    .ASel(EX_data1_sel),
    .PCSel(EX_program_jump)
    );
    
    control_unit ctrl_unit(
    .Inst({pipe_dataR[30], pipe_dataR[14:12], pipe_dataR[6:2]}),
    .ImmSel(ImmSel),
    .BSel(BSel),
    .ALUSel(ALUSel),
    .MemRW(MemRW),
    .RegWEn(RegWEn),
    .WBSel(WBSel)
    );

tracer tracer_ip (
.clk_i(clk),
.rst_ni(reset),
.hart_id_i(32'b0),
.rvfi_valid(1'b1),
.rvfi_insn_t(pipe_WB_dataR),
.rvfi_rs1_addr_t(pipe_WB_dataR[19:15]),
.rvfi_rs2_addr_t(pipe_WB_dataR[24:20]),
.rvfi_rs1_rdata_t(pipe_WB_data1),
.rvfi_rs2_rdata_t(pipe_WB_data2),
.rvfi_rd_addr_t(pipe_WB_dataR[11:7]) ,
.rvfi_rd_wdata_t(data_WB),
.rvfi_pc_rdata_t(pipe_WB_addr),
.rvfi_pc_wdata_t(pipe_WB_dataW),
.rvfi_mem_addr(0),
.rvfi_mem_rmask(0),
.rvfi_mem_wmask(0),
.rvfi_mem_rdata(0),
.rvfi_mem_wdata(0)
);
endmodule
