
module predict_pc(input [63:0]f_valP,
                  input [63:0]f_valC,
                  input [3:0]f_icode,
                  output reg [63:0]predicted_pc);

                

   
always @(*)       
begin
    
    if(f_icode == 4'b0111 || f_icode == 4'b1000)
    begin
        predicted_pc <= f_valC;
    end
    else
    begin
        predicted_pc <= f_valP;
    end
end

endmodule
