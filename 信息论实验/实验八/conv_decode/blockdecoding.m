function [C] = blockdecoding(G,R)
l = length(R);
[row,colum] = size(G);
P = G(:,(row+1):end);%�������ɾ������P����
H = [P.',eye(colum-row)];%����P����У�����H
R1 = reshape(R,colum,[]);
R1 = R1.';
S = mod(R1*H.',2);%����������
for k = 1:size(S,1)
    S1 = num2str(S(k,:));%������strstrim�����ո�
    switch S1
        case '0  0  0'
            E(k,:) = [0 0 0 0 0 0 0];
        case '0  0  1'
            E(k,:) = [0 0 0 0 0 0 1];
        case '0  1  0'
            E(k,:) = [0 0 0 0 0 1 0];
        case '1  0  0'
            E(k,:) = [0 0 0 0 1 0 0];
        case '0  1  1'
            E(k,:) = [0 1 0 0 0 0 0];
        case '1  0  1'
            E(k,:) = [1 0 0 0 0 0 0];
        case '1  1  0'
            E(k,:) = [0 0 0 1 0 0 0];
        case '1  1  1'
            E(k,:) = [0 0 1 0 0 0 0];
        otherwise
            disp('����');
    end
end
C = mod(R1 + E,2);
C = C(:,1:4);
C = reshape(C.',1,[]);