// 4-bitS ALU

module alu4 (
input [3:0] alusel,

input [3:0] aluin_a, 		// Input A 4-bits
input [3:0] aluin_b, 		// Input B 4-bits,
input Cin,					// Cin
 
output reg nf,             // The negative flag, nf, is 1 if the sign bit y(3) is 1
output reg zf,					// The zero flag, zf, is 1 if the output y is "0000".  
output reg cf,					// The carry flag
output reg ovf,				// The overflow flag
output reg Cout,				// The Carry-out flag
output reg [3:0] y,			// ALU Output
output [15:0] LED
);
 
reg [4:0] temp;				// Temperory Storage
wire [19:0] aluin_a_rotate;

always @(*)
	begin
	cf = 0;						// Initialize carry flag
	ovf = 0;					// Initialize OVERFLOW
	Cout = 1'b0;				// Initialize Cout Output to Zero
	temp = 5'b00000; 			// Initialize Temperory Storage

// See Lab 2 Lecture presentation for the ALU controls
	
	case (alusel)				// ALU Select Control are our cases

//Addition		
		4'b0000:
			begin
			temp = {Cout,aluin_a} + {Cout,aluin_b};				//pad one bit o to each of the input; Cout is declared at 1'b0
			y = temp[3:0];										// ALU output equal the first 3 bits
			cf = temp[4];										// Carry flag is equal to MSB of temp
			ovf = y[3] ^ aluin_a[3] ^aluin_b[3] ^ cf; 			// Overflow for negative number
			end

//Addition with Cin
		4'b0001:
			begin
			temp = {Cout,aluin_a} + {Cout,aluin_b} + {Cout,3'b000,Cin};	//pad one bit o to each of the input; Cout is declared at 1'b0
			y = temp[3:0];												// ALU output equal the first 3 bits
			cf = temp[4];												// Carry flag is equal to MSB of temp
			ovf = y[3] ^ aluin_a[3] ^aluin_b[3] ^ cf;					// Overflow for negative number
			end

//aluin_a - aluin_b
		4'b0010:
			begin
			temp = {Cout,aluin_a} - {Cout,aluin_b};    //pad one bit o to each of the input; Cout is declared at 1'b0
			y = temp[3:0];										 // ALU output equal the first 3 bits
			cf = temp[4];										// Carry flag is equal to MSB of temp
			ovf = y[3] ^ aluin_a[3] ^aluin_b[3] ^ cf;	// Overflow for negative number
			end 
			
		4'b0011:					// Subtraction of aluin_a - aluin_b - Cin
			begin
			temp = {Cout,aluin_a} - {Cout,aluin_b} - {Cout,3'b000,Cin};    //pad one bit o to each of the input; Cout is declared at 1'b0
			y = temp[3:0];										 // ALU output equal the first 3 bits
			cf = temp[4];										// Carry flag is equal to MSB of temp
			ovf = y[3] ^ aluin_a[3] ^aluin_b[3] ^ cf;	// Overflow for negative number
			end 
			
		4'b0100: y = aluin_a >> aluin_b;// Pass the values of ALU inputs A
		4'b0101: y = aluin_a <<< aluin_b;// Pass the values of ALU inputs A
//Right barrel rotate		
		4'b0110:
			begin
			assign aluin_a_rotate = {5{aluin_a}};
			assign y = aluin_a_rotate[aluin_b + 3 : aluin_b];
			end

		4'b0111: y = 4'b0000;// Pass the values of ALU inputs A
		4'b1000: y = aluin_a | aluin_b;  // OR Operation
		4'b1001: y = aluin_a & aluin_b;  // AND Operation
		4'b1010: y = aluin_a ^ aluin_b;	// XOR Operation
		4'b1011: y = ~aluin_a ;// Pass the values of ALU NOT input A
		4'b1100: assign LED = (alusel && 4'b1100) ? 16'h4255 : 16'h0000;
		4'b1101: assign LED = (alusel && 4'b1101) ? 16'hFFFF : 16'h0000;
		4'b1110: y = aluin_a << aluin_b;// Pass the values of ALU inputs A
		4'b1111:
			begin
			assign aluin_a_rotate = {5{aluin_a}};
			assign y = aluin_a_rotate[19 - aluin_b : 16 - aluin_b];
			end

	endcase
	
nf = y [3]; 									//The negative flag, nf, is 1 if the sign bit y(3) is 1 otherwise y(3)=0

 if(y == 4'b0000)								// if the output is zero then Zero flag is high
	zf = 1;
 else
	zf = 0;
 end 
endmodule
