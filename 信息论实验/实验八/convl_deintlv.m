function [C_convl_deintlv] = convl_deintlv(C,B,M)
%作用：卷积去交织
%输入：交织信息序列C，延迟支路数B，各延迟支路的单位移存器数目M
%输出：卷积去交织结果

reg = zeros(1,length(C)+B*(B-1)*M);%寄存器初始化
N = ceil(length(C)/B);%计算码元周期的数目
%卷积去交织
for i = 1:N %每一个码元周期
    for k = 1:B %经过码元周期中的第k个寄存器
         reg((i-1)*B+k+(B-k)*M*B) = C((i-1)*B+k);%移位后存入寄存器
    end
end
C_convl_deintlv = reg;
% C_convl_deintlv(find(C_convl_deintlv==0))=[];%去零