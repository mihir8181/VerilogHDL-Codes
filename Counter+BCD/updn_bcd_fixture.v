`include "bin2bcd.v"
`include "up_down_counter.v"  //

module updn_bcd_fixture();
  reg clk, en, updn, rst;
  wire [3:0]value;
  wire [3:0]tens;
  wire [3:0]ones;
//instantiation
up_down_counter U1(.CLK(clk), .ENABLE(en), .UPDN(updn), .RST(rst), .VALUE(value));
bin2bcd U2(.VALUE(value), .TENS(tens), .ONES(ones));

integer i;
 
 reg [0:10] data [0:32];
 reg [0:10] data_bits_reg;
 reg data_bit_rst;
 reg data_bit_en;
 reg data_bit_updn;
 reg [0:3] data_bits_tens;
 reg [0:3] data_bits_ones;
 reg [0:2] Inputsignal;

// read file data
 initial 
 begin
 $readmemb("counter_bcd_datafile.txt",data);
 end


//------------------------------------------------
//stimulus signal
//------------------------------------------------
initial begin
clk = 0;
en = 1;
updn = 1;
rst = 1;
end


// stimulate the clock signal 
initial
begin
  forever #10 clk =~clk;
end

// finish the simulation at time
initial
begin
  #1000 $finish;
end

initial begin
	for(i=0;i<32;i=i+1)begin
		data_bits_reg =  data[i];
        #10;  //20
		data_bits_ones = data_bits_reg[7:10];
		data_bits_tens = data_bits_reg[3:6];
		data_bit_updn = data_bits_reg[2];
		data_bit_en = data_bits_reg[1];
		data_bit_rst = data_bits_reg[0];
        Inputsignal = data_bits_reg[0:2];

        rst = data_bit_rst;
        en = data_bit_en;
        updn = data_bit_updn;
        #5;  //10

case(Inputsignal)
		3'b000:begin
			#5;
			if(tens == data_bits_tens && ones == data_bits_ones)begin
				$display($time, " Output is correct when reset = 0, Enable = 0, Updn = 0");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
			else begin
				$display($time, " Output is failed when reset = 0, Enable = 0, Updn = 0");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
		end
		3'b001:begin
			#5;
			if(tens == data_bits_tens && ones == data_bits_ones)begin
				$display($time, " Output is correct when reset = 0, Enable = 0, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
			else begin
				$display($time, " Output is failed when reset = 0, Enable = 0, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
		end

		3'b010:begin
			#5;
			if(tens == data_bits_tens && ones == data_bits_ones)begin
				$display($time, " Output is correct when reset = 0, Enable = 1, Updn = 0");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
			else begin
				$display($time, " Output is failed when reset = 0, Enable = 1, Updn = 0");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
		end

		3'b011:begin
			#5;
			if(tens == data_bits_tens && ones == data_bits_ones)begin
				$display($time, " Output is correct when reset = 0, Enable = 1, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
			else begin
				$display($time, " Output is failed when reset = 0, Enable = 1, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
		end

        3'b111:begin
			#5;
			if(tens == data_bits_tens && ones == data_bits_ones)begin
				$display($time, " Output is correct when reset = 1, Enable = 1, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
			else begin
				$display($time, " Output is failed when reset = 1, Enable = 1, Updn = 1");
				$display($time, " %b %b %b %b %b %b\n",Inputsignal, rst, en, updn, tens, ones, data_bits_reg[3:6], data_bits_reg[7:10]);
			end
		end

		default:	
			$display(" Nothing");
		endcase   
  end
  end
endmodule // updn_bcd_fixture