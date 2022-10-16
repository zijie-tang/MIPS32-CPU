`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 20:00:10
// Design Name: 
// Module Name: REG_exmem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module REG_exmem(D4,D3,D0,D1,D2,D6,D7,D8,En,Clk,Clrn,Q0,Q1,Q2,Q6,Q7,Q8,Q3,Q4);
    input [31:0]D3,D6,D7;
    input [4:0]D8;
    input D0,D1,D2,D4;
    
    input En,Clk,Clrn;
    output [31:0] Q3,Q6,Q7;
    output [4:0]Q8; 
    output Q0,Q1,Q2,Q4;
    
    wire [31:0] Qn3,Qn6,Qn7;
    wire [4:0]Qn8; 
    wire Qn0,Qn1,Qn2,Qn4;
    D_FFEC q0(D0,Clk,En,Clrn,Q0,Qn0);
    D_FFEC q1(D1,Clk,En,Clrn,Q1,Qn1);
    D_FFEC q2(D2,Clk,En,Clrn,Q2,Qn2);
    D_FFEC32 q3(D3,Clk,En,Clrn,Q3,Qn3);
    D_FFEC q4(D4,Clk,En,Clrn,Q4,Qn4);
    D_FFEC32 q6(D6,Clk,En,Clrn,Q6,Qn6);
    D_FFEC32 q7(D7,Clk,En,Clrn,Q7,Qn7);
    D_FFEC5 q8(D8,Clk,En,Clrn,Q8,Qn8);
endmodule
