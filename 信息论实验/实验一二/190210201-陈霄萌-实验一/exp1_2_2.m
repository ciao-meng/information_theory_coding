clc
clear
I1 = imread('fruits_132KB_256x256.png');
I2 = imread('fruits_461KB_512x512.png');
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);
[L1,C1]=size(I1gray);
[L2,C2]=size(I2gray);
c1 = L1*C1;
c2 = L2*C2;
Hx1 = 0;
Hx2 = 0;
figure(1)
montage({I1, I1gray});
figure(2)
montage({I2, I2gray});

for i=0:255
    k = find(I1gray==i);
    a = length(k)./c1;
    p1(i+1) = a;
    if a ~= 0
        Hx1 = Hx1 - a*log2(a);
    end
end
disp('Í¼Ïñfruit256*256µÄÒ»Î¬ìØ=')
disp(Hx1);

for i=0:255
    k = find(I2gray==i);
    a = length(k)./c2;
    p2(i+1) = a;
    if a ~= 0
        Hx2 = Hx2 - a*log2(a);
    end
end
disp('Í¼Ïñfruit512*512µÄÒ»Î¬ìØ=')
disp(Hx2);