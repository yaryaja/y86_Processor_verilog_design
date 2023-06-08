`timescale 1ns / 1ps

module pc_update(
  clk,valP,valC,updated_pc,icode,valM,cond
);
input clk,cond;
input[3:0]icode;
input [63:0] valP,valM,valC;
output reg [63:0] updated_pc;

  always@(*)
  begin
    // $display("hgjhkj=%d",icode);
    
    if(icode==4'b0111) //jump
    begin
        // $display("updated pc=%d",updated_pc);
      if(cond==1'b1)
      begin
        updated_pc=valC;
         $monitor("clk=%d  PC=%d  valp=%d valcjumpvalc=%d\n",clk,updated_pc,valP,valC);
      end
      else
      begin
        updated_pc=valP;
         $monitor("clk=%d  PC=%d  valp=%d valcjumpvalp=%d\n",clk,updated_pc,valP,valC);
      end
    end
    else if(icode==4'b1000) //call
    begin
      updated_pc=valC;
       $monitor("clk=%d  PC=%d  valp=%d valccall=%d\n",clk,updated_pc,valP,valC);
    end
    else if(icode==4'b0011) //call
    begin
      updated_pc=valP;
          $display("hgjhktfyjgkuhlijokj=%d",updated_pc);
      //  $monitor("clk=%d  PC=%d  valp=%d valccall=%d\n",clk,updated_pc,valP,valC);
    end
    else if(icode==4'b1001) //ret
    begin
      updated_pc=valM;
       $monitor("clk=%d  PC=%d  valp=%d valcreturn=%d\n",clk,updated_pc,valP,valC);
    end
    else if(icode==4'b0000) //nope
    begin
      updated_pc=valP;
       $monitor("clk=%d  PC=%d  valp=%d valcnope=%d\n",clk,updated_pc,valP,valC);
    end
    else
    begin
      updated_pc=valP;
      // $display("updated pc=%d",updated_pc);
    		 $monitor("clk=%d  PC=%d  valp=%d valcelse=%d icode=%d\n",clk,updated_pc,valP,valC,icode);
    end

  end

endmodule