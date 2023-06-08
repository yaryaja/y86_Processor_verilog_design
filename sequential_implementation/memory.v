`timescale 1ns / 1ps
module memory(
  clk,valP,valM,valE,icode,valA,valB
);

  input clk;
  input[3:0]icode;
  input [63:0] valE,valP,valA,valB;
  output reg [63:0] valM;
  reg [63:0] data_mem[0:1023];
  initial
  begin
    data_mem[4]=64'd2;
    data_mem[12]=64'd3;
    
  end

  always@(*)
  begin
   
    if(icode==4'b0101) //mrmovq
    begin
      valM=data_mem[valE];
    end
   
    
   
    if(icode==4'b1001) //ret
    begin
      valM=data_mem[valA];
    end
   
    if(icode==4'b1011) //popq
    begin
      valM=data_mem[valA];
    end
    // datamem=data_mem[valE];
  end

always@(posedge clk)
  begin
    if(icode==4'b0100) //rmmovq
    begin
      data_mem[valE]=valA;
    end
    if(icode==4'b1000) //call
    begin
      data_mem[valE]=valP;
    end
   
    if(icode==4'b1010) //pushq
    begin
      data_mem[valE]=valA;
    end
 
    // datamem=data_mem[valE];
  end

    
  // initial 
		// $monitor("clk=%d  PC=%d valE=%d cond=%d\n",clk,PC,valE,cond);
    // $monitor("clk=%d  PC=%d valA=%d valB=%d valE=%d cond=%d\n",clk,PC,valA,valB,valE,cond);
  
endmodule
