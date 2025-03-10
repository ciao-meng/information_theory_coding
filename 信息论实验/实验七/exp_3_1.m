clc
clear all
addpath E:\实验七材料\实验七材料\conv_decode
g0 = [1 0 0 1 1];%生成矢量1
g1 = [1 1 1 0 1];%生成矢量2
M = [1 1 0 0 1 0 1 1];%信息序列
%——卷积码编码——
C = conv_encode21n(g0,g1,M);
%——编码结果展示——
disp('编码结果为')
disp(num2str(C));

%——卷积码解码——
g = [g0;g1];
D = conv_decode(g,1,C);%解码，输入生成矢量，编码位数k，待解码矩阵
%——解码结果展示——
disp('输入的信息序列为')
disp(num2str(M));
disp('解码结果为')
disp(num2str(D));
