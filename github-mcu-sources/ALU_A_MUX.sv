`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 12:37:35 PM
// Design Name: 
// Module Name: ALU_A_MUX
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


module ALU_A_MUX(
    input logic alu_srcA,
    input logic [31:0] RS1,
    input logic [31:0] U_IMM,
    output logic [31:0] srcA_OUT
    );
    
    always_comb begin
        case(alu_srcA)
            1'b0: srcA_OUT = RS1;
            1'b1: srcA_OUT = U_IMM;
            default: srcA_OUT = 32'h00000000;
        endcase
    
    end
endmodule
