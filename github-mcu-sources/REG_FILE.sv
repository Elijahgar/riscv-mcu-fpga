`timescale 1ns / 1ps


module REG_FILE(
    input logic RF_EN,
    input logic RF_clk,
    input logic [4:0] RF_ADDR1,
    input logic [4:0] RF_ADDR2,
    input logic [4:0] RF_WA,
    input logic [31:0] RF_WD,
    output logic [31:0] RF_RS1,
    output logic [31:0] RF_RS2
    );
    
    logic [31:0] ram [0:31];

    initial begin
        int i;
            for (i=0; i<32; i=i+1) begin
            ram[i] = 0;
        end
    end
    
    assign RF_RS1 = ram[RF_ADDR1];
    assign RF_RS2 = ram[RF_ADDR2];
    
    always_ff @(posedge RF_clk) begin
        if(RF_EN && RF_WA != 5'b00000)
            ram[RF_WA] <= RF_WD;
    end
    
    
endmodule
