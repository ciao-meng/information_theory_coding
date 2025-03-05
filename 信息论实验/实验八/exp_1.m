clc
clear all
C = [1:20];%信息序列
row = 7;%交织矩阵的行数m
coln = 4;%列数n
C_intlv = packet_intlv(C,row,coln);%分组交织
disp('交织结果：');%显示结果
disp(num2str(C_intlv));

C_deintlv = packet_deintlv(C_intlv,row,coln);%分组去交织
C_deintlv(find(C_deintlv==0))=[];%去零
disp('去交织结果：');%显示结果
disp(num2str(C_deintlv));