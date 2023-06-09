`timescale 1ns / 1ps

`include "fetch.v"
`include "execute.v"
`include "decode.v"
`include "memory.v"
`include "pc_update.v"

module final;
  reg clk;
  
  reg [63:0] PC;

  reg [0:2] stat; 
  reg [2:0]c_in; 
  wire [2:0]c_out; 
  wire overflowfinal;
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire instr_valid;
  wire imem_error;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valE;
  wire [63:0] valM;
  wire cond;
  wire hlt;
  wire [63:0] updated_pc;

  wire [63:0] reg_mem0;
  wire [63:0] reg_mem1;
  wire [63:0] reg_mem2;
  wire [63:0] reg_mem3;
  wire [63:0] reg_mem4;
  wire [63:0] reg_mem5;
  wire [63:0] reg_mem6;
  wire [63:0] reg_mem7;
  wire [63:0] reg_mem8;
  wire [63:0] reg_mem9;
  wire [63:0] reg_mem10;
  wire [63:0] reg_mem11;
  wire [63:0] reg_mem12;
  wire [63:0] reg_mem13;
  wire [63:0] reg_mem14;

  fetch fetchinst(
    .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .instr_valid(instr_valid),
    .imem_error(imem_error),
    .hlt(hlt)
  );

  decode decodeinst(
    .clk(clk),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .cond(cond),
    .valA(valA),
    .valB(valB),
    .valE(valE),
    .valM(valM) ,
    .reg_mem0(reg_mem0),
    .reg_mem1(reg_mem1),
    .reg_mem2(reg_mem2),
    .reg_mem3(reg_mem3),
    .reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),
    .reg_mem6(reg_mem6),
    .reg_mem7(reg_mem7),
    .reg_mem8(reg_mem8),
    .reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),
    .reg_mem11(reg_mem11),
    .reg_mem12(reg_mem12),
    .reg_mem13(reg_mem13),
    .reg_mem14(reg_mem14) 
  );
  
  execute executeinst(
    .clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .cond(cond),
    .overflowfinal(overflowfinal),
    .c_in(c_in),
    .c_out(c_out)
  );


  memory meminst(
    .clk(clk),
    .icode(icode),
    .valA(valA),
    .valB(valB),
    .valE(valE),
    .valP(valP),
    .valM(valM)
  );

  pc_update pc_updateinst(
    .clk(clk),
    .icode(icode),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    .updated_pc(updated_pc)
  ); 

 
  always #5 clk= ~clk;

  initial begin
    stat[0]=1;
    stat[1]=0;
    stat[2]=0;
    clk=0;
    PC=64'd0;
  end 

  always@(*)
  begin
    PC=updated_pc;
    // $monitor("pc updated=%d",valP);
     $monitor("PC=%d clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d insval=%d memerr=%d cond=%d halt=%d  \n",PC,clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cond,valP);
  
  end

  always@(*)
  begin
    if(hlt)
    begin
      stat[2]=hlt;
      stat[1]=1'b0;
      stat[0]=1'b0;
    end
    else if(instr_valid)
    begin
      stat[1]=instr_valid;
      stat[2]=1'b0;
      stat[0]=1'b0;
    end
    else
    begin
      stat[0]=1'b1;
      stat[1]=1'b0;
      stat[2]=1'b0;
    end
  end
  
  always@(*)
  begin
    if(stat[1]==1'b0)
    begin
      $finish;
    end

		
  end

      always@(PC) begin
      $monitor("PC=%d clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d insval=%d memerr=%d cond=%d valp=%d  \n",PC,clk,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cond,valP);
      end

  
    

	
endmodule







           
       