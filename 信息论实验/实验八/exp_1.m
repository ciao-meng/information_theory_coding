clc
clear all
C = [1:20];%��Ϣ����
row = 7;%��֯���������m
coln = 4;%����n
C_intlv = packet_intlv(C,row,coln);%���齻֯
disp('��֯�����');%��ʾ���
disp(num2str(C_intlv));

C_deintlv = packet_deintlv(C_intlv,row,coln);%����ȥ��֯
C_deintlv(find(C_deintlv==0))=[];%ȥ��
disp('ȥ��֯�����');%��ʾ���
disp(num2str(C_deintlv));