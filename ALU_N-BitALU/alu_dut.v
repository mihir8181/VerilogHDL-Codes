//-------------------------------------------------------
// N-bit ALU design under test
//--------------------------------------------------------
module alu_dut #(parameter data_width=16) 
    (
	input wire signed [data_width-1:0] A, B,  // Input
	input [1:0] control,  // Control signal 
	output [data_width-1:0] R, // Result 
	output wire ovflag,    // Overflow flag
	output wire signflag,  // Sign flag
	output wire zeroflag   // Zero flag
    );

    reg signed [data_width+data_width:0] process_reg;  // twice big reg to hold process Result R
    reg overflow_reg; //  Temp reg for overflow
    assign signflag = process_reg[data_width-1];    // Assign sign flag
    assign zeroflag = ~|process_reg[data_width-1:0];  // bitwise nor to check zero
    assign R = process_reg;    // Processed reg to output R
    assign ovflag = overflow_reg;   // aasign overflow temp reg to overflow flag 

	always@(A,B,control)
	begin
		case(control)
		2'b00:begin	// Addition of A & B when control line = 00.
			process_reg = A + B;
            if ((A[data_width-1] == 1'b0 && B[data_width-1] == 1'b0) && (process_reg[data_width-1] == 1'b1)) // check over flow for addition (+A add to +B is = - Result)
                 begin
                     overflow_reg = 1'b1;  // Set overflow flag to one
                  end
                else if ((A[data_width-1] == 1'b1 && B[data_width-1] == 1'b1) && (process_reg[data_width-1] == 1'b0)) // check over flow for addition (-A add to -B is = + Result) 
                   begin
                    overflow_reg = 1'b1;  // Set overflow flag to one
                   end   
                else 
                   begin 
                     overflow_reg = 1'b0;  // else set overflow flag to zero
                   end
		end
		2'b01:begin	// Subtraction of A & B when control line = 01.
			    process_reg = A - B;
                 if ((A[data_width-1] == 1'b0 && B[data_width-1] == 1'b1) && (process_reg[data_width-1] == 1'b1))  // check over flow at subtraction (+A subtract -B is = -Result)
                    begin
                        overflow_reg = 1'b1; // Set overflow flag to one
                    end
                    else if ((A[data_width-1] == 1'b1 && B[data_width-1] == 1'b0) && (process_reg[data_width-1] == 1'b0)) // check over flow subtraction (-A subtract +B is = + result) 
                        begin
                        overflow_reg = 1'b1; // Set overflow flag to one
                        end
                    else
                        begin 
                        overflow_reg = 1'b0; // else set overflow flag to zero
                        end   
		end
		2'b10:begin	// Bitwise And of A & B when control line = 10.
			process_reg = A & B;
		end
		2'b11:begin	// Bitwise Or of A & B when control = 11.
			process_reg = A | B;
		end 
		endcase //control
    end //always
endmodule //alu_dut
