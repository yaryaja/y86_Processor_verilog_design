`timescale 1ns/1ps
`include "alu.v"


module execute(e_ifun, e_icode, clk,E_icode,E_ifun,E_valA,E_valP,E_valB,E_valC,E_valE,e_cond,E_destE,E_destM,e_destM,e_destE,e_valA,E_status,e_status,e_valE,zf,sf,of,cc);

input clk;
input cc;
input  [3:0]E_icode;
input  [3:0]E_ifun;
input signed  [63:0]E_valA;
input signed  [63:0]E_valE;
input signed  [63:0]E_valB;
input signed [63:0]E_valC;
input signed  [63:0]E_valP;
input [3:0] E_destE;
input [3:0] E_destM;
input [1:0] E_status;
input [63:0]E_val;
output zf,sf,of;
output reg [3:0] e_destE;
output reg [3:0] e_destM;
output reg [63:0] e_valE;
output  reg e_cond;
output reg [3:0] e_icode;
output reg [3:0] e_ifun;
output reg  signed  [63:0] e_valA;
output reg signed  [63:0] e_valB;
output reg[1:0] e_status;


reg [1:0] control;
reg signed [63:0]a,b;
wire signed [63:0 ]ansfinal;
// wire signed [63:0 ]ansfinal;
wire overflowfinal;
reg zf,of,sf;



 alu aluinste(
    .control(control),
    .a(a),
    .b(b),
    .ansfinal(ansfinal),
    .overflowfinal(overflowfinal)
  );

initial
begin
 zf=1'd0;
 sf=1'd0;
 of=1'd0;
 a=64'b0;
b=64'b0;
control=2'b00;
end

  wire sf_xor_of;
  wire not_zf,not_sf,not_cf;
  wire not_sf_xor_of;
  wire zf_or_sf_xor_of;
  xor xorinst1(sf_xor_of,sf,of);
  not notinst2(not_zf,zf);
  not notinst3(not_sf,sf);
  not notinst4(not_cf,sf);
  not notinst5(not_cf,sf);
  not notinst6(not_sf_xor_of,sf_xor_of);



always @(*)
begin
    e_icode<=E_icode;
    e_ifun<=E_ifun;
    // e_valA<=E_valA;
    e_valB<=E_valB;
    e_valA<=E_valA;
   
    e_status<=E_status;
   
    
    

    if(E_icode == 4'b0110) //arithmetic operation
    begin
     if(E_ifun==4'b0000)//add
        begin
            control<=2'b00;
             a <= E_valA;
            b <= E_valB;    
        end
      else if(E_ifun==4'b0001)//sub
        begin
            control<=2'b01;// check the alu method of substraction
             a <= E_valA;
            b <= E_valB; 

        end
      else if(E_ifun==4'b0010)//andq
        begin 
             a <= E_valA;
            b <= E_valB; 
            control<=2'b10;
        end
       else //xorq
        begin
              a <= E_valA;
            b <= E_valB; 
            control<=2'b11;
        end
      e_valE<=ansfinal;
    //   $display("evale arith=%d",e_valE);
      if(cc)
      begin
      zf=(ansfinal==0);
      sf=(ansfinal<0);
      of=(a<0==b<0)&&(ansfinal<0!=a<0);
      end

    end
    else if(E_icode == 4'b0010) //cmovXX
    begin
        e_valE=E_valA;
        //   $display("evale cmov=%d",e_valE);
        if(E_ifun==4'b0000)//rrmovq
        begin 
            e_cond<=1'd1;

        end

        else if(E_ifun==4'b0001)//cmovle
        begin 
            if(zf_or_sf_xor_of)
             begin
                e_cond<=1'd1;
            end;
        end
        
        else if(E_ifun==4'b0010)//cmovl
        begin 
            if(sf_xor_of)
            begin
                e_cond<=1'd1;
            end;

        end
        
        else if(E_ifun==4'b0011)//cmove
        begin 
            if(zf)
            begin
                e_cond<=1'd1;
            end;

        end
        
        else if(E_ifun==4'b0100)//cmovne
        begin 
             if(not_zf)
            begin
                e_cond<=1'd1;
            end;

        end
        
        else if(E_ifun==4'b0101)//cmovage
        begin 
             if(not_sf_xor_of)
            begin
                e_cond<=1'd1;
            end;
            

        end
        
         else if(E_ifun==4'b0110)//cmovg  !(sf^of)) && (!zf)
        begin 
             if(zf)
            begin
                e_cond<=1'd1;
            end;
             if(sf_xor_of)
            begin
                e_cond<=1'd1;
            end;
            

        end
        
    end
    
    
    else if(E_icode == 4'b0100 ||E_icode == 4'b0101 ) //rmmovq   or mrmovq
    begin
        a <= E_valB;
        b <= E_valC;
        control <= 2'b00;
        e_valE <= ansfinal;
        //   $display("evale mrmovq=%d",e_valE);
    end

    

    else if(E_icode == 4'b0011) //irmovq   check
    begin
     
        e_valE = E_valC;
        //  $display("evale irmovq=%d",e_valE);
   
     
    end
     else if(E_icode==4'b1011)//pop
    begin
         e_valE<=E_valB+64'd8;
        //   $display("evale pop=%d",e_valE);
    end
    else if(E_icode == 4'b1001) // ret
    begin
        e_valE<=E_valB+64'd8;
        //  $display("evale ret=%d",e_valE);
    end
    else if(E_icode==4'b1000)//call
    begin
        e_valE<=E_valB-64'd8;
        //  $display("evale call=%d",e_valE);
    end
    else if(E_icode==4'b1010)
    begin
          e_valE <=E_valB-64'd8;//pushq
        //   $display("evale push=%d",e_valE);
        //  $display("enterd execute");
    end
    else if (E_icode == 4'b0111) //jxx
    begin
        if(E_ifun==4'b0000)   
        begin
            e_cond<=1'd1;
        end
        
        else if(E_ifun==4'b0001)//jle
        begin //(sf^of)|| zf
        if(sf_xor_of==1)
        begin
            e_cond<=1'd1;
        end
        else if(zf)
        begin
            e_cond=1'd1;
        end
        end
        
        if(E_ifun == 4'b0010) //jl
        begin
            if(sf^of)
            begin
                e_cond<=1'b1;
            end
        end
      
        end
        else if(E_ifun==4'b0011)//je
        begin
            if(zf)
            begin
                e_cond<=1'd1;
            end

        end
          else if(E_ifun==4'b0100)//jne
        begin
            if(not_zf)
            begin
                e_cond<=1'd1;
            end

        end
        else if(E_ifun == 4'b0101) //jge
        begin
            if(not_sf_xor_of)
            begin
                e_cond<=1'd1;
            end
        end
        else if(E_ifun==4'b0110)//jg
        begin
            if(sf_xor_of)
            begin
                if(not_zf)
                begin
                    e_cond<=1'd1;
                end 
            end
        end
        // $display("memory errorkhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh=%d",e_valE);
        
       
    end


// for e_conditional move rB=15 for e_cond not met



    
    



always@(*)
    begin
        if((E_icode == 4'd2 | E_icode==4'd7) && (!e_cond))
        begin
        
            e_destE = 4'd15;
        end
        else
        begin
            e_destE = E_destE;
            
        end
        e_destM=E_destM;
    end
endmodule
