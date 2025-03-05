clc
clear all;
EbN0db = 0:5;
% EbN0 = 10.^(EbN0db/10);
N = 20000;%循环次数
G = [1 0 0 0 1 0 1;0 1 0 0 0 1 1;0 0 1 0 1 1 1;0 0 0 1 1 1 0];%汉明码矩阵/生成矩阵
length_M = 32;%码长
errorde = 0;
error = 0;
for k = 1:length(EbN0db)
    for i = 1:N
        input = randi([0,1],1,length_M);        
        [C C1] = blockcoding(G,input);%编码
        Txde = C.*2-1;%编码后调制       
        Rxde = awgn(Txde,EbN0db(k),'measured');%过AWGN信道
        Rde = round((sign(Rxde)+1)./2);%解调
        outputde = blockdecoding(G,Rde);%解码函数
        errorde = sum(input~=outputde);%统计错误码数
        
        Tx = input.*2-1;%未编码调制
        Rx = awgn(Tx,EbN0db(k),'measured');%未编码 过AWGN信道
        output = round((sign(Rx)+1)./2);%未编码 解调
        error = sum(input~=output);
        
        berde(i) = errorde;%计算误码率
        ber(i) = error;
    end
%     ber_theory(k) = berawgn(EbN0db(k),'psk',2,'nondiff');%过AWGN信道的理论误码率
    BERde(k) = mean(berde)/length_M;
    BER(k) = mean(ber)/length_M;
end

semilogy(EbN0db,BERde,'-*',EbN0db,BER,'-o');
legend('编码值','未编码值')
    
