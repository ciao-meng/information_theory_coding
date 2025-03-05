clc
clear
M = [1 0 1 1 0 1 0 1 1 0];%输入信息矩阵
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%汉明码矩阵/生成矩阵
R = [0  0  1  1  0  0  0  0  1  0  1  1  0  1  1  0  0  0  1  0  1];%接受序收（第一、五位错）
Mde = blockdecoding(G,R);%解码函数
disp('输入信息矩阵');
disp(num2str(M))
disp('接收序列');
disp(num2str(R));
disp('译码结果');
disp(num2str(Mde));
            

