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
reg[63:0]reg_mem[15:0];

reg [63:0] dvalA;
reg [63:0] dvalB;
reg [63:0] B;



wire [63:0]temp_valA;
initial begin
 reg_mem[0] = 2;
      reg_mem[1] = 1;
      reg_mem[2] = 2;
      reg_mem[3] = 5;
      reg_mem[4] = 5;
      reg_mem[5] = 5;
      reg_mem[6] = 6;
      reg_mem[7] = 7;
      reg_mem[8] = 8;
      reg_mem[9] = 9;
      reg_mem[10] = 10;
      reg_mem[11] = 11;
      reg_mem[12] = 12;
      reg_mem[13] = 13;
      reg_mem[14] = 14;
      reg_mem[15] = 14;


  end
always @(*)
begin
    //   //$display("enterd decode stage");
    // //$display("vala=%d valb=%d",dvalA,dvalB);
    d_status=D_status;
    // //$display("  =%D",D_status);
    d_valC = D_valC;
    
    d_icode = D_icode;
    d_ifun = D_ifun;
    d_valP=D_valP;
    if(D_icode == 4'b0010) //cmovxx
    begin
        dvalA = reg_mem[D_rA];
        dvalB = 64'd0;
        d_srcA = D_rA;
        d_srcB = D_rB;
        //   //$display("enterd cmov");
    end
    
    
    
    else if(D_icode == 4'b0100) //rmmovq
    begin
        dvalA = reg_mem[D_rA];
        dvalB = reg_mem[D_rB];
        d_srcA = D_rA;
        d_srcB = D_rB;
          //$display("enterd rmmov");
    end
    else if(D_icode == 4'b0011) //irmmovq
    begin
        
        dvalB = 64'd0;
     
    end
    else if(D_icode == 4'b0101) //mrmovq
    begin
        //  dvalA = reg_mem[D_rA];
        dvalB = reg_mem[D_rB];
         d_srcA = D_rA;
        d_srcB = D_rB;
          //$display("enterd mrmov");
    end
    else if(D_icode == 4'b0110) //Opq
    begin
        dvalA = reg_mem[D_rA];
        dvalB = reg_mem[D_rB];
         d_srcA = D_rA;
        d_srcB = D_rB;
          //$display("enterd opq");
    end
    else if(D_icode == 4'b1000) //call
    begin
        
        //  dvalA = reg_mem[D_rA];
        dvalB = reg_mem[4]; //accesing stack register
         
        
        d_srcB =4'd4;;
        // //$display("enterd call=%d",dvalA);
         
    end
    else if(D_icode == 4'b1001) //ret
    begin
        dvalA = reg_mem[4];
        dvalB = reg_mem[4];
        d_srcA = 4'd4;;
        d_srcB = 4'd4;;//rsp
        d_destE=4'd4;;
        //$display("enterd return=%d",dvalA);
    end
    else if(D_icode == 4'b1010) //pushq
    begin
        dvalA = reg_mem[D_rA];
        dvalB = reg_mem[4'd4];

        //  $display("dvalb push=%d D_icode =%d reg_mem4=%d",dvalB,D_icode,reg_mem[4'd4]);
         
        d_srcA = 4'd4;
        //  //$display("enterd push=%d",dvalA);
    end
    else if(D_icode == 4'b1011) //popq
    begin
         dvalA= reg_mem[4'd4];
        dvalB= reg_mem[4'd4];
        //  $display("dvalb pop=%d D_icode=%d",d_valB,D_icode);
         d_srcA= 4'd4;
        d_srcB= 4'd4; //rsp
        //   //$display("enterd pop=%d",dvalA);
        

    end
    // //$display("enterd decode stage dvalA calculated=%d",dvalA);

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
    // reg_mem15=reg_mem[15];


end
    
always@(*)  
begin
    if(D_icode == 4'b0010) 
    begin
        d_destE = D_rB;
    end
    else if(D_icode == 4'b0011 ) 
    begin
        d_destE = D_rB;
    end
    // else if(D_icode == 4'b0100 ) 
    // begin
    //     d_destE = D_rB;

    // end
    else if(D_icode == 4'b0110 ) 
    begin
        d_destE = D_rB;
    end
    else if(D_icode == 4'b0101)
    begin
        d_destM = D_rA;
    end
    else if(D_icode == 4'b0110 )
    begin
        d_destE = D_rB;
    end
    else if( D_icode == 4'b1000)
    begin
        d_destE = 4'd4;
    end
    else if( D_icode == 4'b1001)
    begin
        d_destE = 4'd4;
    end
    else if(D_icode == 4'b1011)
    begin
        d_destE = 4'd4;
        d_destM = D_rA;
    end
    else if(D_icode == 4'b1010)
    begin
        d_destE = 4'd4;
    end
  
    else
    begin
        d_srcA=4'd15;
        d_srcB=4'd15;
        d_destE=4'd15;
        d_destM=4'd15;
    end

end

// forwarding logic
always @(*)
begin
    if(D_icode == 4'b1000 || D_icode == 4'b0111)
    begin
        d_valA = D_valP;
    end
    else if (d_srcA == e_destE & e_destE!=4'd15)
    begin
        d_valA = e_valE;
    end
    else if (d_srcA == M_destM &M_destM!=4'd15)
    begin
        dvalA = m_valM;
    end
    else if (d_srcA == W_destM &W_destM!=4'd15)
    begin
        d_valA = W_valM;
    end
     else if (d_srcA == M_destE &M_destE!=4'd15)
    begin
        d_valA = M_valE;
    end
    
    else if (d_srcA == W_destE &W_destE!=4'd15)
    begin
        d_valA = W_valE;
    end
   
    else
    begin
        d_valA = dvalA;
    end
end


always @(*)
begin
// $display("D_valp=%d D_icode=%d d_ifun=%d dvalA=%d dvalB=%d",D_valp,D_icode,D_ifun,dvalA,dvalB);

    if (d_srcB == e_destE & e_destE!=4'd15)
    begin
        d_valB = e_valE;
    end
     else if (d_srcB == M_destE & M_destE!=4'd15)
    begin
        d_valB = m_valM;
    end
     else if (d_srcB == W_destE & W_destE!=4'd15)
    begin
        d_valB = W_valE;
    end
    else if (d_srcB == M_destM & M_destM!=4'd15)
    begin
        d_valB = M_valE;
    end
   
    else if (d_srcB == W_destM  &W_destM!=4'd15)
    begin
        d_valB = W_valM;
    end
   
    else
    begin
        d_valB = dvalB;
    end
end

//writeback is merged with the decode stage
always @(posedge clk)  // check the edge here i m not sure
begin

// reg_mem[W_destE] = W_valE;
// reg_mem[W_destM] = W_valM;

if(W_icode==4'b0010) //cmovxx
    begin
      reg_mem[W_destE]=W_valE;
    end
    else if(W_icode==4'b0011) //irmovq
    begin
      reg_mem[W_destE]=W_valE;
    //  $display("writeback for irmovq=%d",W_valE);
    end
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
  //updating the register memory  



 reg_mem0<=reg_mem[0];
    reg_mem1<=reg_mem[1];
    reg_mem2<=reg_mem[2];
    reg_mem3<=reg_mem[3];
    reg_mem4<=reg_mem[4];
    reg_mem5<=reg_mem[5];
    reg_mem6<=reg_mem[6];
    reg_mem7<=reg_mem[7];
    reg_mem8<=reg_mem[8];
    reg_mem9<=reg_mem[9];
    reg_mem10<=reg_mem[10];
    reg_mem11<=reg_mem[11];
    reg_mem12<=reg_mem[12];
    reg_mem13<=reg_mem[13];
    reg_mem14<=reg_mem[14];
end


endmodule