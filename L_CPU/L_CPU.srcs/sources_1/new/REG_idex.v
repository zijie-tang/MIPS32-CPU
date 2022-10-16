`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 18:34:44
// Design Name: 
// Module Name: REG_idex
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


module REG_idex(D17,D16,D15,D14,D13,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,En,Clk,Clrn,Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,D11,D12,Q11,Q12,Q13,stall,Q14,Q15,Q16,Q17,condep);
    input [31:0] D15,D14,D6,D7,D8,D9,D13;
    input [5:0]D3,D17;
    input [4:0]D10;
    input [3:0]D4;
    input [1:0]D11,D12;
    input D0,D1,D2,D5,D16;
    input En,Clk,Clrn,condep,stall;
    
    output [31:0] Q15,Q14,Q6,Q7,Q8,Q9,Q13;
    output [5:0] Q3,Q17;
    output [4:0]Q10;
    output [3:0]Q4;
    output [1:0]Q11,Q12;
    output Q0,Q1,Q2,Q5,Q16;
    
    wire [31:0] Qn15,Qn6,Qn7,Qn8,Qn9,Qn13,Qn14;
    wire [5:0] Qn3,Qn17;
    wire [4:0]Qn10;
    wire [3:0]Qn4;
    wire [1:0]Qn11,Qn12;
    wire Qn0,Qn1,Qn2,Qn5,Qn16;
    wire Clrn_SC;
    assign Clrn_SC=Clrn&~stall&~condep;
    
    D_FFEC q0(D0,Clk,En,Clrn_SC,Q0,Qn0);
    D_FFEC q1(D1,Clk,En,Clrn_SC,Q1,Qn1);
    D_FFEC q2(D2,Clk,En,Clrn_SC,Q2,Qn2);
    D_FFEC6 q3(D3,Clk,En,Clrn_SC,Q3,Qn3);
    D_FFEC4 q4(D4,Clk,En,Clrn_SC,Q4,Qn4);
    D_FFEC q5(D5,Clk,En,Clrn_SC,Q5,Qn5);
    D_FFEC32 q6(D6,Clk,En,Clrn_SC,Q6,Qn6);
    D_FFEC32 q7(D7,Clk,En,Clrn_SC,Q7,Qn7);
    D_FFEC32 q8(D8,Clk,En,Clrn_SC,Q8,Qn8);
    D_FFEC32 q9(D9,Clk,En,Clrn_SC,Q9,Qn9);
    D_FFEC5 q10(D10,Clk,En,Clrn_SC,Q10,Qn10);
    D_FFEC2 q11(D11,Clk,En,Clrn_SC,Q11,Qn11);
    D_FFEC2 q12(D12,Clk,En,Clrn_SC,Q12,Qn12);
    D_FFEC32 q13(D13,Clk,En,Clrn_SC,Q13,Qn13);
    D_FFEC32 q14(D14,Clk,En,Clrn_SC,Q14,Qn14);
    D_FFEC32 q15(D15,Clk,En,Clrn_SC,Q15,Qn15);
    D_FFEC q16(D16,Clk,En,Clrn_SC,Q16,Qn16);
    D_FFEC6 q17(D17,Clk,En,Clrn_SC,Q17,Qn17);
endmodule