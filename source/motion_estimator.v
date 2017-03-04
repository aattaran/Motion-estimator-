module motion_estimator  (clk,  Start, R, S1, S2, AddressS1, AddressS2, AddressR, motionX, motionY, BestDist, completed);

input clk;
input Start; 
input [7:0]  R, S1,S2;
output [9:0] AddressS1, AddressS2;
output [7:0] AddressR;
output [3:0] motionX, motionY;
output [7:0] BestDist;


output completed;


/** wires **/
wire [9:0] AddressS1, AddressS2;
wire [7:0] AddressR;
wire [7:0] R, S1, S2;
wire [15:0] S1S2mux; 
wire [15:0] NewDist;
wire CompStart;
wire [15:0] PEready;
wire [3:0] VectorX,VectorY;
wire [8*16-1:0] PEout;
wire [7:0] BestDist;
wire [3:0] motionX, motionY;
wire Start;//

wire clk_divide_by2;
//Accumulates....
//wire [7:0] Accumulate1,Accumulate2,Accumulate3,Accumulate4,Accumulate5,Accumulate6,Accumulate7,Accumulate8,Accumulate9,Accumulate10,Accumulate11,Accumulate12,Accumulate13,Accumulate14,Accumulate15,Accumulate16;

//Rpipes wires.... 
wire [7:0] Rpipe1,Rpipe2,Rpipe3,Rpipe4,Rpipe5,Rpipe6,Rpipe7,Rpipe8,Rpipe9,Rpipe10,Rpipe11,Rpipe12,Rpipe13,Rpipe14,Rpipe15,Rpipe0;

wire [7:0] Rpipe,Accumulate;

//PE u[7:0] (.clk(clk), .R(R[7:0]), .S1(S1[7:0]), .S2(S2[7:0]), .S1S2mux(S1S2mux[7:0]), .NewDist(NewDist[7:0]), .Accumulate(PEout[7:0]), .Rpipe(Rpipe[7:0]));
//PEs (clk, R, S1, S2, S1S2mux, NewDist, Accumulate, Rpipe);


PE u0(.clk(clk), .R(R), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[0]), .NewDist(NewDist[0]), .Accumulate(PEout[7:0]), .Rpipe(Rpipe0));
PE u1(.clk(clk), .R((Rpipe0)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[1]), .NewDist(NewDist[1]), .Accumulate(PEout[15:8]), .Rpipe(Rpipe1));
PE u2(.clk(clk), .R((Rpipe1)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[2]), .NewDist(NewDist[2]), .Accumulate(PEout[23:16]), .Rpipe(Rpipe2));
PE u3(.clk(clk), .R((Rpipe2)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[3]), .NewDist(NewDist[3]), .Accumulate(PEout[31:24]), .Rpipe(Rpipe3));
PE u4(.clk(clk), .R((Rpipe3)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[4]), .NewDist(NewDist[4]), .Accumulate(PEout[39:32]), .Rpipe(Rpipe4));
PE u5(.clk(clk), .R((Rpipe4)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[5]), .NewDist(NewDist[5]), .Accumulate(PEout[47:40]), .Rpipe(Rpipe5));
PE u6(.clk(clk), .R((Rpipe5)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[6]), .NewDist(NewDist[6]), .Accumulate(PEout[55:48]), .Rpipe(Rpipe6));
PE u7(.clk(clk), .R((Rpipe6)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[7]), .NewDist(NewDist[7]), .Accumulate(PEout[63:56]), .Rpipe(Rpipe7));
PE u8(.clk(clk), .R((Rpipe7)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[8]), .NewDist(NewDist[8]), .Accumulate(PEout[71:64]), .Rpipe(Rpipe8));
PE u9(.clk(clk), .R((Rpipe8)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[9]), .NewDist(NewDist[9]), .Accumulate(PEout[79:72]), .Rpipe(Rpipe9));
PE u10(.clk(clk), .R((Rpipe9)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[10]), .NewDist(NewDist[10]), .Accumulate(PEout[87:80]),
.Rpipe(Rpipe10));
PE u11(.clk(clk), .R((Rpipe10)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[11]), .NewDist(NewDist[11]), .Accumulate(PEout[95:88]),
.Rpipe(Rpipe11));
PE u12(.clk(clk), .R((Rpipe11)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[12]), .NewDist(NewDist[12]), .Accumulate(PEout[103:96]),
.Rpipe(Rpipe12));
PE u13(.clk(clk), .R((Rpipe12)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[13]), .NewDist(NewDist[13]), .Accumulate(PEout[111:104]),
.Rpipe(Rpipe13));
PE u14(.clk(clk), .R((Rpipe13)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[14]), .NewDist(NewDist[14]), .Accumulate(PEout[119:112]),
.Rpipe(Rpipe14));
PE u15(.clk(clk), .R((Rpipe14)), .S1(S1), .S2(S2), .S1S2mux(S1S2mux[15]), .NewDist(NewDist[15]), .Accumulate(PEout[127:120]),
.Rpipe(Rpipe15));




// Comparator (clk, CompStart, PEout, PEready, VectorX, VectorY, BestDist, motionX, motionY);
comparator u21(.clk(clk), .CompStart(CompStart), .PEout(PEout), .PEready(PEready), .VectorX(VectorX), .VectorY(VectorY),
.BestDist(BestDist), .motionX(motionX), .motionY(motionY));//, .NewDist(NewDist));


//Control (clk, Start, S1S2mux, NewDist, CompStart, PEready, VectorX, VectorY,  AddressR, AddressS1, AddressS2,completed);
control u22(.clk(clk), .Start(Start), .S1S2mux(S1S2mux), .NewDist(NewDist), .CompStart(CompStart), .PEready(PEready),
.VectorX(VectorX), .VectorY(VectorY), .AddressR(AddressR), .AddressS1(AddressS1), .AddressS2(AddressS2), .completed(completed));






endmodule
