clear all
C = [1:20];%��Ϣ����
N = 28;%�����֯����
s = randperm(N);%���ӳ���ϵ
C_rndm_intlv = rndm_intlv(C,N,s);%�����֯
disp('��֯�����');%��ʾ���
disp(num2str(C_rndm_intlv));

C_rndm_deintlv = rndm_deintlv(C_rndm_intlv,N,s);%���ȥ��֯
C_rndm_deintlv(find(C_rndm_deintlv==0))=[];%ȥ��
disp('ȥ��֯�����');%��ʾ���
disp(num2str(C_rndm_deintlv));
