clc
clear all;
EbN0db = 0:4;
N = 2000;%ѭ������
g0 = [1 0 1];%����ʸ��1
g1 = [1 1 1];%����ʸ��2
g = [g0;g1];%��2��1��3����������ɾ���
g0_1 = [1 0 0 1 1];%����ʸ��1
g1_1 = [1 1 1 0 1];%����ʸ��2
g_1 = [g0_1;g1_1];%��2��1��5����������ɾ���
length_M = 8;%�볤
error_conv2 = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %��������루2��1��5�������AWGN����
        C_conv2 = conv_encode21n(g0_1,g1_1,input);%����
        Tx_conv2 = C_conv2.*2-1;%��������       
        Rx_conv2 = awgn(Tx_conv2,EbN0db(k),'measured');%��AWGN�ŵ�
        R_conv2 = round((sign(Rx_conv2)+1)./2);%���
        output_conv2 = conv_decode(g_1,1,R_conv2);%���뺯��
        error_conv2 = sum(input~=output_conv2);%ͳ�ƴ�������
        %����BPSK��AWGN
        Tx = input.*2-1;%δ�������
        Rx = awgn(Tx,EbN0db(k),'measured');%δ���� ��AWGN�ŵ�
        output = round((sign(Rx)+1)./2);%δ���� ���
        error = sum(input~=output);
        %��������루2��1��3�������AWGN����
        C_conv = conv_encode21n(g0,g1,input);
        Tx_conv2 = C_conv.*2-1;
        Rx_conv = awgn(Tx_conv2,EbN0db(k),'measured');%��AWGN�ŵ�
        R_conv = round((sign(Rx_conv)+1)./2);%���
        output_conv = conv_decode(g,1,R_conv);%���뺯��
        error_conv = sum(input~=output_conv);%ͳ�ƴ�������                
        %�������������ʡ���
        berconv2(i) = error_conv2;%����������
        ber(i) = error;
        berconv(i) = error_conv;
    end
    BERconv2(k) = mean(berconv2)/length_M;
    BER(k) = mean(ber)/length_M;
    BERconv(k) = mean(berconv)/length_M;
end

semilogy(EbN0db,BERconv2,'-*',EbN0db,BER,'-o',EbN0db,BERconv,'-square');
legend('(2,1,5)��������ֵ','δ����ֵ','(2,1,3)��������ֵ')
grid on
xlabel('�����dB')
ylabel('������')