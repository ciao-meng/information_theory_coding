function [C_intlv] = packet_intlv(C,m,n)
%作用：分组交织
%输入：信息序列C，分组交织矩阵的行数m，列数n
%输出：交织结果

N = length(C);
%末尾补零
if N <= m*n %信息序列的数目小于矩阵元素
    add0 = m*n-N;
    C_add0 = [C,zeros(1,add0)];
else %信息序列的数目大于矩阵元素
    l = ceil(N/(m*n));
    add0 = l*m*n-N;
    C_add0 = [C,zeros(1,add0)];
end

block_num = length(C_add0)/(m*n);%计算共有几个（m,n）矩阵块
for i = 1:block_num
    %分组交织
    C_use = C_add0( ((i-1)*m*n+1):(i*m*n) );%每一块的数据
    reg = (reshape(C_use.',[n,m])).';%按行输入
    C_intlv( ((i-1)*m*n+1):(i*m*n) ) = reshape(reg,1,[]);%按列输出
end
    
    
    