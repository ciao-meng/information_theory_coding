function [C_intlv] = packet_intlv(C,m,n)
%���ã����齻֯
%���룺��Ϣ����C�����齻֯���������m������n
%�������֯���

N = length(C);
%ĩβ����
if N <= m*n %��Ϣ���е���ĿС�ھ���Ԫ��
    add0 = m*n-N;
    C_add0 = [C,zeros(1,add0)];
else %��Ϣ���е���Ŀ���ھ���Ԫ��
    l = ceil(N/(m*n));
    add0 = l*m*n-N;
    C_add0 = [C,zeros(1,add0)];
end

block_num = length(C_add0)/(m*n);%���㹲�м�����m,n�������
for i = 1:block_num
    %���齻֯
    C_use = C_add0( ((i-1)*m*n+1):(i*m*n) );%ÿһ�������
    reg = (reshape(C_use.',[n,m])).';%��������
    C_intlv( ((i-1)*m*n+1):(i*m*n) ) = reshape(reg,1,[]);%�������
end
    
    
    