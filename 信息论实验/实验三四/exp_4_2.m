%% 实验四：哈夫曼编码仿真实现
clear all
clc

p = [0.3,0.25,0.21,0.1,0.09,0.05];%概率分布
n = length(p);

% 将概率排序并获得单步码字排序
code = strings(n-1,n);% 初始化单步过程的码字
refl = zeros(n-1,n);% 初始化位置对应向量
p1 = p;% p_SD为每次得到的概率排序数组
for i=1:n-1           % i表示排序后第几个符号
    M = length(p1);
    [p1,refl(i,1:M)] = sort(p1,'descend');% 将概率从大到小进行排序
    code(i,M) = '1';% 概率最小的是1
    code(i,M-1) = '0';% 概率第二小的暂且定义为0
    p1(M-1) = p1(M-1)+p1(M);% 将最后两个概率相加
    p1(M)=[];
end

% 根据位置对应向量和单步过程的码字计算对应码字
CODE = strings(1,n); % 初始化对应码字
for i=1:n
    column = i;
    for m=1:n-1
        [row,column] = find(refl(m,:)==column);
        CODE(1,i) = strcat(CODE(1,i),code(m,column));
        % 将最小的两个概率映射成一个
        if column==n+1-m
            column = column-1;
        end
    end
end
CODE = reverse(CODE);

% 计算平均码长
for i=1:n
    L(i) = size(char(CODE(1,i)),2);
end
avelen = sum(L.*p);
H = sum(-p.*log2(p));   % 计算信源信息熵
yita = H/avelen;         % 计算编码效率

% 展示输出码字、平均码长和编码效率
disp('输出码字');
disp(CODE);
disp(['平均码长= ',num2str(avelen)]);
disp(['编码效率= ',num2str(yita)]);

