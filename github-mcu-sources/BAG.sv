`timescale 1ns / 1ps


module BAG(
    input logic [31:0] BAG_PC,
    input logic [31:0] BAG_J,
    input logic [31:0] BAG_B,
    input logic [31:0] BAG_I,
    input logic [31:0] BAG_rs1,
    output logic [31:0] BAG_jalr,
    output logic [31:0] BAG_branch,
    output logic [31:0] BAG_jal
    );
    
   assign BAG_jalr = BAG_I + BAG_rs1;
   assign BAG_branch = BAG_B + BAG_PC;
   assign BAG_jal = BAG_J + BAG_PC;
   
endmodule
