module memory_reg(
    input clk,
    input [1:0] e_status,
    input [3:0] e_icode,
    input e_cond,
    input  signed  [63:0] e_valE,
    input   signed [63:0] e_valA,
    input  signed  [63:0] e_valB,
    input [3:0] e_destE,
    input [3:0] e_destM,
    input M_bubble,
    
    output reg [1:0] M_status,
    output reg [3:0] M_icode,
    output reg M_cond,
    output reg signed   [63:0] M_valA,
    output reg  signed  [63:0] M_valB,
    output reg signed   [63:0] M_valE,
    output reg [3:0] M_destE,
    output reg [3:0] M_destM

);

  always@(posedge clk)
  begin
    if(M_bubble)
    begin
      M_status <= 2'd3;
      M_icode <= 4'b001;
      M_cond <= 1;
      M_valE <= 0;
      M_valA <= 0;
      M_destE <= 4'b1111;
      M_destM <= 4'b1111;
    end
    else
    begin
      M_status <= e_status;
      M_icode <= e_icode;
      M_cond <= e_cond;
      M_valE <= e_valE;
      M_valA <= e_valA;
  // $display("memory errorkhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh=%d",M_valA);
      M_valB <= e_valB;
      M_destE <= e_destE;
      M_destM <= e_destM;
    end
  end
endmodule