function [C_rndm_deintlv] = rndm_deintlv(C,N,s)
%作用：随机去交织
%输入：信息序列C，交织长度N，随机映射关系s 
%输出：去交织结果

L = length(C);
%末尾补零
if L <= N %信息序列的数目小于矩阵元素
    add0 = N-L;
    C_add0 = [C,zeros(1,add0)];
else %信息序列的数目大于矩阵元素
    l = ceil(L/N);
    add0 = l*N-L;
    C_add0 = [C,zeros(1,add0)];
end

block_num = length(C_add0)/N;%计算共有几个N
for i = 1:block_num
    %随机交织
    C_use = C_add0((i-1)*N+1:i*N);
    C_rndm_deintlv1(s) = C_use;
    C_rndm_deintlv((i-1)*N+1:i*N) = C_rndm_deintlv1;
end
% C_rndm_deintlv(find(C_rndm_deintlv==0))=[];%去零