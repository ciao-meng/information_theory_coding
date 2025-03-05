clear all
C = [1:20];%信息序列
B = 4;%延迟支路数B
M = 7;%各延迟支路的单位移存器数目M
C_convl_intlv = convl_intlv(C,B,M);
disp('卷积交织结果：');
disp(num2str(C_convl_intlv));

C_convl_deintlv = convl_deintlv(C_convl_intlv,B,M);
C_convl_deintlv(find(C_convl_deintlv==0))=[];%去零
disp('卷积去交织结果：')
disp(num2str(C_convl_deintlv));