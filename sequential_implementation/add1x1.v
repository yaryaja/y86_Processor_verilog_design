`timescale 1ns / 1ps

module add1x1(
  input a,
  input b,
  input cin,
  output sum,
  output co);

  xor g1(sum,a,b,cin);
  and g2(i,a,b);
  and g3(j,a,cin);
  and g4(k,b,cin);
  or g5(co,i,j,k);

endmodule