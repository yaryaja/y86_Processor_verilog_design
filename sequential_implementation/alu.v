`timescale 1ns / 1ps
`include "add64x1.v"
`include "add1x1.v"
`include "sub64x1.v"
`include "not1x1.v"
`include "not64x1.v"
`include "xor64x1.v"
`include "xor1x1.v"
`include "and64x1.v"
`include "and1x1.v"

module alu(
  input [1:0]control,
  input signed [63:0]a,
  input signed [63:0]b,
  output reg signed [63:0]ansfinal,
  output overflowfinal
  );
  
  wire signed [63:0]ans1;
  wire signed [63:0]ans2;
  wire signed [63:0]ans3;
  wire signed [63:0]ans4;
  reg overflowfinal;

  add64x1 g1(a,b,ans1,overflow1); 
  sub64x1 g2(a,b,ans2,overflow2);
  and64x1 g3(a,b,ans3);
  xor64x1 g4(a,b,ans4);
  always @(*)
  begin
    // $monitor("a=%d,b=%d control\n",a,b,control);
    case(control)
      2'b00:begin
          ansfinal=ans1+1'd1;
          overflowfinal=overflow1;
          ansfinal=ans1;
          // $monitor("ans2=%d control\n",b,control);

        end
      2'b01:begin
          ansfinal=ans2;
          overflowfinal=overflow2;
          $monitor("ans2=%d\n",ans2);
        end    
      2'b10:begin
          ansfinal=ans3;
          overflowfinal=1'b0;
          $monitor("ansfinal=%d\n",ans3);
        end
      2'b11:begin
          ansfinal=ans4;
          overflowfinal=1'b0;
          $monitor("ansfinal=%d\n",ans4);
        end
    endcase
      // ansfinal=4'b0100;  

//  $monitor("ansfinal=%d\n",ansfinal);
  end  

endmodule

