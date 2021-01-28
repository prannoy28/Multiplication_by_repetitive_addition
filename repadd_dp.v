module comp(eqz,data);
input [15:0] data;
output eqz;
assign eqz = (data==16'd01)?1:0;
endmodule

module pipo1(out,in,ld,clk);
input [15:0]in;
input ld,clk;
output reg [15:0]out;
always@(posedge clk)
begin
	if(ld) out<=in;
end
endmodule

module pipo2(out,in,ld,clk,clr);
input [15:0]in;
input ld,clr,clk;
output reg [15:0]out;
always@(posedge clk)
begin
	if(clr) out<=0;
	else if(ld) out<=in;
end
endmodule

module addr(out,in1,in2);
input [15:0] in1,in2;
output reg[15:0]out;
always@(*)
begin
	out = in1+in2;
end
endmodule

module cntr(out,in,ld,dec,clk);
input [15:0]in;
input dec,ld,clk;
output [15:0] out; 
reg [15:0] count;
assign out = count;
always@(posedge clk)
begin
	if(ld) count<=in;
	else if(dec) count<=count-1;
end
endmodule

module repadd_dp(eqz,ldA,ldB,decB,ldP,clrP,clk,din);
output eqz;
input ldA,ldB,ldP,clrP,decB,clk;
input [15:0]din; 
wire [15:0]outA,out,outP,cout;

pipo1 A(outA,din,ldA,clk);
pipo2 P(outP,out,ldP,clk,clrP);
cntr B(cout,din,ldB,decB,clk);
comp u1(eqz,cout);
addr sum(out,outA,outP);

endmodule