`timescale 1ns / 1ps

module CU_DCDR
    (
    input logic [6:0] opcode,
    input logic [2:0] func3,
    input logic tbit,
    input logic br_eq,
    input logic br_lt,
    input logic br_ltu,
    output logic [3:0] alu_fun,
    output logic alu_srca,
    output logic [1:0] alu_srcb,
    output logic [1:0] pc_source,
    output logic [1:0] rf_wr_sel
    );

    always_comb begin
        alu_fun = 0;
        alu_srca = 0;
        alu_srcb = 0;
        pc_source = 0;
        rf_wr_sel = 0;

        case(opcode)
            7'b0110111: begin //lui 
                alu_fun = 4'b1001;
                alu_srca = 1;
                rf_wr_sel = 3;
            end

            7'b0010111: begin // auipc
                alu_srca = 1;
                alu_srcb = 3;
                rf_wr_sel = 3;
                alu_fun = 4'b0000;
            end

            7'b0010011: begin // I-type instructions
                rf_wr_sel = 3;
                alu_srcb = 1;

                case(func3)
                    3'b000: alu_fun = 4'b0000; // addi
                    3'b111: alu_fun = 4'b0111; // andi
                    3'b110: alu_fun = 4'b0110; // ori
                    3'b001: alu_fun = 4'b0001; // slli
                    3'b010: alu_fun = 4'b0010; // slti
                    3'b011: alu_fun = 4'b0011; // sltiu
                    3'b100: alu_fun = 4'b0100; // xori
                    3'b101: begin // srai and srli
                        if(tbit == 1)
                            alu_fun = 4'b1101;
                        else
                            alu_fun = 4'b0101;
                    end
                endcase
            end

            7'b0000011: begin //LOADS
                alu_srcb = 1;
                rf_wr_sel = 2;   
            end

            7'b1100111:begin //jalr
                pc_source = 1;
                rf_wr_sel = 0;
            end 
            7'b1101111: begin
                pc_source = 3; //jal
                rf_wr_sel = 0;
            end

            7'b0100111: alu_srcb = 2; // S type instructions

            7'b0110011: begin // R type instructions
                pc_source = 0;
                rf_wr_sel = 3;

                case(func3)
                    3'b000: begin //add and sub
                        if(tbit == 0)
                            alu_fun = 4'b0000;
                        else
                            alu_fun = 4'b1000;
                    end
                    3'b111: alu_fun = 4'b0111; //and
                    3'b110: alu_fun = 4'b0110; //or
                    3'b001: alu_fun = 4'b0001; //sll
                    3'b010: alu_fun = 4'b0010; //slt
                    3'b011: alu_fun = 4'b0011; //sltu
                    3'b101: begin //sra and srl
                        if(tbit == 1)
                            alu_fun = 4'b1101;
                        else
                            alu_fun = 4'b0101;
                    end
                    3'b100: alu_fun = 4'b0100; //xor
                    default: alu_fun = 4'b0000; 
                endcase
            end

            7'b1100011: begin // B type Instructions
                case(func3)
                    3'b000: begin // beq
                        if(br_eq == 1)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end
                    3'b111: begin //bgeu
                        if(br_ltu == 0)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end
                    3'b101: begin // bge
                        if(br_lt == 0)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end

                    3'b110: begin //bltu
                        if(br_ltu == 1)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end
                    3'b100: begin // blt
                        if(br_lt == 1)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end
                    3'b001: begin //bne
                        if(br_eq == 0)
                            pc_source = 2;
                        else
                            pc_source = 0;
                    end
                    default: begin
                        pc_source = 0;
                    end
                endcase
            end

            default: begin
                alu_fun = 0;
            end
        endcase 
    end //ends always block
endmodule
