clc
clear
I1 = imread('airplane_768KB_512x512.bmp');
I2 = imread('lena_768KB_512x512.bmp');
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
disp('ͼ��plane��һά��=')
disp(Hx1);

for i=0:255
    k = find(I2gray==i);
    a = length(k)./c2;
    p2(i+1) = a;
    if a ~= 0
        Hx2 = Hx2 - a*log2(a);
    end
end
disp('ͼ��lena��һά��=')
disp(Hx2);

