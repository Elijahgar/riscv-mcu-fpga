`timescale 1ns / 1ps

module ALU(
    input logic [31:0] srcA,
    input logic [31:0] srcB,
    output logic [31:0] ALU_RESULT,
    input logic [3:0] ALU_SEL
);

    always_comb begin
        
        case (ALU_SEL)
            4'b0000: ALU_RESULT = $signed(srcA) + $signed(srcB); // add
            4'b1000: ALU_RESULT = $signed(srcA) - $signed(srcB); // sub
            4'b0110: ALU_RESULT = srcA | srcB;                   // or
            4'b0111: ALU_RESULT = srcA & srcB;                   // and
            4'b0100: ALU_RESULT = srcA ^ srcB;                   // xor
            4'b0101: ALU_RESULT = srcA >> srcB[4:0];                  // srl
            4'b0001: ALU_RESULT = srcA << srcB[4:0];                  // sll
            4'b1101: ALU_RESULT = $signed(srcA) >>> srcB[4:0];        // sra
            4'b0010: ALU_RESULT = $signed(srcA) < $signed(srcB); // slt
            4'b0011: ALU_RESULT = srcA < srcB;                   // sltu
            4'b1001: ALU_RESULT = srcA;                          // lui_copy
            default: ALU_RESULT = 32'h00000000;                         // Ensure all cases are covered
        endcase
    end

endmodule
