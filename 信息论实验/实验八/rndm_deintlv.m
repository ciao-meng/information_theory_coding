function [C_rndm_deintlv] = rndm_deintlv(C,N,s)
%���ã����ȥ��֯
%���룺��Ϣ����C����֯����N�����ӳ���ϵs 
%�����ȥ��֯���

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
    C_rndm_deintlv1(s) = C_use;
    C_rndm_deintlv((i-1)*N+1:i*N) = C_rndm_deintlv1;
end
% C_rndm_deintlv(find(C_rndm_deintlv==0))=[];%ȥ��