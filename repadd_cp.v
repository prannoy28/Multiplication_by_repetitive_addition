module repadd_cp(
output reg ldA,ldB,ldP,clrP,decB,done,
input eqz,start,clk,
input [15:0]din);

reg [2:0]state,i;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always@(posedge clk)
begin
	case(state)
	s0: if(start) begin state=s1; end
	s1:  state=s2;
	s2:  state=s3;
	s3:  if(eqz) state=s4;
	s4: state=s4;
	default: state=s0;
	endcase
end

always@(state)
begin
	case(state)
	s0: begin
		ldA=0; ldB=0; ldP=0; clrP=0; done=0; decB=0;
		end
	s1: begin
		#10 ldA=1; 
		end
	s2: begin
		#10 ldA=0; ldB=1; clrP=1; 
		end
	s3: begin
		#10 ldB=0; clrP=0; ldP=1; decB=1; 
		end
	s4: begin
		done=1; ldP=0; decB=0;
		end
	endcase
end

endmodule