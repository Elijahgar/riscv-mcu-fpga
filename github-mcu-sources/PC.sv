`timescale 1ns / 1ps

module PC(input logic PC_CLK, 
          input logic PC_RST,
          input logic PC_LD,
          input logic [31:0] PC_IN,
          output logic [31:0] PC_OUT
          );

    always_ff @(posedge PC_CLK) begin
        if(PC_RST)
            PC_OUT <= 32'h00000000;
        else if (PC_LD)
            PC_OUT <= PC_IN;
    end
          
endmodule