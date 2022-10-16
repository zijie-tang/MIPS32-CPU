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
    reg Clk,En,Clrn;
    wire[31:0] IF_ADDR,EX_R,EX_X,EX_Y;
    
    wire [31:0] IF_Result,IF_Addr,IF_PCadd4,IF_Inst,D,D1,ID_Qa,ID_Qb,ID_PCadd4,ID_Inst,ID_InstL2,EX_InstL2;
    wire [31:0] E_R1,E_R2,E_I,X,Y,E_R,EX_PC,EX_Inst,M_R,M_S,Dout,W_D,W_C,ID_EXTIMM,Alu_X,E_NUM,ID_EXTIMM_L2,ID_PC,EX_PCadd4,M_PCadd4,W_PCadd4;
    wire [5:0] E_Op,E_Func;
    wire [4:0] ID_Wr,ID_Wr1,W_Wr,E_Rd,M_Rd;
    wire [3:0]Aluc,E_Aluc;
    wire [1:0]Pcsrc,FwdA,FwdB,E_FwdA,E_FwdB;
    wire Regrt,Se,Wreg,Aluqb,Reg2reg,Wmem,Z,shift,j,Clkn,E_j,M_j,W_j;
    wire E_Wreg,E_Reg2reg,E_Wmem,E_Aluqb,Cout,M_Wreg,M_Reg2reg,M_Wmem,W_Wreg,W_Reg2reg,stall,condep;
    
    //IF
    not i0(Clkn,Clk);
    MUX4X32 mux4x32(IF_PCadd4,EX_PC,E_R1,EX_InstL2,Pcsrc,IF_Result);
    PC pc(IF_Result,Clk,En,Clrn,IF_Addr,stall);
    PCadd4 pcadd4(IF_Addr,IF_PCadd4);
    INSTMEM instmem(IF_Addr,IF_Inst);
    
    REG_ifid ifid(IF_PCadd4,IF_Inst,En,Clk,Clrn,ID_PCadd4,ID_Inst,stall,condep);
    
    //ID
    CONUNIT conunit(E_Op,ID_Inst[31:26],E_Func,ID_Inst[5:0],Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,shift,j,ID_Inst[25:21],ID_Inst[20:16],E_Rd,M_Rd,E_Wreg,M_Wreg,FwdA,FwdB,E_Reg2reg,stall,condep);
    MUX2X5 mux2x5_1(ID_Inst[15:11],ID_Inst[20:16],Regrt,ID_Wr1);
    MUX2X5 mux2x5_2(ID_Wr1,31,j,ID_Wr);
    EXT16T32 ext16t32(ID_Inst[15:0],Se,ID_EXTIMM);//ID_EXTIMM对应E_I
    REGFILE regfile(ID_Inst[25:21],ID_Inst[20:16],D,W_Wr,W_Wreg,Clkn,Clrn,ID_Qa,ID_Qb);
    SHIFTER32_L2 shifter2(ID_EXTIMM,ID_EXTIMM_L2);//控制冒险
    SHIFTER_COMBINATION shifter1(ID_Inst[25:0],ID_PCadd4,ID_InstL2);
    CLA_32 cla_32(ID_PCadd4,ID_EXTIMM_L2,0,ID_PC,Cout);//ID_PCadd4对应E_PC
    MUX2X32 mux2x32_1(D1,W_PCadd4,W_j,D);
    REG_idex idex(ID_Inst[5:0],j,ID_PCadd4,ID_InstL2,ID_PC,Wreg,Reg2reg,Wmem,ID_Inst[31:26],Aluc,Aluqb,ID_Inst,ID_Qa,ID_Qb,ID_EXTIMM,ID_Wr,En,Clk,Clrn,E_Wreg,E_Reg2reg,E_Wmem,E_Op,E_Aluc,E_Aluqb,EX_Inst,E_R1,E_R2,E_I,E_Rd,FwdA,FwdB,E_FwdA,E_FwdB,EX_PC,stall,EX_InstL2,EX_PCadd4,E_j,E_Func,condep);
    
    //EX
    MUX4X32 mux4x32_ex_1(E_R1,D1,M_R,0,E_FwdA,Alu_X);
    MUX4X32 mux4x32_ex_2(E_R2,D1,M_R,0,E_FwdB,E_NUM);
    MUX2X32 mux2x32_2(E_I,E_NUM,E_Aluqb,Y);
    MUX2X32 mux2x32_3(Alu_X,EX_Inst,shift,X);
    ALU alu(X,Y,E_Aluc,E_R,Z);
    
    REG_exmem exmem(E_j,EX_PCadd4,E_Wreg,E_Reg2reg,E_Wmem,E_R,E_R2,E_Rd,En,Clk,Clrn,M_Wreg,M_Reg2reg,M_Wmem,M_R,M_S,M_Rd,M_PCadd4,M_j);
    
    //MEM
    DATAMEM datamem(M_R,M_S,Clk,M_Wmem,Dout);
    
    REG_memwb memwb(M_j,M_PCadd4,M_Wreg,M_Reg2reg,M_R,Dout,M_Rd,En,Clk,Clrn,W_Wreg,W_Reg2reg,W_D,W_C,W_Wr,W_PCadd4,W_j);
    
    //WB
    MUX2X32 mux2x32_4(W_C,W_D,W_Reg2reg,D1);
    
    assign IF_ADDR=IF_Addr;
    assign EX_R=E_R;
    assign EX_X=X;
    assign EX_Y=Y;
    
    initial begin 
        Clk=0;
        Clrn=0;
        En=1;
        #10
        Clrn<=1;
    end
    always #5 Clk=~Clk;
endmodule
