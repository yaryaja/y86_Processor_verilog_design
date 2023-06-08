
module fetch_reg(input clk , input [63:0] predicted_pc, output reg [63:0]F_predPC);

initial begin
    F_predPC <= 64'd0; 
end

always @(posedge clk)
begin
    F_predPC <= predicted_pc;
    // $monitor("PC=%d ,clk=%d\n",predicted_pc,clk);
end
endmodule