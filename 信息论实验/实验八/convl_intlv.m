function [C_convl_intlv] = convl_intlv(C,B,M)
%���ã������֯
%���룺��Ϣ����C���ӳ�֧·��B�����ӳ�֧·�ĵ�λ�ƴ�����ĿM
%����������֯���

reg = zeros(1,length(C)+B*(B-1)*M);%�Ĵ�����ʼ��
N = ceil(length(C)/B);%������Ԫ���ڵ���Ŀ
%�����֯
for i = 1:N %ÿһ����Ԫ����
    for k = 1:B %������Ԫ�����еĵ�k���Ĵ���
        reg((i-1)*B+k+(k-1)*M*B) = C((i-1)*B+k);%��λ�����Ĵ���
    end
end
C_convl_intlv = reg;