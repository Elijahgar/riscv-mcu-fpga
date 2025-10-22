`timescale 1ns / 1ps

module CU_FSM(
    input logic clk,
    input logic fsm_rst,
    input logic [6:0] opcode,
    output logic pc_write,
    output logic reg_write,
    output logic mem_WE2,
    output logic mem_RDEN1,
    output logic mem_RDEN2,
    output logic pc_rst
    );

    typedef enum{ST_init, ST_FETCH, ST_EXECUTE, ST_WRITEBACK} STATES;
    STATES NS, PS;

    always_ff @(posedge clk) begin
        if(fsm_rst == 1)
            PS <= ST_init;
        else
            PS <= NS;
    end

    always_comb begin
        pc_write = 0;
        reg_write = 0;
        mem_WE2 = 0;
        mem_RDEN1 = 0;
        mem_RDEN2 = 0;
        pc_rst = 0;

        case(PS)
            ST_init: begin
                pc_rst = 1;
                NS = ST_FETCH;
            end

            ST_FETCH: begin
                mem_RDEN1 = 1;
                NS = ST_EXECUTE;
            end

            ST_WRITEBACK: begin
                mem_RDEN2 = 1;
                reg_write = 1;
                pc_write = 1;
                NS = ST_FETCH;
            end

            ST_EXECUTE: begin
                case(opcode)
                    7'b0110011,  // R-type instructions
                    7'b1100111,  // jalr
                    7'b0010011,  // I-type ALU instructions (addi, andi, ori, etc.)
                    7'b1101111, //jal
                    7'b0010111: begin // auipc
                        pc_write = 1;
                        reg_write = 1;
                    end
                    
                    7'b0110111: begin  // lui
                        pc_write = 1;
                        reg_write = 1;
                        mem_RDEN1 = 1;    
                    end

                    7'b0000011: begin // Loads
                        mem_RDEN2 = 1;
                        pc_write = 0;
                        reg_write = 0;
                        mem_WE2 = 0;
                    end

                    7'b0100011: begin // S-type (store) instructions
                        pc_write = 1;
                        mem_WE2 = 1;
                    end
                    
                    

                    7'b1100011: begin // B-type (branch) instructions
                        pc_write = 1;
                        reg_write = 1;
                        mem_WE2 = 0;
                        mem_RDEN2 = 0;
                    end

                    default: begin
                        reg_write = 0;
                    end
                endcase // opcode

                if(mem_RDEN2 == 1)
                    NS = ST_WRITEBACK;
                else
                    NS = ST_FETCH;
            end // ST_EXECUTE

            default: begin
                NS = ST_init;
            end
        endcase // states
    end // always_comb
endmodule
