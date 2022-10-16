`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/15 15:21:45
// Design Name: 
// Module Name: PC
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

module PC(IF_Result,Clk,En,Clrn,IF_Addr,stall);
    input [31:0]IF_Result;
    input Clk,En,Clrn,stall;
    output [31:0]IF_Addr;
    wire [31:0]IF_Addr_n;
    wire En_S;
    assign En_S=En&~stall;
    D_FFEC32 pc(IF_Result,Clk,En_S,Clrn,IF_Addr,IF_Addr_n);
endmodule 