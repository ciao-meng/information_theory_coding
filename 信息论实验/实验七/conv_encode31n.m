function [ C ] = conv_encode31n(g0,g1,g2,M)
%��3��1��3���������뺯��
%g0��g1,g2Ϊ����ʸ��
%MΪ���������Ϣ����
N = length(g0);%����Լ����
g0 = fliplr(g0);
g1 = fliplr(g1);
g2 = fliplr(g2);
Reg = [zeros(1,N-1),M,zeros(1,N)];%���ñ�����������Ϣ����ǰ��N-1��0����Ϣ����ĩβ��N��0
for k = 1:(length(Reg)-N+1)%���β���������
    C(3*k-2) = mod(Reg(k:k+N-1)*g0',2);
    C(3*k-1) = mod(Reg(k:k+N-1)*g1',2);
    C(3*k) = mod(Reg(k:k+N-1)*g2',2);
end
end