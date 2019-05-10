`include "fifo.v"
module fifo_fixture ();

parameter datasize = 32;
parameter addrbits = 8;
parameter depth = 128;
wire [datasize-1:0] dataOut;
wire full, empty;
reg [datasize-1:0] dataIn;
reg insert, flush, clk_in, rst; 
reg remove, clk_out;
//------------------- For random vector genration ------------
integer ft; // integer used for flush time
integer rt; // integer used for reset time
integer f,r; // integer to use in for loop
integer dataIn_time, in_rm_time;
integer clk_in_period; //ns clk_in period
integer clk_out_period; //ns clk_out period 

fifo #(datasize, addrbits, depth) topuut (.dataOut(dataOut), .dataIn(dataIn),
                                          .clk_out (clk_out), .full(full),
                                          .empty(empty), .clk_in(clk_in),
                                          .insert(insert), .flush(flush), .remove(remove),
                                          .rst(rst));

initial
begin
$vcdpluson; 
end

initial
begin
rst = 1'b0;
dataIn = 32'h0;
insert = 1'b0;
remove = 1'b0;
flush = 1'b0;
dataIn_time = 2'b10; // data input time
in_rm_time = 10;  // insert remove wait time
clk_in_period = 1'b1;
clk_out_period =2'b10;

#50;  //global wait for reset
//------ corner cases---------//
rst = 1'b1;
    insert = 1'b1;      //-----\   
    #400 insert = 1'b0; //------\  To check corner cases 
    remove = 1'b1;      //------/  
    #530 remove = 1'b0; //-----/
rst=1'b0;
#2 rst=1'b1;
#10 flush=1'b1;
#2 flush=1'b0;
#400 flush=1'b1;
#200 rst=1'b0;
insert = 1'b1;
#50 insert = 1'b0;
flush=1'b1;
#2 rst=1'b1;
flush=1'b0;
end

initial
begin
    clk_in = 0;
    forever #1 clk_in = ~clk_in;
end

initial
begin
    clk_out = 0;
    forever #2 clk_out = ~clk_out;
end

initial
begin
#980;   // wait for corner cases test to finish
	forever
	 begin
		#(in_rm_time) insert={$random}%2; //Modulus to get 0 and 1 from random number 
		in_rm_time = in_rm_time + 5;
		remove = ~insert;
	 end
    end

initial
  begin
    #1;
    forever
    begin  // random number
    #(dataIn_time) dataIn=$random;
    end
  end

initial
	begin
        #980 // wait for corner cases test to finish
		for(r=1;r<3;r=r+1) // 2 times reset random logic
		begin
		rt={$random}%1000;//Modulus to get number below 1000 from random number 
		#rt rst = 1'b0;
		#5 rst = 1'b1;
		end
	end

initial
	begin
     #980 // wait for corner cases test to finish
	 for(f=1;f<5;f=f+1) // 4 times flush random logic
		begin
		ft={$random}%1500;//Modulus to get number below 1500 from random number
		#ft flush = 1'b1;
		#15 flush = 1'b0;
		end
	end

//-------------------- display wth random vectors ----------------
initial
begin
$display("\n------------- Simulation Result with Random Vectors----------- \n\n");
$monitor("%04t  rst=%b  clk_in=%b  dataIn=%h  insert=%b  clk_out=%b  remove=%b  flush=%b  dataOut=%h  empty=%b  full= %b \n----------------------\t--------------------------\t----------------------\t---------------\t------------------", 
          $time, rst, clk_in, dataIn, insert, clk_out, remove, topuut.flush, dataOut, topuut.empty, topuut.full);  
          

end

initial
begin
#3000 $finish;
end
endmodule 