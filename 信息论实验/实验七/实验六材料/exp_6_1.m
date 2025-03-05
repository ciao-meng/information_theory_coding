clc
clear
M = [1 0 1 1 0 1 0 1 1 0];%输入信息矩阵
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%汉明码矩阵/生成矩阵
[C C1] = blockcoding(G,M);
disp('编码结果为：');
disp(num2str(C));
