clc
clear all;
addpath E:\实验八材料\conv_decode
EbN0db = 0:4;
N = 2000;%循环次数
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%汉明码矩阵/生成矩阵
%卷积编码初始化
g0 = [1 0 1];%生成矢量1
g1 = [1 1 1];%生成矢量2
g = [g0;g1];%卷积码生成矩阵
%分组交织初始化
row_packet = 7;%交织矩阵的行数m
coln_packet = 4;%列数n
%卷积交织初始化
B = 4;%延迟支路数B
M = 7;%各延迟支路的单位移存器数目M
%随机交织初始化

%蒙特卡洛
length_M = 16;%码长
error_han = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);
        %——汉明码编码过AWGN——
        [C_han C1] = blockcoding(G,input);%编码
        Tx_han = C_han.*2-1;%编码后调制       
        Rx_han = awgn(Tx_han,EbN0db(k),'measured');%过AWGN信道
        R_han = round((sign(Rx_han)+1)./2);%解调
        output_han = blockdecoding(G,R_han);%解码函数
        error_han = sum(input~=output_han);%统计错误码数
        %——BPSK过AWGN——
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
        %——采用（7，4）分组交织的混合编码——
        %外编码器：（7，4）汉明码
        C_intlv = packet_intlv(C_han,row_packet,coln_packet);%交织：（7，4）分组交织
        C_conv_intlv_han = conv_encode21n(g0,g1,C_intlv);%外编码器：（2，1，3）卷积编码
        Tx_conv_intlv_han = C_conv_intlv_han.*2-1;%调制
        Rx_conv_intlv_han = awgn(Tx_conv_intlv_han,EbN0db(k),'measured');%过AWGN信道
        Rx_conv_intlv_han = round((sign(Rx_conv_intlv_han)+1)./2);%解调
        C_deconv = conv_decode(g,1,Rx_conv_intlv_han);%内译码器：（2，1，3）卷积码Viterbi硬判决译码             
        C_deintlv = packet_deintlv(C_deconv,row_packet,coln_packet);%去交织器：分组去交织
        C_deintlv = C_deintlv(1:length(R_han));
        output_packet = blockdecoding(G,C_deintlv);%外译码器：（7，4）汉明译码
        error_packet = sum(input~=output_packet);%统计错误码数   
        %——采用（4，7）卷积交织的混合编码——,TBD
        %外编码器：（7，4）汉明码
        C_convl_intlv = convl_intlv(C_han,B,M);%交织：卷积交织
        C_conv_convl_han = conv_encode21n(g0,g1,C_convl_intlv);%外编码器：（2，1，3）卷积编码
        Tx_conv_convl_han = C_conv_convl_han.*2-1;%调制
        Rx_conv_convl_han = awgn(Tx_conv_convl_han,EbN0db(k),'measured');%过AWGN信道
        Rx_conv_convl_han = round((sign(Rx_conv_convl_han)+1)./2);%解调
        C_deconv = conv_decode(g,1,Rx_conv_convl_han);%内译码器：（2，1，3）卷积码Viterbi硬判决译码             
        C_deconvl = packet_deintlv(C_deconv,row_packet,coln_packet);%去交织器：分组去交织
        C_deconvl = C_deintlv(1:length(R_han));
        output_packet = blockdecoding(G,C_deintlv);%外译码器：（7，4）汉明译码
        error_packet = sum(input~=output_packet);%统计错误码数   
        
        
        %——计算误码率——
        berhan(i) = error_han;%计算误码率
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
legend('汉明码编码值','未编码值','卷积码编码值','分组交织')
grid on