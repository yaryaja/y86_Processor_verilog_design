
module select_pc(input [63:0]W_valM,
                input [63:0]M_valA,
                input M_cond,
                input [3:0]W_icode,
                input [3:0]M_icode,
                input [63:0]f_valP,
                input [63:0]F_predPC,
                output reg  [63:0]f_pc);


always @(*)
begin 
    if(W_icode == 4'b1001)
    begin
        f_pc <= W_valM;
    end
    else if(M_icode == 4'b0111 && M_cond == 0)// check the icode for jump
    begin 
        f_pc <= F_predPC;   
    end
    else
    begin
        f_pc <= F_predPC;
    end

end
endmodule