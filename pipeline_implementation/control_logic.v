module control_logic(F_stall,D_stall,D_bubble,E_bubble,
                    D_icode,d_srcA,d_srcB,E_icode,E_destM,e_cond,M_icode,m_status,W_status,f_icode,cc);

    input [1:0] m_status,W_status;
    input [3:0] D_icode,E_icode,M_icode;
    input [3:0] d_srcA,d_srcB,E_destM;
    input e_cond;
    input[3:0]f_icode;

    output reg F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall,cc;


    always@*
    begin
        F_stall = 0;
        D_stall = 0;
        D_bubble = 0;
        E_bubble = 0;
        M_bubble = 0;
        W_stall = 0;
        cc=1;
      
        if(E_icode==4'h7 & !e_cond)  //jump misprediction
        begin
            D_bubble = 1;
            E_bubble = 1;
        end
        else if((E_icode == 4'b0101 | E_icode == 4'b1011) & (E_destM==d_srcA | E_destM==d_srcB))  //hazard 
        begin
            F_stall = 1;
            D_stall = 1;
            E_bubble = 1;
        end
        else if(E_icode == 4'b1001 | M_icode == 4'b1001 | D_icode == 4'b1001 )// return address misprediction
        begin
            F_stall = 1;
            D_bubble = 1;
        end
        else if(E_icode == 4'b0 | m_status!=2'b11 | W_status!=2'b11)
        begin
            cc=0;
        end

    end
    endmodule