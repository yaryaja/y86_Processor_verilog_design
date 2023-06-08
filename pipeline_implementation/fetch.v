
`timescale 1ns/1ps
module fetch(clk,W_valM,M_valA,M_cond,M_icode,W_icode,F_predPC, f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_status,f_predicted_pc, F_stall,m_valM,current_pc);

input clk;

input [63:0]W_valM;
input [63:0]m_valM;


input [63:0]M_valA;
input [3:0]M_icode;
input [3:0]W_icode;
input M_cond;
input [63:0]F_predPC;
input F_stall;


output reg [3:0] f_icode;
output reg [3:0] f_ifun;
output reg [3:0] f_rA;
output reg [3:0] f_rB;
output reg [63:0] f_valC;
output reg [63:0] f_valP;
reg instr_valid=1;
reg imem_error=0;
reg hlt;
output reg [1:0]f_status;
output reg[63:0]f_predicted_pc;
output reg[63:0]current_pc;

// wire [63:0]predicted_PC;
reg [7:0]instr_mem[1023:0];



// select_pc get_pc(.W_valM(W_valM),.M_valA(M_valA),.M_cond(M_cond),.W_icode(W_icode),.M_icode(M_icode),.f_valP(f_valP),.F_predPC(F_predPC),.pc(pc));
// predict_pc new_pc(.f_valP(f_valP),.f_valC(f_valC),.pc(pc),.f_icode(f_icode),.predicted_pc(predicted_PC));


   initial begin

    instr_mem[0]=8'h30; //3 0
    instr_mem[1]=8'hF4; //F rB=0
    instr_mem[2]=8'h00;           
    instr_mem[3]=8'h00;           
    instr_mem[4]=8'h00;           
    instr_mem[5]=8'h00;           
    instr_mem[6]=8'h0;           
    instr_mem[7]=8'h00;           
    instr_mem[8]=8'h03;          
    instr_mem[9]=8'hff; //V=1023

// call main
    instr_mem[10]=8'h80; //8 0
    instr_mem[11]=8'h00;
    instr_mem[12]=8'h00;
    instr_mem[13]=8'h00;
    instr_mem[14]=8'h00;
    instr_mem[15]=8'h00;
    instr_mem[16]=8'h00;
    instr_mem[17]=8'h00;
    instr_mem[18]=8'h14;

// halt
    instr_mem[19]=8'h00; //0 0
// irmovq $0x10 %rdi
    instr_mem[20]=8'h30; //3 0
    instr_mem[21]=8'hF7; //F rB=7
    instr_mem[22]=8'h00;           
    instr_mem[23]=8'h00;           
    instr_mem[24]=8'h00;           
    instr_mem[25]=8'h00;           
    instr_mem[26]=8'h00;           
    instr_mem[27]=8'h00;           
    instr_mem[28]=8'h00;          
    instr_mem[29]=8'h10; //V=16
// irmovq $0xc %rsi
    instr_mem[30]=8'h30; //3 0
    instr_mem[31]=8'hF6; //F rB=6
    instr_mem[32]=8'h00;           
    instr_mem[33]=8'h00;           
    instr_mem[34]=8'h00;           
    instr_mem[35]=8'h00;           
    instr_mem[36]=8'h00;           
    instr_mem[37]=8'h00;           
    instr_mem[38]=8'h00;          
    instr_mem[39]=8'h0c; //V=12
// call gcd
    instr_mem[40]=8'h80; // 8 0
    instr_mem[41]=8'h00;
    instr_mem[42]=8'h00;
    instr_mem[43]=8'h00;
    instr_mem[44]=8'h00;
    instr_mem[45]=8'h00;
    instr_mem[46]=8'h00;
    instr_mem[47]=8'h00;
    instr_mem[48]=8'h32;
// ret
    instr_mem[49]=8'h00; // halt


// pushq
instr_mem[50]=8'hA0; //3 0
instr_mem[51]=8'h7f; //F rB=0

// pushq
instr_mem[52]=8'hA0;           
instr_mem[53]=8'h6F;       

// popq
instr_mem[54]=8'hB0;           
instr_mem[55]=8'h7f;           
instr_mem[56]=8'hB0;           
instr_mem[57]=8'h6f;           


// ret
instr_mem[58]=8'h90; // 9 0
end
reg [63:0]pc;

//    initial begin
//     instr_mem[0]=8'h40; //3 0
//     instr_mem[1]=8'h34; //F rB=0
//     instr_mem[2]=8'h00;           
//     instr_mem[3]=8'h00;           
//     instr_mem[4]=8'h00;           
//     instr_mem[5]=8'h00;           
//     instr_mem[6]=8'h0;           
//     instr_mem[7]=8'h00;           
//     instr_mem[8]=8'h00;          
//     instr_mem[9]=8'hf1; //V=1023

// // call main
//     instr_mem[10]=8'h10; //8 0
//     instr_mem[11]=8'h10;
//     instr_mem[12]=8'h10;
//     instr_mem[13]=8'h10;

//     instr_mem[14]=8'h50;
//     instr_mem[15]=8'h34;
//      instr_mem[16]=8'h00;           
//     instr_mem[17]=8'h00;           
//     instr_mem[18]=8'h00;           
//     instr_mem[19]=8'h00;           
//     instr_mem[20]=8'h0;           
//     instr_mem[21]=8'h00;           
//     instr_mem[22]=8'h00;          
//     instr_mem[23]=8'hf1; //V



           
//     instr_mem[24]=8'h60;           
//     instr_mem[25]=8'h31;           
//     instr_mem[26]=8'h10;  
    
             
//     instr_mem[27]=8'h00;           
//     instr_mem[28]=8'h33;           
          
//     instr_mem[29]=8'h73;          
//     instr_mem[30]=8'h00; //3 0
//     instr_mem[31]=8'h00; //F rB=6
//     instr_mem[32]=8'h00;           
//     instr_mem[33]=8'h00;           
//     instr_mem[34]=8'h00;           
//     instr_mem[35]=8'h00;           
//     instr_mem[36]=8'h00;           
//     instr_mem[37]=8'd39; 

//     instr_mem[38]=8'h00; 

//     instr_mem[39]=8'hA0; //V=12
// // call gcd
//     instr_mem[40]=8'h3F; // 8 0


//     instr_mem[41]=8'hB0;
//     instr_mem[42]=8'h3F;

  

// // pushq
// instr_mem[50]=8'hA0; //3 0
// instr_mem[51]=8'h7f; //F rB=0

// // pushq
// instr_mem[52]=8'hA0;           
// instr_mem[53]=8'h6F;       

// // popq
// instr_mem[54]=8'hB0;           
// instr_mem[55]=8'h7f;           
// instr_mem[56]=8'hB0;           
// instr_mem[57]=8'h6f;           


// // ret
// instr_mem[58]=8'h90; // 9 0
// end








initial
begin
    pc = F_predPC;
   
end

//selecting PC

always @(*)
begin 
    if(W_icode == 4'b1001)
    begin
        pc = m_valM;
       
        
        // $display("pc chosing=%d",pc);
    end
    else if(M_icode == 4'b0111 && M_cond == 0)// check the icode for jump
    begin 
        pc = M_valA;   
    end
    else
    begin
        pc = F_predPC;
    end
     current_pc=pc;
    //  $display("pc1 chosing=%d clk=%d",pc,clk);
end


// pc prediction for next instruction
  
   
always @(*)       
begin
   
     if(f_icode == 4'b0111 || f_icode == 4'b1000)
    begin
        f_predicted_pc = f_valC;
    end
    else if(f_icode!=4'd9)
    begin
        f_predicted_pc = f_valP;
    end
end
// always @(posedge clk) 
// begin
//    if(F_stall)
//         begin
//             // pc <= F_predPC;
//         end
// end




always @(*)
begin
   
    hlt = 1'b0;
   
    if(pc > 1023)
    begin    
        imem_error = 1'b1;
       
    end
     instr_valid = 1'b1;
    f_icode = instr_mem[pc][7:4];
    f_ifun  = instr_mem[pc][3:0];
      $display(" icode calculated =%d",f_icode);
    
    // $display("pc for current instrution=%d clk=%d",pc,clk);
       
    if(f_icode==4'b0000) //halt
    begin
        // $display("halting and halting");
      hlt=1;
      f_valP= pc;
       
    end
    
    else if(f_icode == 4'b0001) //nop
    begin
        f_valP = pc + 64'd1;
    end    
    
    else if(f_icode == 4'b0010) //cmovXX
    begin
        f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
        f_valP= pc + 64'd2;
    end    
    
    else if(f_icode == 4'b0011) //irmovq
    begin
       f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
      f_valC={
        instr_mem[pc+2], instr_mem[pc+3], instr_mem[pc+4], 
        instr_mem[pc+5], instr_mem[pc+6],
         instr_mem[pc+7], instr_mem[pc+8], instr_mem[pc+9]};
       f_valP = pc + 64'd10;
    end    
    
    else if(f_icode == 4'b0100) //rmmovq
    begin
        f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
      f_valC={
        instr_mem[pc+2], instr_mem[pc+3], instr_mem[pc+4], 
        instr_mem[pc+5], instr_mem[pc+6],
         instr_mem[pc+7], instr_mem[pc+8], instr_mem[pc+9]};
       f_valP = pc + 64'd10;
    end    
    
    else if(f_icode == 4'b0101) //mrmovq
    begin
      f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
      f_valC={
        instr_mem[pc+2], instr_mem[pc+3], instr_mem[pc+4], 
        instr_mem[pc+5], instr_mem[pc+6],
         instr_mem[pc+7], instr_mem[pc+8], instr_mem[pc+9]};
       f_valP = pc + 64'd10;
    end    
    
    else if(f_icode == 4'b0110) //Opq
    begin
        f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
        f_valP= pc + 64'd2;
    end    
    
    else if(f_icode == 4'b0111) //jXX
    begin
           f_valC={
        instr_mem[pc+1], instr_mem[pc+2], instr_mem[pc+3], 
        instr_mem[pc+4], instr_mem[pc+5],
         instr_mem[pc+6], instr_mem[pc+7], instr_mem[pc+8]};
        f_valP = pc + 64'd9;
        $display("valc=%d",f_valC);
    end    
    
    else if(f_icode == 4'b1000) //call
    begin
        f_valC={
        instr_mem[pc+1], instr_mem[pc+2], instr_mem[pc+3], 
        instr_mem[pc+4], instr_mem[pc+5],
         instr_mem[pc+6], instr_mem[pc+7], instr_mem[pc+8]};
        f_valP = pc + 64'd9;
    end    
    
    else if(f_icode == 4'b1001) //ret
    begin
        f_valP = pc + 64'd1;
        f_rA=4'b0100;
        f_rB=4'b0100;
    end    
    
    else if(f_icode == 4'b1010) //pushq
    begin
       f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];
        f_valP = pc + 64'd2;
        // $display("enterd fetch");
        
    end    
    
    else if(f_icode == 4'b1011) //popq    
    begin
          f_rA=instr_mem[pc+1][7:4];
      f_rB=instr_mem[pc+1][3:0];

        f_valP = pc + 64'd2;
    end    
    
    else
    begin
        instr_valid = 1'b0;
        $display("icode=%d",f_icode);
    end
    

end   

always @(*) begin

        if (imem_error == 1) 
        begin
            f_status = 2'd1;
        end 
        else if (instr_valid == 1'd0) 
        begin
            f_status = 2'd2;
        end
        else if (hlt == 1'd1) 
        begin
            f_status = 2'd0;
        end
        else 
        begin
            f_status = 2'd3;
        end
        
    end

endmodule 

