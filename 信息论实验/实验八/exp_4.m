clc
clear all;
addpath E:\ʵ��˲���\conv_decode
EbN0db = 0:4;
N = 2000;%ѭ������
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%���������/���ɾ���
%��������ʼ��
g0 = [1 0 1];%����ʸ��1
g1 = [1 1 1];%����ʸ��2
g = [g0;g1];%��������ɾ���
%���齻֯��ʼ��
row_packet = 7;%��֯���������m
coln_packet = 4;%����n
%�����֯��ʼ��
B = 4;%�ӳ�֧·��B
M = 7;%���ӳ�֧·�ĵ�λ�ƴ�����ĿM
%�����֯��ʼ��

%���ؿ���
length_M = 16;%�볤
error_han = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %��������������AWGN����
        [C_han C1] = blockcoding(G,input);%����
        Tx_han = C_han.*2-1;%��������       
        Rx_han = awgn(Tx_han,EbN0db(k),'measured');%��AWGN�ŵ�
        R_han = round((sign(Rx_han)+1)./2);%���
        output_han = blockdecoding(G,R_han);%���뺯��
        error_han = sum(input~=output_han);%ͳ�ƴ�������
        %����BPSK��AWGN����
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
        %�������ã�7��4�����齻֯�Ļ�ϱ��롪��
        %�����������7��4��������
        C_intlv = packet_intlv(C_han,row_packet,coln_packet);%��֯����7��4�����齻֯
        C_conv_intlv_han = conv_encode21n(g0,g1,C_intlv);%�����������2��1��3���������
        Tx_conv_intlv_han = C_conv_intlv_han.*2-1;%����
        Rx_conv_intlv_han = awgn(Tx_conv_intlv_han,EbN0db(k),'measured');%��AWGN�ŵ�
        Rx_conv_intlv_han = round((sign(Rx_conv_intlv_han)+1)./2);%���
        C_deconv = conv_decode(g,1,Rx_conv_intlv_han);%������������2��1��3�������ViterbiӲ�о�����             
        C_deintlv = packet_deintlv(C_deconv,row_packet,coln_packet);%ȥ��֯��������ȥ��֯
        C_deintlv = C_deintlv(1:length(R_han));
        output_packet = blockdecoding(G,C_deintlv);%������������7��4����������
        error_packet = sum(input~=output_packet);%ͳ�ƴ�������   
        %�������ã�4��7�������֯�Ļ�ϱ��롪��,TBD
        %�����������7��4��������
        C_convl_intlv = convl_intlv(C_han,B,M);%��֯�������֯
        C_conv_convl_han = conv_encode21n(g0,g1,C_convl_intlv);%�����������2��1��3���������
        Tx_conv_convl_han = C_conv_convl_han.*2-1;%����
        Rx_conv_convl_han = awgn(Tx_conv_convl_han,EbN0db(k),'measured');%��AWGN�ŵ�
        Rx_conv_convl_han = round((sign(Rx_conv_convl_han)+1)./2);%���
        C_deconv = conv_decode(g,1,Rx_conv_convl_han);%������������2��1��3�������ViterbiӲ�о�����             
        C_deconvl = packet_deintlv(C_deconv,row_packet,coln_packet);%ȥ��֯��������ȥ��֯
        C_deconvl = C_deintlv(1:length(R_han));
        output_packet = blockdecoding(G,C_deintlv);%������������7��4����������
        error_packet = sum(input~=output_packet);%ͳ�ƴ�������   
        
        
        %�������������ʡ���
        berhan(i) = error_han;%����������
        ber(i) = error;
        berconv(i) = error_conv;
        berpacket(i) = error_packet;
    end
    BERhan(k) = mean(berhan)/length_M;
    BER(k) = mean(ber)/length_M;
    BERconv(k) = mean(berconv)/length_M;
    BERpacket(k) = mean(berpacket)/length_M;
end

semilogy(EbN0db,BERhan,'-*',EbN0db,BER,'-o',EbN0db,BERconv,'-square',EbN0db,BERpacket,'-+');
legend('���������ֵ','δ����ֵ','��������ֵ','���齻֯')
grid on