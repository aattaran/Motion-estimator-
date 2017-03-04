
// Code your design here

module control (clk, Start, S1S2mux, NewDist, CompStart, PEready, VectorX, VectorY,  AddressR, AddressS1, AddressS2,completed);

input clk;
input Start; // = 1 when 'going'
output [15:0] S1S2mux;
output [15:0] NewDist;
output CompStart;
output [15:0] PEready;
output [3:0] VectorX, VectorY;
output [7:0] AddressR;
output [9:0] AddressS1, AddressS2;
output completed;
reg [15:0] S1S2mux;
reg [15:0] NewDist;
reg CompStart;
reg [15:0] PEready;
reg [3:0] VectorX, VectorY;
reg [7:0] AddressR;
reg [9:0] AddressS1, AddressS2;
reg [12:0] count;
reg completed;
integer i;


always @(posedge clk) begin
	if(Start==0) 
		count <= 13'h0;
	else if (completed==0) 
		count <= count+1'b1;
end

always@(count) begin

	for(i=0; i<16;i=i+1)
		begin
			PEready[i] <= (NewDist[i] && !(count<9'd256));
		end
end

always@(count) begin

	AddressR = count [7:0];
	AddressS1 = (count[11:8] + count[7:4])*6'd32 + count [3:0];
	//AddressS1 = (count[11:8] + count[7:4] >> 4)*5'd32 + count [3:0];
	//S1S2mux[0] = 1'b1;
	for(i = 0; i < 16; i=i+1) NewDist[i] = (count[7:0] == i);
	for(i = 0; i < 16; i=i+1) S1S2mux[i] = (count[3:0] >= i); 
	
	if(NewDist[0] != 0) AddressS2 <= AddressS2 + 5'd17; 
	else if(NewDist == 0) AddressS2 <= AddressS1 - 5'd16;
	else AddressS2 <= AddressS2 + 1'b1; 
	
	
	VectorX <= count[3:0] ;// - 4'd7;
	VectorY <= count[11:8];// - 4'd8;
	
	CompStart <= Start;
	
end

always@(count)

	completed = (count == 5'd16 * (9'd256 + 1));
	
endmodule






