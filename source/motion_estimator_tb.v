module motion_estimator_tb();

reg clk;
reg Start;
reg [7:0] Rmem [16*16-1:0];
reg [7:0] Smem1 [32*32-1:0];
reg [7:0] Smem2 [32*32-1:0];

wire [7:0] R, S1,S2;
wire [9:0] AddressS1, AddressS2;
wire [7:0] AddressR;
wire [3:0] motionX, motionY;
wire [7:0] BestDist;
wire completed;


assign R=Rmem[AddressR];
assign S1=Smem1[AddressS1];
assign S2=Smem2[AddressS2];

motion_estimator tm1 (clk,  Start, R, S1, S2, AddressS1, AddressS2, AddressR, motionX, motionY, BestDist, completed);

integer i;



always #10 clk=~clk;
initial $readmemh("Rmem.txt", Rmem);
initial $readmemh("Smem.txt", Smem1);
initial $readmemh("Smem.txt", Smem2);
	

  
initial begin  

	clk<=0; 
	Start<=0; 
	
	 $display("Rmem:");
        for (i=0; i < (16*16); i=i+1)
        $display("%d:%h",i,Rmem[i]);
		
	 $display("Smem1:");
        for (i=0; i < (32*32); i=i+1)
        $display("%d:%h",i,Smem1[i]);
		
	 $display("Smem2:");
        for (i=0; i < (32*32); i=i+1)
        $display("%d:%h",i,Smem2[i]);
	
	
	/** generate a random memory **/
	/*
	for(i=0;i<256;i=i+1)
	begin
		Rmem[i] = $random % 255;
		$display("Rmem[%d] %d",i,Rmem[i]);
	end
	
	for(i=0;i<1024;i=i+1)
	begin
		Smem1[i] = $random % 255;
		$display("Smem1[%d] %d",i,Smem1[i]);
	end
	
	for(i=0;i<1024;i=i+1)
	begin
		Smem2[i] = $random % 255;
		$display("Smem2[%d] %d",i,Smem2[i]);
	end
	
/** wait for clock to Start up **/

	


  	//fp1=$fopen("imnn_res.txt");
	 



 
	#100 Start<=1; 
	  
	
end




endmodule