clc
clear
px = [0.3,0.25,0.21,0.1,0.09,0.05];%概率分布
% px = [0.2,0.1,0.3,0.15,0.25];%概率分布
% px = [0.125,0.125,0.25,0.25,0.25];
px = sort(px,'descend');
symbols = [1:length(px)];
[dict,avglen] = huffmandict(symbols, px);
H = -px*(log2(px))';%计算信息熵
yita = H/avglen;%计算编码效率
%在控制台输出码字、平均码长和编码效率
disp('输出码字:');
for k = 1:length(px)
    A = dict{k,2};
    disp(num2str(A));
end
X = ['平均码长= ',num2str(avglen)];
disp(X);
Y = ['编码效率= ',num2str(yita)];
disp(Y);