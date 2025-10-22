`timescale 1ns / 1ps

module OTTER_MCU(
    input logic clk,
    input logic rst,
    input logic intr,
    input logic [31:0] iobus_in,
    output logic iobus_wr,
    output logic [31:0] iobus_out,
    output logic [31:0] iobus_addr
);

    logic pcwrite_sig, regwrite_sig, memRDEN1_sig,reset_sig;
    logic memWE2_sig, memRDEN2_sig; 
    logic alusrca_sig, breq_sig, brlt_sig, brltu_sig;
    logic [1:0] alusrcb_sig, pcsource_sig, rf_wr_sel_sig;
    logic [3:0] alufun_sig;
    logic [31:0] pcout_bus, ir, rs1_bus, rs2_bus, j_bus, i_bus, b_bus, u_bus, s_bus;
    logic [31:0] jalr_bus, branch_bus, jal_bus,wd_bus,aluresult_bus,srca_bus,srcb_bus;
    logic [31:0] dout2_bus;


    PC_BLOCK pc(
        .PC_BLOCK_CLK(clk),
        .PC_BLOCK_RST(reset_sig),
        .PC_BLOCK_WRITE(pcwrite_sig),
        .PC_BLOCK_MUX_SEL(pcsource_sig),
        .PC_BLOCK_MUX_IN1(jalr_bus),
        .PC_BLOCK_MUX_IN2(branch_bus),
        .PC_BLOCK_MUX_IN3(jal_bus),
        .PC_BLOCK_OUT(pcout_bus)
    );

    Memory OTTER_MEMORY(
        .MEM_CLK(clk),
        .MEM_RDEN1(memRDEN1_sig),
        .MEM_RDEN2(memRDEN2_sig),
        .MEM_WE2(memWE2_sig),
        .MEM_ADDR1(pcout_bus[15:2]),
        .MEM_ADDR2(aluresult_bus),
        .MEM_DIN2(rs2_bus),
        .MEM_SIZE(ir[13:12]),
        .MEM_SIGN(ir[14]),
        .IO_IN(iobus_in),
        .IO_WR(iobus_wr),
        .MEM_DOUT1(ir),
        .MEM_DOUT2(dout2_bus)
    );

    // Branch Comparator
    BCG BCG_INST(
        .RS1_in(rs1_bus),
        .RS2_in(rs2_bus),
        .br_eq(breq_sig),
        .br_lt(brlt_sig),
        .br_ltu(brltu_sig)
    );

    // Branch and Jump Address Generator
    BAG BAG_INST(
        .BAG_PC(pcout_bus),
        .BAG_J(j_bus),
        .BAG_B(b_bus),
        .BAG_I(i_bus),
        .BAG_rs1(rs1_bus),
        .BAG_jalr(jalr_bus),
        .BAG_branch(branch_bus),
        .BAG_jal(jal_bus)
    );

    // ALU Decoder Unit
    CU_DCDR CU_DCDR_INST(
        .opcode(ir[6:0]),
        .func3(ir[14:12]),
        .tbit(ir[30]),
        .br_eq(breq_sig),
        .br_lt(brlt_sig),
        .br_ltu(brltu_sig),
        .alu_fun(alufun_sig),
        .alu_srca(alusrca_sig),
        .alu_srcb(alusrcb_sig),
        .pc_source(pcsource_sig),
        .rf_wr_sel(rf_wr_sel_sig)
    );

    // Control Unit FSM
    CU_FSM CU_FSM_INST (
        .clk(clk),
        .fsm_rst(rst),
        .opcode(ir[6:0]),
        .pc_write(pcwrite_sig),
        .reg_write(regwrite_sig),
        .mem_WE2(memWE2_sig),
        .mem_RDEN1(memRDEN1_sig),
        .mem_RDEN2(memRDEN2_sig),
        .pc_rst(reset_sig)
    );

    // Immediate Generator
    IMMED_GEN IMMED_GEN_INST (
        .IMM_in(ir[31:7]),
        .IMM_J(j_bus),
        .IMM_B(b_bus),
        .IMM_U(u_bus),
        .IMM_I(i_bus),
        .IMM_S(s_bus)
    );

    // Register File
    REG_FILE REG_FILE_INST (
        .RF_EN(regwrite_sig),
        .RF_clk(clk),
        .RF_ADDR1(ir[19:15]),
        .RF_ADDR2(ir[24:20]),
        .RF_WA(ir[11:7]),
        .RF_WD(wd_bus),
        .RF_RS1(rs1_bus),
        .RF_RS2(rs2_bus)
    );

    // ALU
    ALU ALU_INST(
        .srcA(srca_bus),
        .srcB(srcb_bus),
        .ALU_RESULT(aluresult_bus),
        .ALU_SEL(alufun_sig)
    );

    RF_MUX RF_MUX_INST (
        .rf_wr_sel(rf_wr_sel_sig),
        .PCOUT(pcout_bus),
        .CSR_reg(32'h00000000),
        .DOUT2(dout2_bus),
        .ALU_RESULT(aluresult_bus),
        .wd(wd_bus)
    );
    
    ALU_A_MUX otter_mux_a(
        .alu_srcA(alusrca_sig),  
        .RS1(rs1_bus),            
        .U_IMM(u_bus),        
        .srcA_OUT(srca_bus)   
    );
    
    ALU_MUX_B otter_mux_b(
        .ALU_srcB(alusrcb_sig),
        .RS2(rs2_bus),
        .I_IMM(i_bus),
        .S_IMM(s_bus),
        .PCOUT(pcout_bus),
        .srcB_OUT(srcb_bus)
    );

    assign iobus_addr = aluresult_bus;
    assign iobus_out = rs2_bus;

endmodule
