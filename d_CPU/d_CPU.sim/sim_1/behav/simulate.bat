@echo off
set xv_path=D:\\Vivado2017\\Vivado\\2017.2\\bin
call %xv_path%/xsim ALU_test_behav -key {Behavioral:sim_1:Functional:ALU_test} -tclbatch ALU_test.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
