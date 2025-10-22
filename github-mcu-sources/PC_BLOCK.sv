`timescale 1ns / 1ps


module PC_BLOCK(
    input logic PC_BLOCK_CLK,
    input logic PC_BLOCK_RST,
    input logic PC_BLOCK_WRITE,
    input logic [1:0] PC_BLOCK_MUX_SEL,
    input logic [31:0] PC_BLOCK_MUX_IN1,
    input logic [31:0] PC_BLOCK_MUX_IN2,
    input logic [31:0] PC_BLOCK_MUX_IN3,
    output logic [31:0] PC_BLOCK_OUT
);

    logic [31:0] PC_BLOCK_MUX_OUT, PC_BLOCK_MUX_IN0;

    // Program Counter (PC)
    PC pc1(
        .PC_CLK(PC_BLOCK_CLK),
        .PC_RST(PC_BLOCK_RST),
        .PC_LD(PC_BLOCK_WRITE),
        .PC_IN(PC_BLOCK_MUX_OUT),
        .PC_OUT(PC_BLOCK_OUT)
    );
    
    // PC MUX
    PC_MUX pcmux(
        .PC_MUX_SEL(PC_BLOCK_MUX_SEL),
        .PC_MUX_IN0(PC_BLOCK_MUX_IN0),
        .PC_MUX_IN1(PC_BLOCK_MUX_IN1),
        .PC_MUX_IN2(PC_BLOCK_MUX_IN2),
        .PC_MUX_IN3(PC_BLOCK_MUX_IN3),
        .PC_MUX_OUT(PC_BLOCK_MUX_OUT)
    );

    // Set PC_BLOCK_MUX_IN0 to PC output + 4
    assign PC_BLOCK_MUX_IN0 = PC_BLOCK_OUT + 4;

endmodule

