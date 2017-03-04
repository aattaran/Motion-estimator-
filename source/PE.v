
module PE (clk, R, S1, S2, S1S2mux, NewDist, Accumulate, Rpipe);
input clk;
input [7:0] R, S1, S2;//memory inputs
input S1S2mux, NewDist;//control inputs
output [7:0] Accumulate, Rpipe;
reg [7:0] Accumulate, AccumulateIn, difference, Rpipe;
reg Carry;

wire [7:0] SelS;
assign SelS = S1S2mux ? S1 : S2;

always @(posedge clk) begin
	Rpipe <=R;
	Accumulate <= AccumulateIn;
end

always@(R or SelS or NewDist or Accumulate) begin //capture behavior of logic

	if(R < SelS) difference = SelS - R; //absolute subtraction
	else difference = R - SelS;
	{Carry, AccumulateIn} = Accumulate + difference;
	if(Carry == 1) AccumulateIn = 8'hFF; // saturate AccumulateIn
	if(NewDist == 1) AccumulateIn = difference;//starting new Distortion calculation
	
end
endmodule




