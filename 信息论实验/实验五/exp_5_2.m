clc
clear
%读取字符串
prompt = 'input string: ';
str = input(prompt,'s');
instr = cell(1,length(str));
for k=1:length(str)
    instr{1,k} = str(k);
end
%初始化
P = [];
C = [];
outp = [];
alphbt{1,1}=instr{1,1};
detec1 = [];
%检测
for k = 1:(length(instr)+1)
    if k < (length(instr)+1)
        C = instr{1,k};
    else
        C = [];
    end
    
    %PC的检测
    I = strcat(P,C);
    for i = 1:length(alphbt)
        detec1(i) = strcmp(I,alphbt{1,i});%PC是否在字典中
    end
    b = find(detec1==1);
    if(isempty(b)==1)%PC不在字典中
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
    else%PC在字典中
        P = I;
        if(k == length(instr)+1)
            outp(k) = b;
        end
    end
end
outp(outp==0)=[];
disp('扩充后的字典');
x = 1:length(alphbt);
disp(x);
disp(alphbt);
disp('码字流');
disp(outp);

    
    
