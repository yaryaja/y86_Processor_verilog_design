`timescale 1ns / 1ps

module not_test;
  reg signed [63:0]a;


  wire signed [63:0]ans;

  not64x1 uut(
    .a(a),
    .ans(ans)
  );

  initial begin
		$dumpfile("not_test.vcd");
    $dumpvars(0,not_test);
		a = 64'b0;
             

		#100;

    #20 a=64'b1001;
    #20 a=64'b1011;
    #20 a=-64'b1011;
    #20 a=64'd2;
    #20 a=-64'd2;
	end
	
  initial begin 
		$monitor("a=%b ans=%b\n",a,ans);
	end
endmodule