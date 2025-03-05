clear all
C = [1:20];%信息序列
N = 28;%随机交织长度
s = randperm(N);%随机映射关系
C_rndm_intlv = rndm_intlv(C,N,s);%随机交织
disp('交织结果：');%显示结果
disp(num2str(C_rndm_intlv));

C_rndm_deintlv = rndm_deintlv(C_rndm_intlv,N,s);%随机去交织
C_rndm_deintlv(find(C_rndm_deintlv==0))=[];%去零
disp('去交织结果：');%显示结果
disp(num2str(C_rndm_deintlv));
