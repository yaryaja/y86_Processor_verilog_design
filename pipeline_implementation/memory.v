module memory(M_destE,M_status,m_status, clk, M_icode, M_valA, M_valE, m_valM, m_icode, m_valE, m_destE);

input clk;
input [3:0]M_icode;
input signed [63:0] M_valA;
input signed [63:0] M_valE;
input [63:0] M_valP;
input [3:0] M_destE;
input [1:0] M_status;

output reg signed  [63:0] m_valM;
output reg signed  [63:0] m_valE;
output  reg [3:0] m_icode;
output reg [3:0] m_destE;
output reg[1:0] m_status;
  reg [63:0] data_mem[0:1023]; 
reg m_error;
always @(*)
begin
     if(m_error)
            m_status = 2'd1;
        else
            m_status = M_status;
end
reg check1;
reg check2;
always@(*)

begin
    m_valE <= M_valE;
    m_icode <= M_icode;
    m_destE <= M_destE;
     if(M_icode==4'h4 | M_icode==4'h5 | M_icode==4'h8 | M_icode==4'hB)
            check1 = 1;
        else
            check1 = 0;
     if(M_icode==4'h9 | M_icode==4'hB)
            check2 = 1;
        else
            check2 = 0; 
end
always@(*)
begin    

    if((M_valE>1023 & check1) | (M_valA>1023 & check2))
    begin
        
            m_error=1;
    end
  
     if(M_icode == 4'b0101 ) //mrmovq
    begin
        m_valM = data_mem[M_valE];
        
    end
  
    else if(M_icode == 4'b1001 | M_icode == 4'b1011 ) //ret pop
    begin 
        m_valM = data_mem[M_valA];
        // $display("memory errorkhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh=%d",M_valA);
        // $display("here is mvalA is calculated =%d",M_valA);

        
    end
end
always@(posedge clk)
begin
     if((M_valE>1023 & check1) | (M_valA>1023 & check2))
    begin
        
            m_error=1;
             
    end
    
     if(M_icode == 4'b0100 |M_icode == 4'b1000 |M_icode == 4'b1010) //rmmovq call pushq
    begin
        data_mem[M_valE] <= M_valA;  
        // $display("memory updated=%d",M_valA);
    end
   

end
// initial 
		// $monitor("clk=%d  PC=%d valE=%d cond=%d\n",clk,PC,valE,cond);
    // $monitor("clk=%d  PC=%d valA=%d valB=%d valE=%d cond=%d\n",clk,PC,valA,valB,valE,cond);p

endmodule