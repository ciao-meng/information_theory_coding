clc
clear
p = 0:0.01:1;
Hp = -p.*log2(p)-(1-p).*log2(1-p);
Hp(1)=0;
Hp(end) = 0;
plot(p,Hp)
xlabel('����P');
ylabel('H(p)');
title('��Ԫ��Դ�غ�������');