clc
clear all;
EbN0db = 0:4;
N = 2000;%ѭ������
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%���������/���ɾ���
g0 = [1 0 1];%����ʸ��1
g1 = [1 1 1];%����ʸ��2
g = [g0;g1];%��������ɾ���
length_M = 8;%�볤
error_han = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %��������������awgn����
        [C_han C1] = blockcoding(G,input);%����
        Tx_han = C_han.*2-1;%��������       
        Rx_han = awgn(Tx_han,EbN0db(k),'measured');%��AWGN�ŵ�
        R_han = round((sign(Rx_han)+1)./2);%���
        output_han = blockdecoding(G,R_han);%���뺯��
        error_han = sum(input~=output_han);%ͳ�ƴ�������
        %����BPSK��AWGN
        Tx = input.*2-1;%δ�������
        Rx = awgn(Tx,EbN0db(k),'measured');%δ���� ��AWGN�ŵ�
        output = round((sign(Rx)+1)./2);%δ���� ���
        error = sum(input~=output);
        %�������������AWGN����
        C_conv = conv_encode21n(g0,g1,input);
        Tx_conv = C_conv.*2-1;
        Rx_conv = awgn(Tx_conv,EbN0db(k),'measured');%��AWGN�ŵ�
        R_conv = round((sign(Rx_conv)+1)./2);%���
        output_conv = conv_decode(g,1,R_conv);%���뺯��
        error_conv = sum(input~=output_conv);%ͳ�ƴ�������                
        %�������������ʡ���
        berhan(i) = error_han;%����������
        ber(i) = error;
        berconv(i) = error_conv;
    end
    BERhan(k) = mean(berhan)/length_M;
    BER(k) = mean(ber)/length_M;
    BERconv(k) = mean(berconv)/length_M;
end

semilogy(EbN0db,BERhan,'-*',EbN0db,BER,'-o',EbN0db,BERconv,'-square');
legend('���������ֵ','δ����ֵ','��������ֵ')
grid on