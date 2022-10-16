`timescale 1ns / 1ps
////////
module CONUNIT(E_Op,Op,E_Func,Func,Z,Regrt,Se,Wreg,Aluqb,Aluc,Wmem,Pcsrc,Reg2reg,shift,j,Rs,Rt,E_Rd,M_Rd,E_Wreg,M_Wreg,FwdA,FwdB,E_Reg2reg,stall,condep);
    input [5:0]Op,Func,E_Op,E_Func;
    input Z;
    input E_Wreg,M_Wreg,E_Reg2reg;
    input [4:0]E_Rd,M_Rd,Rs,Rt;
    output Regrt,Se,Wreg,Aluqb,Wmem,Reg2reg,stall,condep;
    output [1:0]Pcsrc;
    output [3:0]Aluc;
    output shift;
    output j;
    output reg [1:0]FwdA,FwdB;
    wire i_add = (Op == 6'b000000 & Func == 6'b100000)?1:0;
    wire i_sub = (Op == 6'b000000 & Func == 6'b100010)?1:0;
    wire i_and = (Op == 6'b000000 & Func == 6'b100100)?1:0;
    wire i_or  = (Op == 6'b000000 & Func == 6'b100101)?1:0;
    wire i_xor = (Op == 6'b000000 & Func == 6'b100110)?1:0;
    wire i_sll = (Op == 6'b000000 & Func == 6'b000000)?1:0;
    wire i_srl = (Op == 6'b000000 & Func == 6'b000010)?1:0;
    wire i_sra = (Op == 6'b000000 & Func == 6'b000011)?1:0;
    wire i_jr  = (Op == 6'b000000 & Func == 6'b001000)?1:0;
    wire E_jr  = (E_Op == 6'b000000 & E_Func == 6'b001000)?1:0;
    //R
    wire i_addi = (Op == 6'b001000)?1:0;
    wire i_andi = (Op == 6'b001100)?1:0; 
    wire i_ori  = (Op == 6'b001101)?1:0;
    wire i_xori = (Op == 6'b001110)?1:0;
    wire i_lw   = (Op == 6'b100011)?1:0;
    wire i_sw   = (Op == 6'b101011)?1:0;
    wire i_beq  = (Op == 6'b000100)?1:0;
    wire i_bne  = (Op == 6'b000101)?1:0;
    wire i_lui  = (Op == 6'b001111)?1:0;
    //I
    wire i_j    = (Op == 6'b000010)?1:0;
    wire i_jal  = (Op == 6'b000011)?1:0;
    wire E_j    = (E_Op == 6'b000010)?1:0;
    wire E_jal  = (E_Op == 6'b000011)?1:0;
    //J
    wire E_beq = (E_Op == 6'b000100)?1:0;
    wire E_bne = (E_Op == 6'b000101)?1:0;
    wire E_Inst = i_add|i_sub|i_and|i_or|i_sw|i_beq|i_bne;
    assign Wreg = i_add|i_sub|i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_addi|i_andi|i_ori|i_or|i_xori|i_lw|i_lui|i_jal;
    assign Regrt = i_addi|i_andi|i_ori|i_xori|i_lw|i_sw|i_lui|i_beq|i_bne|i_j|i_jal;
    assign Reg2reg  = i_add|i_sub|i_and|i_or|i_xor|i_sll|i_srl|i_sra|i_addi|i_andi|i_ori|i_xori|i_sw|i_beq|i_bne|i_j|i_jal;
    assign Aluqb = i_add | i_sub | i_and | i_or | i_xor | i_sll | i_srl | i_sra | i_beq | i_bne |i_j;
    assign Se   = i_addi | i_lw | i_sw | i_beq | i_bne;
    assign Aluc[3] = i_sra;
    assign Aluc[2] = i_xor |i_lui | i_sll | i_srl | i_sra |i_xori;
    assign Aluc[1] = i_and | i_or | i_lui | i_srl | i_sra | i_andi | i_ori;
    assign Aluc[0] = i_sub | i_ori | i_or | i_sll | i_srl |i_sra| i_beq | i_bne;
    assign Wmem = i_sw;
    assign Pcsrc[0] = E_jal | E_j | (E_beq&Z) | (E_bne&~Z);
    assign Pcsrc[1] = E_j | E_jr | E_jal;
    assign shift = i_sll | i_srl | i_sra;
    assign j = i_jal | i_jr;
    always@(E_Rd,M_Rd,E_Wreg,M_Wreg,Rs,Rt,i_add,i_sub,i_and,i_or,i_sw,i_beq,i_bne)begin
        FwdA=2'b00;
        if((Rs==E_Rd)&(E_Rd!=0)&(E_Wreg==1))begin
            FwdA=2'b10;
        end else begin
            if((Rs==M_Rd)&(M_Rd!=0)&(M_Wreg==1))begin
                FwdA=2'b01;
            end
        end
    end
    always@(E_Rd,M_Rd,E_Wreg,M_Wreg,Rs,Rt,i_add,i_sub,i_and,i_or,i_sw,i_beq,i_bne)begin
        FwdB=2'b00;
        if((Rt==E_Rd)&((i_add==1)|(i_sub==1)|(i_and==1)|(i_or==1)|(i_sw==1)|(i_beq==1)|(i_bne==1))&(E_Rd!=0)&(E_Wreg==1))begin
            FwdB=2'b10;
        end else begin
            if((Rt==M_Rd)&((i_add==1)|(i_sub==1)|(i_and==1)|(i_or==1)|(i_sw==1)|(i_beq==1)|(i_bne==1))&(M_Rd!=0)&(M_Wreg==1))begin
                FwdB=2'b01;
            end
        end
    end
    assign stall=((Rs==E_Rd)|(Rt==E_Rd))&(E_Reg2reg==0)&(E_Rd!=0)&(E_Wreg==1);
    assign condep=(E_jal)|(E_jr)|(E_beq&Z)|(E_bne&~Z);
endmodule