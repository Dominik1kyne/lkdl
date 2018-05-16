function xx = groupsc(y,d,acnum,lambda1,lambda2,lambda3)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
xx=zeros(size(d,2),size(y,2));
spar=20;
numclass=10;subsize=200;
%********************����һ��2200ά��������ֵΪ1��lambda*****************
relam=lambda3*ones(size(d,2),1);
relam(subsize*(acnum-1)+1:subsize*acnum,1)=relam(subsize*(acnum-1)+1:subsize*acnum,1)*lambda1;
relam(subsize*numclass+1:subsize*(numclass+1),1)=relam(subsize*numclass+1:subsize*(numclass+1),1)*lambda2;
%************************************
b=size(y,2);

h=waitbar(0,'begin');
for j=1:b    %��ÿһ���������б���
    feat=y(:,j);
    solu=zeros(size(d,2),1);
    SUP=[]; IND=[];
    res=feat;
    for i=1:spar
       GRED=abs(d'*res) ; %ÿһ��ԭ�����źŵ��ڻ���
       GRED=GRED./relam;
       [~,ind]=max(GRED);
       IND=[IND ind];
       SUP=[SUP d(:,ind)];
       leastsolu=(SUP'*SUP)^(-1)*SUP'*feat;
       res=feat-SUP*leastsolu;
    end
    solu(IND,1)=leastsolu;
    xx(:,j)=solu;
    waitbar(j/b,h,['number of feature completed ' num2str(round(100*j/b)) '%'])
end
close(h);
end

