`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////
module BCG(
    input logic [31:0] RS1_in, RS2_in,
    output logic br_eq, br_lt, br_ltu);
    always_comb begin
       if ($signed(RS1_in) < $signed(RS2_in)) 
            br_lt = 1;
       else
            br_lt = 0;
        
       if (RS1_in < RS2_in) 
            br_ltu = 1;
       else 
            br_ltu = 0;
            
      if(RS1_in == RS2_in)
            br_eq = 1;
      else 
            br_eq = 0;
    end
endmodule