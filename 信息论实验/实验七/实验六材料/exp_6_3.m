clc
clear all;
EbN0db = 0:5;
% EbN0 = 10.^(EbN0db/10);
N = 20000;%ѭ������
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%���������/���ɾ���
length_M = 32;%�볤
errorde = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);        
        [C C1] = blockcoding(G,input);%����
        Txde = C.*2-1;%��������       
        Rxde = awgn(Txde,EbN0db(k),'measured');%��AWGN�ŵ�
        Rde = round((sign(Rxde)+1)./2);%���
        outputde = blockdecoding(G,Rde);%���뺯��
        errorde = sum(input~=outputde);%ͳ�ƴ�������
        
        Tx = input.*2-1;%δ�������
        Rx = awgn(Tx,EbN0db(k),'measured');%δ���� ��AWGN�ŵ�
        output = round((sign(Rx)+1)./2);%δ���� ���
        error = sum(input~=output);
        
        berde(i) = errorde;%����������
        ber(i) = error;
    end
%     ber_theory(k) = berawgn(EbN0db(k),'psk',2,'nondiff');%��AWGN�ŵ�������������
    BERde(k) = mean(berde)/length_M;
    BER(k) = mean(ber)/length_M;
end

semilogy(EbN0db,BERde,'-*',EbN0db,BER,'-o');
legend('����ֵ','δ����ֵ')
    
