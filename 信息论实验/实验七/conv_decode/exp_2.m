clc
clear all;
EbN0db = 0:4;
N = 2000;%循环次数
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%汉明码矩阵/生成矩阵
g0 = [1 0 1];%生成矢量1
g1 = [1 1 1];%生成矢量2
g = [g0;g1];%卷积码生成矩阵
length_M = 8;%码长
error_han = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %——汉明码编码过awgn——
        [C_han C1] = blockcoding(G,input);%编码
        Tx_han = C_han.*2-1;%编码后调制       
        Rx_han = awgn(Tx_han,EbN0db(k),'measured');%过AWGN信道
        R_han = round((sign(Rx_han)+1)./2);%解调
        output_han = blockdecoding(G,R_han);%解码函数
        error_han = sum(input~=output_han);%统计错误码数
        %——BPSK过AWGN
        Tx = input.*2-1;%未编码调制
        Rx = awgn(Tx,EbN0db(k),'measured');%未编码 过AWGN信道
        output = round((sign(Rx)+1)./2);%未编码 解调
        error = sum(input~=output);
        %——卷积码编码过AWGN——
        C_conv = conv_encode21n(g0,g1,input);
        Tx_conv = C_conv.*2-1;
        Rx_conv = awgn(Tx_conv,EbN0db(k),'measured');%过AWGN信道
        R_conv = round((sign(Rx_conv)+1)./2);%解调
        output_conv = conv_decode(g,1,R_conv);%解码函数
        error_conv = sum(input~=output_conv);%统计错误码数                
        %——计算误码率——
        berhan(i) = error_han;%计算误码率
        ber(i) = error;
        berconv(i) = error_conv;
    end
    BERhan(k) = mean(berhan)/length_M;
    BER(k) = mean(ber)/length_M;
    BERconv(k) = mean(berconv)/length_M;
end

semilogy(EbN0db,BERhan,'-*',EbN0db,BER,'-o',EbN0db,BERconv,'-square');
legend('汉明码编码值','未编码值','卷积码编码值')
grid on