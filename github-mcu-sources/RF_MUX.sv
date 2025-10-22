`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/26/2025 12:30:37 PM
// Design Name: 
// Module Name: RF_MUX
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


module RF_MUX(
    input logic [1:0] rf_wr_sel,
    input logic [31:0] PCOUT,
    input logic [31:0] CSR_reg,
    input logic [31:0] DOUT2,
    input logic [31:0] ALU_RESULT,
    output logic [31:0] wd
    );
    
    
    always_comb begin
        
        case(rf_wr_sel)
        2'b00: wd = PCOUT;
        2'b01: wd = CSR_reg;
        2'b10: wd = DOUT2;
        2'b11: wd = ALU_RESULT;
        default: wd = 32'h00000000;
        endcase
    
    end
endmodule
