module comparator (clk, CompStart, PEout, PEready, VectorX, VectorY, BestDist, motionX, motionY);

  input clk;
  input CompStart; //goes high when distortion calculation Starts
  input [8*16-1:0] PEout; // outputs of pes are one long vector
  input [15:0] PEready; //goes high when pe has a new distortion
  input [3:0] VectorX, VectorY; //motion vector being evaluated
  output [7:0] BestDist; //best distortion vector so far
  output [3:0] motionX, motionY; //best motion vector so far
  reg [7:0] BestDist, NewDist;
  reg [3:0] motionX,motionY;
  reg NewBest;
 

always @(posedge clk)
  
        if (CompStart == 0) BestDist <= 8'hFF; //initialize to highest value
        else if (NewBest == 1)
          begin
           BestDist <= NewDist;
           motionX <= VectorX;
           motionY <= VectorY;
        end
      
    
	
always @(posedge clk)
	begin
      casex(PEready)
      16'b0000000000000001: NewDist = PEout [8*1-1:8*0];
		  16'b0000000000000010: NewDist = PEout [8*2-1:8*1];
		  16'b0000000000000100: NewDist = PEout [8*3-1:8*2];
		  16'b0000000000001000: NewDist = PEout [8*4-1:8*3];
		  16'b0000000000010000: NewDist = PEout [8*5-1:8*4];
		  16'b0000000000100000: NewDist = PEout [8*6-1:8*5];
		  16'b0000000001000000: NewDist = PEout [8*7-1:8*6];
		  16'b0000000010000000: NewDist = PEout [8*8-1:8*7];
		  16'b0000000100000000: NewDist = PEout [8*9-1:8*8];
		  16'b0000001000000000: NewDist = PEout [8*10-1:8*9];
		  16'b0000010000000000: NewDist = PEout [8*11-1:8*10];
		  16'b0000100000000000: NewDist = PEout [8*12-1:8*11];
		  16'b0001000000000000: NewDist = PEout [8*13-1:8*12];
		  16'b0010000000000000: NewDist = PEout [8*14-1:8*13];
		  16'b0100000000000000: NewDist = PEout [8*15-1:8*14];
		  16'b1000000000000000: NewDist = PEout [8*16-1:8*15];
		  default: NewDist =  PEout[8*1-1:8*0];
        endcase
        
end      
   
always @(PEready or CompStart or NewDist or BestDist)   begin
        if ((|PEready == 0) || (CompStart == 0)) NewBest = 0; //no pe is ready
           else if (NewDist < BestDist) NewBest = 1;
            else NewBest = 0;
  end
        

endmodule




