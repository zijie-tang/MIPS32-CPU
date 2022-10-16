`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/14 17:40:35
// Design Name: 
// Module Name: TEST1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - Fsile Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module test();
    reg Clk,Reset;
    wire [31:0] Inst,NEXTADDR,ALU_R,Qb,Qa,Addr,D;
    
    wire [31:0]Result,PCadd4,EXTIMM,InstL2,EXTIMML2,X,Y,Dout,mux4x32_2,R,D1;
    wire Z,Regrt,Se,Wreg,Aluqb,Reg2reg,Cout,Wmem,shift,j;
    wire [3:0]Aluc;
    wire [1:0]Pcsrc;
    wire [4:0]Wr,Wr1;
    initial begin 
        Clk=0;
        Reset=0;
        #5
        Reset<=1;
    end
    always #5 Clk=~Clk;
    
    PC pc(Clk,Reset,Result,Addr);
    PCadd4 pcadd4(Addr,PCadd4);
    INSTMEM instmem(Addr,Inst);
    
    CONUNIT conunit(Inst[31:26],Inst[5:0],Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,shift,j);
    MUX2X5 mux2x5_1(Inst[15:11],Inst[20:16],Regrt,Wr1);
    MUX2X5 mux2x5_2(Wr1,31,j,Wr);
    EXT16T32 ext16t32(Inst[15:0],Se,EXTIMM);
    SHIFTER_COMBINATION shifter1(Inst[25:0],PCadd4,InstL2);
    SHIFTER shifter2(EXTIMM,2,0,0,EXTIMML2);
    REGFILE regfile(Inst[25:21],Inst[20:16],D,Wr,Wreg,Clk,Reset,Qa,Qb);
    MUX2X32 mux2x32_1(EXTIMM,Qb,Aluqb,Y);
    MUX2X32 mux2x32_2(Qa,Inst,shift,X);
    ALU alu(X,Y,Aluc,R,Z);
    DATAMEM datamem(R,Qb,Clk,Wmem,Dout); 
    MUX2X32 mux2x32_3(Dout,R,Reg2reg,D1);
    MUX2X32 mux2x32_4(D1,PCadd4,j,D);
    CLA_32 cla_32(PCadd4,EXTIMML2,0,mux4x32_2,Cout);
    MUX4X32 mux4x32(PCadd4,mux4x32_2,Qa,InstL2,Pcsrc,Result);
    assign NEXTADDR=Result;
    assign ALU_R=R;
endmodule
