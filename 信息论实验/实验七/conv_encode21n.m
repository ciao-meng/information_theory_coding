function [ C ] = conv_encode21n(g0,g1,M)
%��2��1��3���������뺯��
%g0��g1Ϊ����ʸ��
%MΪ���������Ϣ����
N = length(g0);%����Լ����
g0 = fliplr(g0);
g1 = fliplr(g1);
Reg = [zeros(1,N-1),M,zeros(1,N)];%���ñ�����������Ϣ����ǰ��N-1��0����Ϣ����ĩβ��N��0
for k = 1:(length(Reg)-N+1)
    C(2*k-1) = mod(Reg(k:k+N-1)*g0',2);
    C(2*k) = mod(Reg(k:k+N-1)*g1',2);
end
end
