clc
clear
p = 0:0.01:1;
C = 1+p.*log2(p)+(1-p).*log2(1-p);
C(1)=1;
C(end) = 1;
plot(p,C);
xlabel('概率P');
ylabel('信道容量C');
title('BSC的信道容量');