%% ʵ���ģ��������������ʵ��
clear all
clc

p = [0.3,0.25,0.21,0.1,0.09,0.05];%���ʷֲ�
n = length(p);

% ���������򲢻�õ�����������
code = strings(n-1,n);% ��ʼ���������̵�����
refl = zeros(n-1,n);% ��ʼ��λ�ö�Ӧ����
p1 = p;% p_SDΪÿ�εõ��ĸ�����������
for i=1:n-1           % i��ʾ�����ڼ�������
    M = length(p1);
    [p1,refl(i,1:M)] = sort(p1,'descend');% �����ʴӴ�С��������
    code(i,M) = '1';% ������С����1
    code(i,M-1) = '0';% ���ʵڶ�С�����Ҷ���Ϊ0
    p1(M-1) = p1(M-1)+p1(M);% ����������������
    p1(M)=[];
end

% ����λ�ö�Ӧ�����͵������̵����ּ����Ӧ����
CODE = strings(1,n); % ��ʼ����Ӧ����
for i=1:n
    column = i;
    for m=1:n-1
        [row,column] = find(refl(m,:)==column);
        CODE(1,i) = strcat(CODE(1,i),code(m,column));
        % ����С����������ӳ���һ��
        if column==n+1-m
            column = column-1;
        end
    end
end
CODE = reverse(CODE);

% ����ƽ���볤
for i=1:n
    L(i) = size(char(CODE(1,i)),2);
end
avelen = sum(L.*p);
H = sum(-p.*log2(p));   % ������Դ��Ϣ��
yita = H/avelen;         % �������Ч��

% չʾ������֡�ƽ���볤�ͱ���Ч��
disp('�������');
disp(CODE);
disp(['ƽ���볤= ',num2str(avelen)]);
disp(['����Ч��= ',num2str(yita)]);

