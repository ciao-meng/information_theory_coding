function bin = bin22dec (dec,width)
%纯十进制小数转二进制
%注意这里dec是纯十进制小数，比如0.12555555，0.46466464，0.645454
% dec = 0.25;
% width = 4;
bin=zeros(1,width);
bin1 = 0;
for i=1:width
    a=-i;
    if 2^a<=dec
        dec=dec-2^a;
        bin(i)=1;
        bin1 = bin1 + 1*10^i;
    elseif 2^a>dec
        bin(i)=0;
    end
end
