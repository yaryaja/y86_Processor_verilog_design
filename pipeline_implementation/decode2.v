module decode(
    input clk,
    input [3:0]D_icode,
    input [3:0]D_ifun,
    input [3:0] D_rA,
    input [3:0] D_rB,
    input [63:0]D_valP,
    input [3:0] e_destE,
    input [63:0] W_valE,
    input [63:0]D_valC,
    input [63:0] e_valE,
    input [3:0] M_destE,
    input [63:0] M_valE,
    input [3:0] M_destM,
    input [63:0] m_valM,
    input [3:0] W_icode,
    input [3:0] W_destM,
    input [63:0] W_valM,
    input [3:0] W_destE,
    input [1:0]D_status,



    output reg [63:0] d_valA,
    output reg [63:0] d_valB,
    output reg [3:0] d_destE,
    output reg [3:0]d_destM,
    output reg [3:0] d_icode,
    output reg [3:0] d_ifun,
    output reg [63:0]d_valC,
    output reg[1:0]d_status,
    output reg[3:0] d_srcA,
    output reg[3:0] d_srcB,
    output reg[63:0]d_valP,

    output reg [63:0]reg_mem0,
  output reg [63:0] reg_mem1,
  output reg [63:0] reg_mem2,
  output reg [63:0] reg_mem3,
  output reg [63:0] reg_mem4,
  output reg [63:0] reg_mem5,
  output reg [63:0] reg_mem6,
  output reg [63:0] reg_mem7,
  output reg [63:0] reg_mem8,
  output reg [63:0] reg_mem9,
  output reg [63:0] reg_mem10,
  output reg [63:0] reg_mem11,
  output reg [63:0] reg_mem12,
  output reg [63:0] reg_mem13,
  output reg [63:0] reg_mem14
);
  reg [63:0] d_rvalA,d_rvalB;
  reg [63:0] reg_mem[0:14];

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
    reg_mem[14] = 64'd8643;     //r14

  end

  always@*
  begin

    d_srcA = 4'hF;
    d_srcB = 4'hF;
    d_destE = 4'hF;
    d_destM = 4'hF;
    // computing dest and src
    case (D_icode)
      4'h2: begin
        d_srcA = D_rA;
        d_destE = D_rB;
      end
      4'h3: begin
        d_destE = D_rB;
      end
      4'h4: begin
        d_srcA = D_rA;
        d_srcB = D_rB;
      end
      4'h5: begin
        d_srcB = D_rB;
        d_destM = D_rA;
      end
      4'h6: begin
        d_srcA = D_rA;
        d_srcB = D_rB;
        d_destE = D_rB;
      end
      4'h8:begin
        d_srcB = 4;
        d_destE = 4;
      end
      4'h9:begin
        d_srcA = 4;
        d_srcB = 4;
        d_destE = 4;
      end
      4'hA: begin
        d_srcA = D_rA;
        d_srcB = 4;
        d_destE = 4;
      end
      4'hB: begin
        d_srcA = 4;
        d_srcB = 4;
        d_destE = 4;
        d_destM = D_rA;
      end
      default: begin
        d_srcA = 4'hF;
        d_srcB = 4'hF;
        d_destE = 4'hF;
        d_destM = 4'hF;
      end
    endcase


    if(D_icode==4'b0010) //cmovq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=64'b0;
    end
    if(D_icode==4'b0011) //irmovq
        d_rvalB=64'b0;
    else if(D_icode==4'b0100) //rmmovq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[D_rB];
    end
    else if(D_icode==4'b0101) //mrmovq
    begin
        d_rvalB=reg_mem[D_rB];
    end
    else if(D_icode==4'b0110) //OPq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[D_rB];
    end
    // add jxx
    else if(D_icode==4'b1000) //call
    begin
        d_rvalB=reg_mem[4]; 
    end
    else if(D_icode==4'b1001) //ret
    begin
        d_rvalA=reg_mem[4]; 
        d_rvalB=reg_mem[4];
    end
    else if(D_icode==4'b1010) //pushq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[4];
    end
    else if(D_icode==4'b1011) //popq
    begin
        d_rvalA=reg_mem[4]; 
        d_rvalB=reg_mem[4];
    end

    // Forwarding A
    if(D_icode==4'h7 | D_icode == 4'h8) //jxx or call
      d_valA = D_valP;
    else if(d_srcA==e_destE & e_destE!=4'hF)
      d_valA = e_valE;
    else if(d_srcA==M_destM & M_destM!=4'hF)
      d_valA = m_valM;
    else if(d_srcA==W_destM & W_destM!=4'hF)
      d_valA = W_valM;
    else if(d_srcA==M_destE & M_destE!=4'hF)
      d_valA = M_valE;
    else if(d_srcA==W_destE & W_destE!=4'hF)
      d_valA = W_valE;
    else
      d_valA = d_rvalA;
    
    // Forwarding B
    if(d_srcB==e_destE & e_destE!=4'hF)      // Forwarding from execute
      d_valB = e_valE;
    else if(d_srcB==M_destM & M_destM!=4'hF) // Forwarding from memory
      d_valB = m_valM;
    else if(d_srcB==W_destM & W_destM!=4'hF) // Forwarding memory value from write back stage
      d_valB = W_valM;
    else if(d_srcB==M_destE & M_destE!=4'hF) // Forwarding execute value from memory stage
      d_valB = M_valE;
    else if(d_srcB==W_destE & W_destE!=4'hF) // Forwarding execute value from write back stage 
      d_valB = W_valE;
    else
      d_valB = d_rvalB;
   
  end

 

// writeback 
  always@(posedge clk) begin

    if(W_icode==4'b0010) //cmovxx
    begin
      reg_mem[W_destE]=W_valE;
    end
    else if(W_icode==4'b0011) //irmovq
      reg_mem[W_destE]=W_valE;

    else if(W_icode==4'b0101) //mrmovq
    begin
      reg_mem[W_destM] = W_valM;
    end
    else if(W_icode==4'b0110) //OPq
    begin
      reg_mem[W_destE] = W_valE;
    end
    else if(W_icode==4'b1000) //call
    begin
      reg_mem[W_destE] = W_valE;
    end
    else if(W_icode==4'b1001) //ret
    begin
      reg_mem[W_destE] = W_valE;
    end
    else if(W_icode==4'b1010) //pushq
    begin
      reg_mem[W_destE] = W_valE;
    end
    else if(W_icode==4'b1011) //popq
    begin
      reg_mem[W_destE] = W_valE;
      reg_mem[W_destM] = W_valM;
    end

    reg_mem0 <= reg_mem[0];
    reg_mem1 <= reg_mem[1];
    reg_mem2 <= reg_mem[2];
    reg_mem3 <= reg_mem[3];
    reg_mem4 <= reg_mem[4];
    reg_mem5 <= reg_mem[5];
    reg_mem6 <= reg_mem[6];
    reg_mem7 <= reg_mem[7];
    reg_mem8 <= reg_mem[8];
    reg_mem9 <= reg_mem[9];
    reg_mem10 <= reg_mem[10];
    reg_mem11 <= reg_mem[11];
    reg_mem12 <= reg_mem[12];
    reg_mem13 <= reg_mem[13];
    reg_mem14 <= reg_mem[14];
  end
endmodule