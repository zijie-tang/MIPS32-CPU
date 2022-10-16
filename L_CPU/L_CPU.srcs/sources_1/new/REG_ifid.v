`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/04 09:14:07
// Design Name: 
// Module Name: REG_ifid
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

module REG_ifid(D0,D1,En,Clk,Clrn,Q0,Q1,stall,condep);
    input [31:0]D0,D1;
    input En,Clk,Clrn;
    input stall,condep;
    output [31:0]Q0,Q1;
    wire En_S,Clrn_C;
    wire [31:0]Q0n,Q1n;
    assign En_S=En&~stall;
    assign Clrn_C=Clrn&~condep;
    D_FFEC32 q0(D0,Clk,En_S,Clrn_C,Q0,Q0n);
    D_FFEC32 q1(D1,Clk,En_S,Clrn_C,Q1,Q1n);
endmodule
