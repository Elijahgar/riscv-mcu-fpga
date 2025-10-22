`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 09:25:37 PM
// Design Name: 
// Module Name: IMM_GEN
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


module IMMED_GEN(
    input logic [31:7] IMM_in, //bits [31:7] of instruction
    output logic [31:0] IMM_J, IMM_B, IMM_U, IMM_I, IMM_S);

assign IMM_J = {{12{IMM_in[31]}}, IMM_in[19:12], IMM_in[20], IMM_in[30:21], 1'b0};
assign IMM_B = {{20{IMM_in[31]}}, IMM_in[7], IMM_in[30:25],IMM_in[11:8], 1'b0};
assign IMM_U = {IMM_in[31:12], {12'd0}};
assign IMM_I = {{21{IMM_in[31]}}, IMM_in[30:20]};
assign IMM_S = {{21{IMM_in[31]}}, IMM_in[30:25], IMM_in[11:7]};
endmodule





