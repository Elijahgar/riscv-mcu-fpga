`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 12:47:20 PM
// Design Name: 
// Module Name: ALU_MUX_B
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


module ALU_MUX_B(
    input logic [1:0] ALU_srcB,
    input logic [31:0] RS2,
    input logic [31:0] I_IMM,
    input logic [31:0] S_IMM,
    input logic [31:0] PCOUT,
    output logic [31:0] srcB_OUT
    );
    
    
    always_comb begin
    
        case(ALU_srcB)
            2'b00: srcB_OUT = RS2;
            2'b01: srcB_OUT = I_IMM;
            2'b10: srcB_OUT = S_IMM;
            2'b11: srcB_OUT = PCOUT;
            default: srcB_OUT = 32'h00000000;
        endcase
    
    end
endmodule
