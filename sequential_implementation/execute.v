`timescale 1ns / 1ps
`include "alu.v"
module execute(clk,valE,valC,icode,ifun,valA,valB,cond,overflowfinal,c_in,c_out);
input clk;
input [63:0]valA,valB,valC;
reg zf,sf,of;
output reg[63:0]valE;
output reg[2:0]c_out;
input [2:0]c_in;
input [3:0]icode,ifun;

wire signed [63:0 ]ansfinal;
reg signed [63:0]a,b;
reg [1:0] control;
output wire overflowfinal ;

 alu aluinste(
    .control(control),
    .a(a),
    .b(b),
    .ansfinal(ansfinal),
    .overflowfinal(overflowfinal)
  );
always@(*)
  
    begin
      zf=(ansfinal==1'b0);
      sf=(ansfinal<1'b0);
      of=(a<1'b0==b<1'b0)&&(ansfinal<1'b0!=a<1'b0);
    end
  


 
  initial
  begin
     a=64'b1;
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
  output reg cond;
 
  
  
  
  always@(*)
  begin
    if(clk==1)
  begin
    cond=1'd0;
    // $monitor("a=%b,b=%d control\n",icode,b,control);
    if(icode==4'b0110)//arithmatic_operation
    begin
    // $monitor("a=%d,b=%d control\n",a,b,control);
        if(ifun==4'b0000)//add
        begin
            control=2'b00;
            a=valA;
            b=valB;
            
            
            
        end
        else if(ifun==4'b0001)//sub
        begin
            control=2'b01;// check the alu method of substraction
             a=valA;
            b=valB;

        end
        else if(ifun==4'b0010)//andq
        begin 
            a=valA;
            b=valB;
            control=2'b10;
        end
        else //xorq
        begin
            a=valA;
            b=valB;
            control=2'b11;
        end
        valE=ansfinal;
        // $monitor("a=%d ,b=%dcontrol\n",a,b,control);


    end
    else if(icode==4'b0010)//cmovxx
    begin
        if(ifun==4'b0000)//rrmovq
        begin 
            cond=1'd1;

        end
        else if(ifun==4'b0001)//cmovle
        begin 
            if(zf_or_sf_xor_of)
             begin
                cond=1'd1;
            end;
        end
        else if(ifun==4'b0010)//cmovl
        begin 
            if(sf_xor_of)
            begin
                cond=1'd1;
            end;

        end
        else if(ifun==4'b0011)//cmove
        begin 
            if(zf)
            begin
                cond=1'd1;
            end;

        end
        else if(ifun==4'b0100)//cmovne
        begin 
             if(not_zf)
            begin
                cond=1'd1;
            end;

        end
        else if(ifun==4'b0101)//cmovage
        begin 
             if(not_sf_xor_of)
            begin
                cond=1'd1;
            end;
            

        end
         else if(ifun==4'b0110)//cmovg  !(sf^of)) && (!zf)
        begin 
             if(zf)
            begin
                cond=1'd1;
            end;
             if(sf_xor_of)
            begin
                cond=1'd1;
            end;
            

        end

     


    end
    else if(icode==4'b0011)
    begin
        valE=valC;
    end
    
    else if(icode==4'b1000)//call
    begin
        valE=valB-64'd8;
    end
    else if(icode==4'b1001)//ret
    begin
        valE=valB+64'd8;
    end
    else if(icode==4'b1010)
    begin
         valE=valB-64'd8;//pushq
    end
    else if(icode==4'b1011)
    begin
         valE=valB+64'd8;//popq
    end
    else if(icode==4'b0100)
    begin
         valE=valB+valC;//popq
    end
  else if(icode == 4'b0100 ||icode == 4'b0101 ) //rmmovq   or mrmovq
    begin
        a = valB;
        b = valC;
        control = 2'b00;
        valE = ansfinal;
    end
    else if(icode==4'b0111)
    begin
        if(ifun==4'b0000)   
        begin
            cond=1;
        end
        else if(ifun==4'b0001)//jle
        begin //(sf^of)|| zf
        if(sf_xor_of==1)
        begin
            cond=1'd1;
        end
        else if(zf)
        begin
            cond=1'd1;
        end
        end
        else if(ifun==4'b0010)//jl
        begin
            if(sf_xor_of)
            begin
                cond=1'd1;
            end

        end
        else if(ifun==4'b0011)//je
        begin
            if(zf)
            begin
                cond=1'd1;
            end

        end
        else if(ifun==4'b0100)//jne
        begin
            if(not_zf)
            begin
                cond=1'd1;
            end

        end
        else if(ifun==4'b0110)//jg
        begin
            if(sf_xor_of)
            begin
                if(not_zf)
                begin
                    cond=1'd1;
                end 
            end
        end
        
    
    end
  end    
    

// $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valA=%d,valB=%d,cond=%d,valP=%d,valE=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,cond,valP,ansfinal);
  end




endmodule