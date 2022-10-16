`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/13 16:43:51
// Design Name: 
// Module Name: CONUNIT
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

module CONUNIT(
	input [5:0]Op,
	input [5:0]Func,
	input Z,
	output Regrt,
	output Se,
	output Wreg,
	output Aluqb,
	output [3:0]Aluc,
	output Wmem,
	output [1:0]Pcsrc,
	output Reg2reg,
	output shift,
	output j	
    );
    wire i_add = (Op == 6'b000000 & Func == 6'b100000)?1:0;
    wire i_sub = (Op == 6'b000000 & Func == 6'b100010)?1:0;
    wire i_and = (Op == 6'b000000 & Func == 6'b100100)?1:0;
    wire i_or  = (Op == 6'b000000 & Func == 6'b100101)?1:0;
    wire i_xor = (Op == 6'b000000 & Func == 6'b100110)?1:0;
    wire i_sll = (Op == 6'b000000 & Func == 6'b000000)?1:0;
    wire i_srl = (Op == 6'b000000 & Func == 6'b000010)?1:0;
    wire i_sra = (Op == 6'b000000 & Func == 6'b000011)?1:0;
    wire i_jr  = (Op == 6'b000000 & Func == 6'b001000)?1:0;
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
    assign Pcsrc[0] = (i_beq&Z) | (i_bne&~Z) | i_jal | i_j;
    assign Pcsrc[1] = i_j | i_jr | i_jal;
    assign shift=i_sll | i_srl | i_sra;
    assign j=i_jal | i_jr;
endmodule
