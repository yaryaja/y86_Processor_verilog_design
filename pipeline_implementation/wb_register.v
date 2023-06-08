module wb_register(
    input clk,
    input [1:0] m_status,
    input [3:0] m_icode,
    input [63:0] m_valE,
    input [63:0] m_valM,
    input [3:0] m_destE,
    input [3:0] m_destM,
    input W_stall,


    output reg [3:0] W_icode,
    output reg [63:0] W_valE,
    output reg [63:0] W_valM,
    output reg [3:0] W_destE,
    output reg [3:0] W_destM,
    output reg [1:0] W_status

);
 always@(posedge clk)
    begin
        if(W_stall)
        begin
        end
        else
        begin
            W_status <= m_status;
            W_icode <= m_icode;
            W_valE <= m_valE;
            W_valM <= m_valM;
            W_destE <= m_destE;
            W_destM <= m_destM;
        end
    end
endmodule