function [C,C1] = blockcoding(G,M)
l = length(M);
[row,colum] = size(G);
I = mod(l,row);
if I ~= 0
    M = [M,zeros(1,I)];
end
M1 = reshape(M,[row,length(M)/row]);
M1 = M1.';
C1 = mod(M1*G,2);
C = reshape(C1.',1,[]);

    