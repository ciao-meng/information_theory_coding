clc
clear
px = [0.2,0.1,0.3,0.15,0.25];%���ʷֲ�
% px = [0.3,0.25,0.21,0.1,0.09,0.05];
% px = [0.125,0.125,0.25,0.25,0.25];
despx = sort(px,'descend');%���ʷֲ����н�������
l = -log2(despx);%��������Ϣ��
l = ceil(l);%����Ϣ������ȡ��
%������ʼ��
p = 0;
P = zeros(1,length(despx));
%�����ۼӸ���
for k=2:length(despx)
    p = p+despx(k-1);
    P(k) = p;
end
%ʮ����С��ת��Ϊ������
disp('�������')
for k = 1:length(l)
    Codeword = bin22dec(P(k),l(k));
    disp(num2str(Codeword));
end
L = despx * l';%����ƽ���볤
X = ['ƽ���볤=',num2str(L)];
disp(X);
H = -px*(log2(px))';%������Ϣ��
yita = H/L;%�������Ч��
Y = ['����Ч��=',num2str(yita)];
disp(Y);
    
