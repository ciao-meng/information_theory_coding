clc
clear
%��ȡ�ַ���
prompt = 'input string: ';
str = input(prompt,'s');
instr = cell(1,length(str));
for k=1:length(str)
    instr{1,k} = str(k);
end
%��ʼ��
P = [];
C = [];
outp = [];
alphbt{1,1}=instr{1,1};
detec1 = [];
%���
for k = 1:(length(instr)+1)
    if k < (length(instr)+1)
        C = instr{1,k};
    else
        C = [];
    end
    
    %PC�ļ��
    I = strcat(P,C);
    for i = 1:length(alphbt)
        detec1(i) = strcmp(I,alphbt{1,i});%PC�Ƿ����ֵ���
    end
    b = find(detec1==1);
    if(isempty(b)==1)%PC�����ֵ���
        alphbt{1,i+1} = I;
        for m = 1:length(alphbt)
            detec2(m) = strcmp(P,alphbt{1,m});
        end
        c = find(detec2==1);
        if(isempty(c)==0)
            outp(k) = c;
        else
            alphbt{1,m+1} = P;
            outp(k) = m+1;
        end
        P = C;
    else%PC���ֵ���
        P = I;
        if(k == length(instr)+1)
            outp(k) = b;
        end
    end
end
outp(outp==0)=[];
disp('�������ֵ�');
x = 1:length(alphbt);
disp(x);
disp(alphbt);
disp('������');
disp(outp);

    
    
