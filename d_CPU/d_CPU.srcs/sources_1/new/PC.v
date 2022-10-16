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

module PC(Clk,Reset,Result,Address);  
    input Clk;//时钟
    input Reset;//是否重置地址。0-初始化PC，否则接受新地址       
    input[31:0] Result;
    output [31:0]Address;
    D_FFEC32 _pc(Result,Clk,1,Clrn,Address);
endmodule
