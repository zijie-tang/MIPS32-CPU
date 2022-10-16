`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/13 16:12:50
// Design Name: 
// Module Name: INSTMEN
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
module INSTMEM(Addr,Inst);//指令存储器
    input[31:0]Addr;
    //状态为'0'，写指令寄存器，否则为读指令寄存器
    output[31:0]Inst;
    wire[31:0]Rom[31:0];
    assign Rom[5'h00]=32'h20010008;//addi $1,$0,8 $1=8 001000 00000 00001 0000000000001000
    assign Rom[5'h01]=32'h3402000C;//ori $2,$0,12 $2=12
    assign Rom[5'h02]=32'h00221820;//add $3,$1,$2 $3=20//数据冒险
    assign Rom[5'h03]=32'h00412022;//sub $4,$2,$1 $4=4//内部前推
    assign Rom[5'h04]=32'h00222824;//and $5,$1,$2
    assign Rom[5'h05]=32'h00223025;//or $6,$1,$2
    assign Rom[5'h06]=32'h14220006;//bne $1,$2,6//00010100001000010000000000000110//缩短分支的延迟
    assign Rom[5'h07]=32'h00221820;//add $3,$1,$2 $3=20
    assign Rom[5'h08]=32'h00412022;//sub $4,$2,$1 $4=4
    assign Rom[5'h09]=32'h10220002;// beq $1,$2,2
    assign Rom[5'h0A]=32'h0800000D;// J 0D 
    assign Rom[5'h0B]=32'h00221820;//add $3,$1,$2 $3=20
    assign Rom[5'h0C]=32'h00412022;//sub $4,$2,$1 $4=4
    assign Rom[5'h0D]=32'hAD02000A;// sw $2 10($8) memory[$8+10]=12
    assign Rom[5'h0E]=32'h8D04000A;//lw $4 10($8) $4=12
    assign Rom[5'h0F]=32'h14440002;//bne $2,$4,2//lw数据冒险
    assign Rom[5'h10]=32'h20210004;//addi $1,$1,4 //00100000001000010000000000000100
    assign Rom[5'h11]=32'h00222824;//and $5,$1,$2
    assign Rom[5'h12]=32'h14220006;//bne $1,$2,6
    assign Rom[5'h13]=32'h30470009;//andi $7,$2,9
    assign Rom[5'h14]=32'h382300EF;//xori $3,$10xef
    assign Rom[5'h15]=32'h3C011234;//lui $1,0x1234
    assign Rom[5'h16]=32'h00021900;//sll $3,$2,4
    assign Rom[5'h17]=32'h00011102;//srl $1,$2,4
    assign Rom[5'h18]=32'h00020903;//sra $3,$1,4//数据冒险
    assign Rom[5'h19]=32'h0C00001D;//Jal 1D
    assign Rom[5'h1A]=32'h08000007;//J 07
    assign Rom[5'h1B]=32'h00021900;//sll $3,$2,4
    assign Rom[5'h1C]=32'h00021903;//sra $3,$2,4
    assign Rom[5'h1D]=32'h00021900;//sll $3,$2,4
    assign Rom[5'h1E]=32'h00021903;//sra $3,$2,4
    assign Rom[5'h1F]=32'h03E00008;//Jr 1A
    assign Inst=Rom[Addr[6:2]];
endmodule
