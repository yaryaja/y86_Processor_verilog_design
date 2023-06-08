`timescale 1ns / 1ps

`include "decode_reg.v"
`include "decode.v"
`include "execute.v"
`include "reg_execute.v"
`include "fetch.v"
`include "memory.v"
`include "memory_reg.v"
`include "wb_register.v"
`include "control_logic.v"
`include "predict_pc.v"
`include "select_pc.v"

module final();

reg clk;
reg [63:0]F_predPC;
// reg clk;
wire [63:0]current_pc;
wire zf,sf,of;

  wire  signed [63:0] reg_mem0;
  wire  signed [63:0] reg_mem1;
  wire  signed [63:0] reg_mem2;
  wire  signed [63:0] reg_mem3;
  wire  signed [63:0] reg_mem4;
  wire  signed [63:0] reg_mem5;
  wire  signed [63:0] reg_mem6;
  wire  signed [63:0] reg_mem7;
  wire  signed [63:0] reg_mem8;
  wire  signed [63:0] reg_mem9;
  wire  signed [63:0] reg_mem10;
  wire  signed [63:0] reg_mem11;
  wire signed  [63:0] reg_mem12;
  wire  signed [63:0] reg_mem13;
  wire  signed [63:0] reg_mem14;

  // select_pc selcec_pcinst(.W_valM(W_valM),.M_valA(M_valA),.M_cond(M_cond),W_icode(W_icode),.M_icode(M_icode),.f_valP(f_valP),.F_predPC(F_predPC),.f_pc(f_pc));




//F
wire [63:0]f_predicted_pc;

//f
wire [1:0] f_status;
wire [3:0] f_icode;
wire [3:0] f_ifun;
wire [63:0] f_valC;
wire [63:0] f_valP;
wire [3:0] f_rA;
wire [3:0] f_rB;
//D
wire [1:0] D_status;
wire [3:0] D_icode;
wire [3:0] D_ifun;
wire [63:0] D_valC;
wire [63:0] D_valP;
wire [3:0] D_rA;
wire [3:0] D_rB;
//d
wire [1:0] d_status;
wire [3:0] d_icode;
wire [3:0] d_ifun;
wire [63:0] d_valC;
wire signed [63:0] d_valA;
wire signed [63:0] d_valB;
wire [3:0] d_destE;
wire [3:0] d_destM;
wire [3:0] d_srcA;
wire [3:0] d_srcB;
//E
wire [1:0] E_status;
wire [3:0] E_icode;
wire [3:0] E_ifun;
wire signed [63:0] E_valC;
wire signed [63:0] E_valA;
wire signed [63:0] E_valE;
wire signed [63:0] E_valB;
wire [3:0] E_destE;
wire [3:0] E_destM;
wire [3:0] E_srcA;  //use?
wire [3:0] E_srcB; 
wire E_bubble;
  //use?
//e
wire [1:0] e_status;
wire [3:0] e_icode;
wire [3:0] e_ifun;

wire e_cond;  //one bit?
wire signed [63:0] e_valE;
wire signed [63:0] e_valA;
wire signed [63:0] e_valB;
wire [3:0] e_destE;
wire [3:0] e_destM;
//M
wire [1:0] M_status;
wire [3:0] M_icode;
wire M_cond;
wire signed [63:0] M_valE;
wire signed [63:0] M_valA;
wire [3:0] M_destE;
wire [3:0] M_destM;
//m
wire [1:0] m_status;
wire [3:0] m_icode;
wire signed [63:0] m_valE;
wire signed [63:0] m_valM;
wire [3:0] m_destE;
wire [3:0] m_destM;
//W
wire [1:0] W_status;
wire [3:0] W_icode;
wire [63:0] W_valE;
wire signed [63:0] W_valM;
wire [3:0] W_destE;
wire [3:0] W_destM;


//control logic wire

 wire F_stall, D_stall, D_bubble,cc;


//fetch block
fetch fetch(.clk(clk),.W_valM(W_valM),.M_valA(M_valA),.M_icode(M_icode),
        .W_icode(W_icode),.M_cond(M_cond),.F_predPC(F_predPC),
        .f_icode(f_icode),.f_ifun(f_ifun),.f_rA(f_rA),.f_rB(f_rB),.f_valC(f_valC),.f_valP(f_valP),
        .f_status(f_status),.f_predicted_pc(f_predicted_pc), .F_stall(F_stall),.m_valM(m_valM),.current_pc(current_pc));

//decode register
decode_reg decode_reginst(.clk(clk),.f_status(f_status),.f_icode(f_icode),.f_ifun(f_ifun),.f_valC(f_valC),
             .f_valP(f_valP),.f_rA(f_rA),.f_rB(f_rB),.D_status(D_status),.D_icode(D_icode),
             .D_ifun(D_ifun),.D_valC(D_valC),.D_valP(D_valP),.D_rA(D_rA),.D_rB(D_rB),.D_stall(D_stall),.D_bubble(D_bubble),
             .F_predPC(F_predPC));


decode decodeinst(.clk(clk),.D_icode(D_icode), .D_ifun(D_ifun), .D_rA(D_rA),.D_rB(D_rB),.D_valP(D_valP),.e_destE(e_destE),
         .W_valE(W_valE),.e_valE(e_valE),.M_destE(M_destE),.M_valE(M_valE),.M_destM(M_destM),.m_valM(m_valM),.W_icode(W_icode),
         .D_valC(D_valC),.W_destM(W_destM),.W_valM(W_valM),.W_destE(W_destE),.D_status(D_status),
         .d_valA(d_valA),.d_valB(d_valB) ,.d_destE(d_destE),.d_destM(d_destM),.d_icode(d_icode), .d_ifun(d_ifun),.d_valC(d_valC),.d_status(d_status),.d_srcA(d_srcA),.d_srcB(d_srcB),
         .reg_mem0(reg_mem0),.reg_mem1(reg_mem1),.reg_mem2(reg_mem2),
         .reg_mem3(reg_mem3),.reg_mem4(reg_mem4),.reg_mem5(reg_mem5),
         .reg_mem6(reg_mem6),.reg_mem7(reg_mem7),.reg_mem8(reg_mem8),
         .reg_mem9(reg_mem9),.reg_mem10(reg_mem10),.reg_mem11(reg_mem11),
         .reg_mem12(reg_mem12),.reg_mem13(reg_mem13),.reg_mem14(reg_mem14));

// wire [3:0] d_ifun;
execute_reg execute_reginst(.clk(clk),.d_status(d_status),.d_icode(d_icode),.d_ifun(d_ifun),.d_valC(d_valC),.d_valA(d_valA),.d_valB(d_valB),
            .d_destE(d_destE),.d_destM(d_destM),.d_srcA(d_srcA),.d_srcB(d_srcB),.E_status(E_status),.E_icode(E_icode),
            .E_ifun(E_ifun),.E_valC(E_valC),.E_valA(E_valA),.E_valB(E_valB),.E_destE(E_destE),.E_destM(E_destM),.E_bubble(E_bubble));


// wire [3:0] e_icode;
execute executeinst(.e_ifun(e_ifun), .e_icode(e_icode), .clk(clk),.E_icode(E_icode),.E_ifun(E_ifun),.E_valA(E_valA),.E_valB(E_valB),.E_valC(E_valC),.e_valE(e_valE),.e_cond(e_cond),.E_destE(E_destE),.E_destM(E_destM),.e_destM(e_destM),.e_destE(e_destE),.e_valA(e_valA),.e_status(e_status),.E_status(E_status),.E_valE(E_valE),.zf(zf),.sf(sf),.of(of),.cc(cc));


memory_reg memory_reginst(.clk(clk),.e_status(e_status),.e_icode(e_icode),.e_cond(e_cond),.e_valE(e_valE),.e_valB(e_valB),.e_valA(e_valA),.e_destE(e_destE),
        .e_destM(e_destM),.M_icode(M_icode),.M_cond(M_cond),.M_valE(M_valE),.M_valA(M_valA),.M_destE(M_destE),
        .M_destM(M_destM),.M_status(M_status),.M_bubble(M_bubble));

// wire [63:0] m_valE;
// wire [3:0] m_icode;


memory mem(.clk(clk),.M_icode(M_icode),.M_valA(M_valA),.M_valE(M_valE),.m_valM(m_valM), .m_icode(m_icode), .m_valE(m_valE), .m_destE(m_destE), .M_destE(M_destE),.m_status(m_status),.M_status(M_status));

wb_register wb_reginst(.clk(clk),.m_status(m_status),.m_icode(m_icode),.m_valE(m_valE),.m_valM(m_valM),.m_destE(m_destE),.m_destM(M_destM),.W_stall(W_stall),
                .W_status(W_status),.W_icode(W_icode),.W_valE(W_valE),.W_valM(W_valM),.W_destE(W_destE),.W_destM(W_destM));


control_logic control_logicinst(.F_stall(F_stall),.D_stall(D_stall),.D_bubble(D_bubble),.E_bubble(E_bubble),.D_icode(D_icode),.
d_srcA(d_srcA),.d_srcB(d_srcB),.E_icode(E_icode),.E_destM(E_destM),.e_cond(e_cond),.M_icode(M_icode),.m_status(m_status),.W_status(W_status),.f_icode(f_icode),.cc(cc));

// (F_stall,D_stall,D_bubble,E_bubble,
                    // D_icode,d_srcA,d_srcB,E_icode,E_destM,e_cond,M_icode,m_status,W_status);


  always@(*) begin
    // $monitor("PC=%d,clk=%d icode=%b ifun=%b rA=%b rB=%b \n",f_pc,clk,f_icode,f_ifun,f_rA,f_rB);
    if(W_status==2'd0) begin
    // $monitor("PC=%d,clk=%d icode=%b ifun=%b rA=%b rB=%b \n",f_pc,clk,f_icode,f_ifun,f_rA,f_rB);

      $display("Halt");
      $finish;
    end
    else if(W_status==2'd1) begin
      $display("memory error");
      $finish;
    end
    else if(W_status==2'd2) begin
      
      $display("invalid instruction");

     
      $finish;
    end
    // else begin
    // $monitor("PC=%d,clk=%d icode=%b ifun=%b rA=%b rB=%b \n",f_pc,clk,f_icode,f_ifun,f_rA,f_rB);
    // end
  end
always #10clk =~clk;
always@(posedge clk) 
begin

if(!F_stall)begin
F_predPC<=f_predicted_pc;
end
  // $display("pc chosing ____=%d",F_predPC);

  
end



                        
  initial begin

      $dumpfile("final.vcd");
      $dumpvars(0,final);
     
      clk=0;
      F_predPC=64'd0;
      
      // D_stall=%d D_bubble=%d E_bubble=%d  rsp=%d W_status=%d  d_valb=%d\n",clk,F_predPC,f_predicted_pc,f_icode,f_ifun,f_rA,f_rB,f_valC, D_icode,E_icode,M_icode,F_stall,D_stall,D_bubble,E_bubble,reg_mem4,W_status,m_valM);
      //  $monitor("clk=%d f_predicted_pc=%d  F_predPC=%d     D_icode=%d E_icode=%d M_icode=%d m_valM=%d F_stall=%d
      //  f_ifun=%d rdi=%d rsi=%d \n",clk,f_predicted_pc,F_predPC,D_icode,E_icode,M_icode,m_valM,F_stall,f_ifun,reg_mem7,reg_mem4);

         $monitor("clk=%d f_predPC=%d curr_pc=%d D_icode=%d E_icode=%d M_icode=%d  m_valM=%d\n  f_stall=%d d_stall = %d d_bubble = %d \n ifun=%d rdi=%d rsi=%d reg6=%d d_stauts=%d m_status=%d zf=%d sf=%d of=%d e_vale=%d reg_mem4=%d d_valB=%d E_destM=%d d_src_A=%d d_src_B=%d\n",clk,f_predicted_pc,F_predPC,D_icode,E_icode,m_icode,m_valM,F_stall,D_stall,D_bubble,f_ifun,reg_mem7,reg_mem4,reg_mem6,D_status,m_status,zf,sf,of,e_valE,reg_mem4,d_valB,E_destM,d_srcA,d_srcB);
        //  $monitor("clk=%d f_predPC=%d F_predPC=%d D_icode=%d E_icode=%d M_icode=%d m_valM=%d f_stall=%d ifun=%d rdi=%d rsi=%d\n",clk,f_predicted_pc,F_predPC,D_icode,E_icode,M_icode,m_valM,F_stall,f_ifun,reg_mem7,reg_mem4);

  end


endmodule
           
        

// endmodule
