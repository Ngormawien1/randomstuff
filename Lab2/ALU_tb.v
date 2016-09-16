`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:59:04 04/15/2016
// Design Name:   alu4
// Module Name:   C:/ALU/ALU_tb.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;

	// Inputs
	reg [2:0] alusel;
	reg [3:0] aluin_a;
	reg [3:0] aluin_b;

	// Outputs
	wire nf;
	wire zf;
	wire cf;
	wire ovf;
	wire Cout;
	wire [3:0] y;

	// Instantiate the Unit Under Test (UUT)
	alu4 uut (
		.alusel(alusel), 
		.aluin_a(aluin_a), 
		.aluin_b(aluin_b), 
		.nf(nf), 
		.zf(zf), 
		.cf(cf), 
		.ovf(ovf), 
		.Cout(Cout), 
		.y(y)
	);
	
initial begin
		// Initialize Inputs
		alusel = 0;
		aluin_a = 0;
		aluin_b = 0;
		
alusel = 4'b000;
          
       aluin_a = 4'b100 ;
       aluin_b = 4'b011 ;
       # 50;		
		 
alusel = 4'b001;
          
       aluin_a = 4'b100 ;
       aluin_b = 4'b011 ;
       # 50;
   
alusel = 4'b010;
         
       aluin_a = 4'b001 ;
       aluin_b = 4'b011 ;
       # 50;
   
alusel = 4'b011;
      
        aluin_a = 4'b001 ;
        aluin_b = 4'b011 ;
       # 50;
   
alusel = 4'b100;
          
       aluin_a = 4'b001 ;
       aluin_b = 4'b011 ;
       # 50;
   
alusel = 4'b101;
          
       aluin_a = 4'b001 ;
       aluin_b = 4'b011 ;
       # 50;
   
 alusel = 4'b110;
           
       aluin_a = 4'b110 ;
       aluin_b = 4'b011 ;
       # 50;
   
alusel = 4'b111;
     
       aluin_a = 4'b001 ;
       aluin_b = 4'b011 ;
       # 50;
   
    $finish;
    end 
    
endmodule
