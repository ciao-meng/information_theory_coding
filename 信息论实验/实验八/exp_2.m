clear all
C = [1:20];%��Ϣ����
B = 4;%�ӳ�֧·��B
M = 7;%���ӳ�֧·�ĵ�λ�ƴ�����ĿM
C_convl_intlv = convl_intlv(C,B,M);
disp('�����֯�����');
disp(num2str(C_convl_intlv));

C_convl_deintlv = convl_deintlv(C_convl_intlv,B,M);
C_convl_deintlv(find(C_convl_deintlv==0))=[];%ȥ��
disp('���ȥ��֯�����')
disp(num2str(C_convl_deintlv));