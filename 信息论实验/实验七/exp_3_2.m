clc
clear all;
EbN0db = 0:4;
N = 2000;%循环次数
g0 = [1 0 1];%生成矢量1
g1 = [1 1 1];%生成矢量2
g = [g0;g1];%（2，1，3）卷积码生成矩阵
g0_1 = [1 0 0 1 1];%生成矢量1
g1_1 = [1 1 1 0 1];%生成矢量2
g_1 = [g0_1;g1_1];%（2，1，5）卷积码生成矩阵
length_M = 8;%码长
error_conv2 = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %——卷积码（2，1，5）编码过AWGN——
        C_conv2 = conv_encode21n(g0_1,g1_1,input);%编码
        Tx_conv2 = C_conv2.*2-1;%编码后调制       
        Rx_conv2 = awgn(Tx_conv2,EbN0db(k),'measured');%过AWGN信道
        R_conv2 = round((sign(Rx_conv2)+1)./2);%解调
        output_conv2 = conv_decode(g_1,1,R_conv2);%解码函数
        error_conv2 = sum(input~=output_conv2);%统计错误码数
        %——BPSK过AWGN
        Tx = input.*2-1;%未编码调制
        Rx = awgn(Tx,EbN0db(k),'measured');%未编码 过AWGN信道
        output = round((sign(Rx)+1)./2);%未编码 解调
        error = sum(input~=output);
        %——卷积码（2，1，3）编码过AWGN——
        C_conv = conv_encode21n(g0,g1,input);
        Tx_conv2 = C_conv.*2-1;
        Rx_conv = awgn(Tx_conv2,EbN0db(k),'measured');%过AWGN信道
        R_conv = round((sign(Rx_conv)+1)./2);%解调
        output_conv = conv_decode(g,1,R_conv);%解码函数
        error_conv = sum(input~=output_conv);%统计错误码数                
        %——计算误码率——
        berconv2(i) = error_conv2;%计算误码率
        ber(i) = error;
        berconv(i) = error_conv;
    end
    BERconv2(k) = mean(berconv2)/length_M;
    BER(k) = mean(ber)/length_M;
    BERconv(k) = mean(berconv)/length_M;
end

semilogy(EbN0db,BERconv2,'-*',EbN0db,BER,'-o',EbN0db,BERconv,'-square');
legend('(2,1,5)卷积码编码值','未编码值','(2,1,3)卷积码编码值')
grid on
xlabel('信噪比dB')
ylabel('误码率')