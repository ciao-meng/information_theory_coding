function [C_convl_deintlv] = convl_deintlv(C,B,M)
%���ã����ȥ��֯
%���룺��֯��Ϣ����C���ӳ�֧·��B�����ӳ�֧·�ĵ�λ�ƴ�����ĿM
%��������ȥ��֯���

reg = zeros(1,length(C)+B*(B-1)*M);%�Ĵ�����ʼ��
N = ceil(length(C)/B);%������Ԫ���ڵ���Ŀ
%���ȥ��֯
for i = 1:N %ÿһ����Ԫ����
    for k = 1:B %������Ԫ�����еĵ�k���Ĵ���
         reg((i-1)*B+k+(B-k)*M*B) = C((i-1)*B+k);%��λ�����Ĵ���
    end
end
C_convl_deintlv = reg;
% C_convl_deintlv(find(C_convl_deintlv==0))=[];%ȥ��