function [C_rndm_intlv] = rndm_intlv(C,N,s)
%���ã������֯
%���룺��Ϣ����C����֯����N�����ӳ���ϵs 
%�������֯���

L = length(C);
%ĩβ����
if L <= N %��Ϣ���е���ĿС�ھ���Ԫ��
    add0 = N-L;
    C_add0 = [C,zeros(1,add0)];
else %��Ϣ���е���Ŀ���ھ���Ԫ��
    l = ceil(L/N);
    add0 = l*N-L;
    C_add0 = [C,zeros(1,add0)];
end

block_num = length(C_add0)/N;%���㹲�м���N
for i = 1:block_num
    %�����֯
    C_use = C_add0((i-1)*N+1:i*N);
    C_rndm_intlv((i-1)*N+1:i*N) = C_use(s);
end
