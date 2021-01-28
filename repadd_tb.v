// Code your testbench here
// or browse Examples
module repadd_tb;
reg [15:0] din;
reg clk,start;
wire eqz,done;

repadd_dp DATA(eqz,ldA,ldB,decB,ldP,clrP,clk,din);
repadd_cp CNTR(ldA,ldB,ldP,clrP,decB,done,eqz,start,clk,din);

initial
begin
	clk=1'b0; start=1'b0;
	#10 start=1'b1; din=16'd09; #25 din=16'd07;
	#1000 $finish;
end

always #5 clk=~clk;

initial
begin
  $monitor($time," start=%b, A=%d, B=%d, P=%d, done=%b",start,DATA.A.out,DATA.B.out,DATA.outP,done);
	$dumpfile("repadd.vcd");
	$dumpvars(0,repadd_tb);
end
endmodule