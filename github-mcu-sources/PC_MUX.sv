`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module PC_MUX(input logic [1:0] PC_MUX_SEL, 
              input logic [31:0] PC_MUX_IN0,
              input logic [31:0] PC_MUX_IN1,
              input logic [31:0] PC_MUX_IN2,
              input logic [31:0] PC_MUX_IN3,
              output logic [31:0] PC_MUX_OUT);
              
    always_comb begin
        case(PC_MUX_SEL)
            2'b00: PC_MUX_OUT = PC_MUX_IN0;
            2'b01: PC_MUX_OUT = PC_MUX_IN1;
            2'b10: PC_MUX_OUT = PC_MUX_IN2;
            2'b11: PC_MUX_OUT = PC_MUX_IN3;
            default: PC_MUX_OUT = 32'h00000000;
        endcase
    end
endmodule
