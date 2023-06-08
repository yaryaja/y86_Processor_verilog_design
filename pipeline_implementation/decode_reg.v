module decode_reg(
    input clk,
    input [1:0] f_status,
    input [3:0] f_icode,
    input [3:0] f_ifun,
    input [63:0] f_valC,
    input [63:0] f_valP,
    input [3:0] f_rA,
    input [3:0] f_rB,
    input F_stall,
    input D_stall,
    input D_bubble,
    input  [64:1]F_predPC,
    output reg [3:0] D_icode,
    output reg [3:0] D_ifun,
    output reg [63:0] D_valC,
    output reg [63:0] D_valP,
    output reg [3:0] D_rA,
    output reg [3:0] D_rB,
    output reg[63:0]f_predicted_pc,
    output reg[1:0]D_status
);
 always@(posedge clk)
    begin

        //stalling and buubling not working
    
        

        if(D_bubble)
        begin
            D_icode <= 4'b0001;
            D_ifun <= 4'b0000;
            D_rA <= 4'b0000;
            D_rB <= 4'b0000;
            D_valC <= 64'b0;
            D_valP <= 64'b0;
            D_status <= 2'd3;
        end
        else
        begin
            // $display("updating decode");
            D_icode <= f_icode;
            D_ifun <= f_ifun;
            D_rA <= f_rA;
            D_rB <= f_rB;
            D_valC <= f_valC;
            D_valP <= f_valP;
            D_status <= f_status;
        end
    end
    endmodule
