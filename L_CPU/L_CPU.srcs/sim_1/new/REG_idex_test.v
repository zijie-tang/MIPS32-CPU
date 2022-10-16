`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/05 19:13:12
// Design Name: 
// Module Name: REG_idex_test
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


module REG_idex_test;
    reg [31:0] D14,D6,D7,D8,D9,D13;
    reg [5:0]D3;
    reg [4:0]D10;
    reg [3:0]D4;
    reg [1:0]D11,D12;
    reg D0,D1,D2,D5;
    reg En,Clk,Clrn;
    wire[31:0] Q14,Q6,Q7,Q8,Q9,Q13;
    wire[5:0] Q3;
    wire[4:0]Q10;
    wire[3:0]Q4;
    wire [1:0]Q11,Q12;
    wire Q0,Q1,Q2,Q5;
    REG_idex u(D14,D13,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,En,Clk,Clrn,Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,D11,D12,Q11,Q12,Q13,Q14);
    initial begin
        D1=1;
        D2=1;
        D0=1;
        D3=2;
        D5=1;
        D4=1;
        D6=5;
        D7=3;
        D8=4;
        D9=2;
        D10=3;
        D11=1;
        D12=1;
        D13=2;
        D14=2;
        En=1;
        Clk=0;
        Clrn=0;
    end
    always #4 D0=D0+1;
    always #2 D1=D1+1;
    always #5 D2=D2+1;
    always #3 D3=D1+1;
    always #7 D4=D4+1;
    always #3 D5=D5+1;
    always #2 D6=D6+1;
    always #4 D7=D7+1;
    always #2 D8=D8+1;
    always #2 D9=D9+1;
    always #6 D10=D10+1;
    always #9 D11=D11+1;
    always #12 D12=D12+1;
    always #14 D13=D13+1;
    always #13 D14=D14+1;
    always #0.6 Clk=Clk+1;
    always #3 Clrn=1;
endmodule
