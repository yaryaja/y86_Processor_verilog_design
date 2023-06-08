module execute_reg(
    input clk,
    input [3:0] d_icode,
    input [3:0] d_ifun,
    input [63:0] d_valC,
    input   signed [63:0] d_valA,
    input  signed  [63:0] d_valB,
    input [3:0] d_destE,
    input [3:0] d_destM,
    input [3:0] d_srcA,
    input [3:0] d_srcB,
    input [1:0] d_status,
    input E_bubble,

    output reg [3:0] E_icode,
    output reg [3:0] E_ifun,
    output  reg [63:0] E_valC,
    output reg signed    [63:0] E_valA,
    output   reg signed   [63:0] E_valB,
    output reg [3:0] E_destE,
    output reg [3:0] E_destM ,
    output reg[1:0] E_status
);
always@(posedge clk)
  begin 
    if(E_bubble)
    begin
      E_status <= 2'b11;
      E_icode <= 4'b0001;
      E_ifun <= 4'b0000;
      E_valC <= 4'b0000;
      E_valA <= 4'b0000;
      E_valB <= 4'b0000;
      E_destE <= 4'hF;
      E_destM <= 4'hF;
    end
    else
    begin
      // Execute register update
      E_status <=d_status;
      // $display("  =%D",E_status);
      E_icode <= d_icode;
      E_ifun <= d_ifun;
      E_valC <= d_valC;
      E_valA <= d_valA;
      E_valB <= d_valB;
      E_destE <= d_destE;
      E_destM <= d_destM;
      // $display("enterd regexecute");
    end

  end

endmodule