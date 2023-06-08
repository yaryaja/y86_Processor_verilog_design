`timescale 1ns / 1ps

module sub64x1(
  input signed [63:0]a,
  input signed [63:0]b,
  output signed [63:0]ans,
  output overflow);

  wire [63:0]notb;
  not64x1 g1(b,notb);

  wire [63:0]l;
  assign l=64'b1;

  wire [63:0]bcmp;
  add64x1 g2(notb,l,bcmp,c);  // adding 1 to 1's complement of b to make bcmp(=2's complement of b)

  add64x1 g3(a,bcmp,ans,overflow); // adding a to 2's complement of b(=bcmp) to make a-b

endmodule