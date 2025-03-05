clc
clear
px = [0.3,0.25,0.21,0.1,0.09,0.05];%���ʷֲ�
% px = [0.2,0.1,0.3,0.15,0.25];%���ʷֲ�
% px = [0.125,0.125,0.25,0.25,0.25];
px = sort(px,'descend');
symbols = [1:length(px)];
[dict,avglen] = huffmandict(symbols, px);
H = -px*(log2(px))';%������Ϣ��
yita = H/avglen;%�������Ч��
%�ڿ���̨������֡�ƽ���볤�ͱ���Ч��
disp('�������:');
for k = 1:length(px)
    A = dict{k,2};
    disp(num2str(A));
end
X = ['ƽ���볤= ',num2str(avglen)];
disp(X);
Y = ['����Ч��= ',num2str(yita)];
disp(Y);