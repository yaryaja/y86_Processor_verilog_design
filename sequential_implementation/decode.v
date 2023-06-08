`timescale 1ns / 1ps

module decode(
  clk,valA,valB,valE,valM,cond,rA,rB,icode, reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,
  reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,
  reg_mem12,reg_mem13,reg_mem14);
  input clk;
  input cond;
  output reg [63:0] valA;
  output reg [63:0] valB; 
  input [3:0] icode,rA,rB;
  input [63:0]valE,valM;
  reg[63:0]reg_mem[14:0];
  output reg [63:0] reg_mem0;
  output reg [63:0] reg_mem1;
  output reg [63:0] reg_mem2;
  output reg [63:0] reg_mem3;
  output reg [63:0] reg_mem4;
  output reg [63:0] reg_mem5;
  output reg [63:0] reg_mem6;
  output reg [63:0] reg_mem7;
  output reg [63:0] reg_mem8;
  output reg [63:0] reg_mem9;
  output reg [63:0] reg_mem10;
  output reg [63:0] reg_mem11;
  output reg [63:0] reg_mem12;
  output reg [63:0] reg_mem13;
  output reg [63:0] reg_mem14;
    initial begin
    reg_mem[0] = 64'd12;        //rax
    reg_mem[1] = 64'd10;        //rcx
    reg_mem[2] = 64'd101;       //rdx
    reg_mem[3] = 64'd3;         //rbx
    reg_mem[4] = 64'd254;       //rsp
    reg_mem[5] = 64'd50;        //rbp
    reg_mem[6] = -64'd143;      //rsi
    reg_mem[7] = 64'd10000;     //rdi
    reg_mem[8] = 64'd990000;    //r8
    reg_mem[9] = -64'd12345;    //r9
    reg_mem[10] = 64'd12345;    //r10
    reg_mem[11] = 64'd10112;    //r11
    reg_mem[12] = 64'd0;        //r12
    reg_mem[13] = 64'd1567;     //r13
    reg_mem[14] = 64'd8643;  
    end
  always@(*)
  begin
    
    if(icode==4'b0001) //cmovxx
    begin
       valA=reg_mem[rA];
      
    end
    //irmovq  no decode stage
    else if(icode==4'b0100) //rmmovq
    begin
      valA=reg_mem[rA];
      valB=reg_mem[rB];
    end
    else if(icode==4'b0101) //mrmovq
    begin
      
      valB=reg_mem[rB];
    end
    else if(icode==4'b0110) //OPq
    begin
       valA=reg_mem[rA];
       valB=reg_mem[rB];
    end
   
    else if(icode==4'b1000) //call
    begin
       
      valB=reg_mem[rB]; //rsp
    end
    else if(icode==4'b1001) //ret
    begin
       valA=reg_mem[4];
      valB=reg_mem[4];//rsp
    end
    else if(icode==4'b1010) //pushq
    begin
       valA=reg_mem[rA];
      valB=reg_mem[4];//rsp
    end
    else if(icode==4'b1011) //popq
    begin
        valA=reg_mem[4];
      valB=reg_mem[4];//rsp
    end
    // $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valA=%d,valB=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valP);
    reg_mem0=reg_mem[0];
    reg_mem1=reg_mem[1];
    reg_mem2=reg_mem[2];
    reg_mem3=reg_mem[3];
    reg_mem4=reg_mem[4];
    reg_mem5=reg_mem[5];
    reg_mem6=reg_mem[6];
    reg_mem7=reg_mem[7];
    reg_mem8=reg_mem[8];
    reg_mem9=reg_mem[9];
    reg_mem10=reg_mem[10];
    reg_mem11=reg_mem[11];
    reg_mem12=reg_mem[12];
    reg_mem13=reg_mem[13];
    reg_mem14=reg_mem[14];

  end



  //write back stage is done not able to pass array as argument 
  // srite back stage is merged with decoede stage with differnt clock
  always@( posedge clk)
  begin
    if(icode==4'b0010) //cmovxx
    begin
      if(cond==1'b1)
      begin
        reg_mem[rB]=valE;
      end
    end
    else if(icode==4'b0011) //irmovq
    begin
      reg_mem[rB]=valE;
    end
    else if(icode==4'b0101) //mrmovq
    begin
      reg_mem[rA]=valM;
    end
    else if(icode==4'b0110) //OPq
    begin
      reg_mem[rB]=valE;
    end
    else if(icode==4'b1000) //call
    begin
      reg_mem[4]=valE;
    end
    else if(icode==4'b1001) //ret
    begin
      reg_mem[4]=valE;
    end
    else if(icode==4'b1010) //pushq
    begin
      reg_mem[4]=valE;
    end
    else if(icode==4'b1011) //popq
    begin
      reg_mem[4]=valE;
      reg_mem[rA]=valM;
    end
     reg_mem0=reg_mem[0];
    reg_mem1=reg_mem[1];
    reg_mem2=reg_mem[2];
    reg_mem3=reg_mem[3];
    reg_mem4=reg_mem[4];
    reg_mem5=reg_mem[5];
    reg_mem6=reg_mem[6];
    reg_mem7=reg_mem[7];
    reg_mem8=reg_mem[8];
    reg_mem9=reg_mem[9];
    reg_mem10=reg_mem[10];
    reg_mem11=reg_mem[11];
    reg_mem12=reg_mem[12];
    reg_mem13=reg_mem[13];
    reg_mem14=reg_mem[14];
    
  end

endmodule