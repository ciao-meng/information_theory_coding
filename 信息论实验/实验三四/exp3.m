clc
clear
px = [0.2,0.1,0.3,0.15,0.25];%概率分布
% px = [0.3,0.25,0.21,0.1,0.09,0.05];
% px = [0.125,0.125,0.25,0.25,0.25];
despx = sort(px,'descend');%概率分布进行降序排序
l = -log2(despx);%计算自信息量
l = ceil(l);%自信息量向上取整
%参数初始化
p = 0;
P = zeros(1,length(despx));
%计算累加概率
for k=2:length(despx)
    p = p+despx(k-1);
    P(k) = p;
end
%十进制小数转化为二进制
disp('输出码字')
for k = 1:length(l)
    Codeword = bin22dec(P(k),l(k));
    disp(num2str(Codeword));
end
L = despx * l';%计算平均码长
X = ['平均码长=',num2str(L)];
disp(X);
H = -px*(log2(px))';%计算信息熵
yita = H/L;%计算编码效率
Y = ['编码效率=',num2str(yita)];
disp(Y);
    
