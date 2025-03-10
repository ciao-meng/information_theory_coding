function [ C ] = conv_encode21n(g0,g1,M)
%（2，1，3）卷积码编码函数
%g0，g1为生成矢量
%M为待编码的信息序列
N = length(g0);%编码约束度
g0 = fliplr(g0);
g1 = fliplr(g1);
Reg = [zeros(1,N-1),M,zeros(1,N)];%设置编码器：在信息序列前加N-1个0，信息序列末尾加N个0
for k = 1:(length(Reg)-N+1)
    C(2*k-1) = mod(Reg(k:k+N-1)*g0',2);
    C(2*k) = mod(Reg(k:k+N-1)*g1',2);
end
end
