`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/18 18:48:17
// Design Name: 
// Module Name: test2
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

module test2();
    reg Clk,Reset;
    wire [31:0] Inst,NEXTADDR,ALU_R,Qb,Qa,Addr,D;
    
    wire [31:0]Result,PCadd4,EXTIMM,InstL2,EXTIMML2,Y,Dout,mux4x32_2,R;
    wire Z,Regrt,Se,Wreg,Aluqb,Reg2reg,Cout,Wmem;
    wire [3:0]Aluc;
    wire [1:0]Pcsrc;
    wire [4:0]Wr;
    CPU u(Clk,Reset,Addr,Inst,Qa,Qb,ALU_R,NEXTADDR,D);
    initial begin 
        Clk=0;
        Reset=0;
        #5
            Reset<=1;
    end
    always #5 Clk=~Clk;
endmodule

