%*********************************** ���ĳ����д��¼*******************
% 1 �����дһ������trainconca��ѵ�������ֵ䣬1 2 3 ������11 ����11Ϊ���оֲ�����ѵ���������ֵ䣬Ȼ�󱣴��ڵ�ǰĿ¼
% 2 ϡ����� ����
% 3 �ֵ����
%
%
%
%
%
%
%
%
%
%
%
%
%
%*********************************************************************
clc,clear;
load 'data\concatenatdic.mat';    %DD
load 'data\traindescriptor.mat';  %trlowdimfeat
%******************************** ѵ���ֵ� ***************************
%*********************************************************************
%    ��һ���֣�ϡ����� ***********************************

%****************** ��������*************************
NUMCLASS=10;
subsize=size(DD,2)/(NUMCLASS+1);          %2200/11
lam1=.8;
lam2=.8;
lam3=1.2;
beta=.01;
numiter=15;


%****************�����������***********************

%  **************    ����ʼ   ***********

%  ע�͵� date 2016 09 18 

XX=cell(1,NUMCLASS);
% for i=1:NUMCLASS
%     XX{1,i}=zeros(size(DD,2),size(trlowdimfeat{1,i},2));
% end
objvalue=zeros(numiter,1);

%**********************************************************************
%*****��һ��ѭ����ѵ���ֵ���̣�����ϡ�������ֵ����********************
for iter=11:numiter
fprintf('iter %d/%d\n',iter,numiter);
tic;
for i=1:10
    Y=trlowdimfeat{1,i};  % ĳһ��Ϊ�Ľ�ά���ݡ�
    scmode=2;
    switch scmode;
        case 0
            X=fistpga(Y,DD,NUMCLASS,i,lam1,lam2,lam3);  %�Ƚ��ݶȣ�fista     Ч����
        case 0.5
            X=fistff(Y,DD,NUMCLASS,i,lam1,lam2,lam3);  %fista  �Ľ��汾���������� ��������lambdaֵ�й�
         % ���������������   
            
        case 1
            X=pga(Y,DD,NUMCLASS,i,lam1,lam2,lam3);    % ϡ����룺 �Ƚ��ݶȣ�����ִ��   Ч����
        case 2
            X=groupsc(Y,DD,i,lam1,lam2,lam3);         %̰���㷨
    end
%     %*****************************************
%     test=0;               % ����ϵ���Ƿ����ֲ�
%     if(test)
%       subsize=200; numclass=10;
%       d=zeros(1,numclass);
%       for mm=1:numclass+1
%           d(1,mm)=nnz(X((mm-1)*subsize+1:mm*subsize,:));
%       end
%       bar(d);
%     end
%     %*****************************************
    XX{1,i}=X;
%   save('data\sparcodesXX.mat' , 'XX');
fprintf('sparse coding completed :  class %d/%d\n',i,NUMCLASS);
end

%***************************** ����proximal gradient algorithm ϡ�����
%***************************��дһ������ pga
% y=trlowdimfeat{1,1}(:,1);
% x=fistpga(y,DD,10,1);
% plot(x);











%***********************************************************
%    �ڶ����� �ֵ���� **************************************
  for mm=1:NUMCLASS
      Y=trlowdimfeat{1,mm};  % ĳһ��Ϊ�Ľ�ά���ݡ�
      D2=DD;
      D1=DD(:,(mm-1)*200+1:mm*200);
      D2(:,(mm-1)*200+1:mm*200)=[];
      CX=XX{1,mm};
      CX1=CX((mm-1)*200+1:mm*200,:);
%       CX((mm-1)*200+1:mm*200,:)=[];
%     
%       newY=Y-D2*CX;  %�����Ż�  |newY-D1*CX1|^2+ |D1'*D2|^2
      % use sylvester equation
 
     % CC=newY*CX1';
       CC=Y*CX1'; %Ч�����ã�����ֱ�ӱƽ�Y,�ӿ��ٶȿ���ע�͵�����7��
      AA=beta*D2*D2';
      BB=CX1*CX1';
      solu=sylvester(AA,BB,CC);
      DD(:,(mm-1)*200+1:mm*200)=solu;
      fprintf('dictioanry update completed %d/10 \n ',mm);
  end
  
 % *******************�ֵ��һ��,��Ӧϵ��Ҳ�仯******************
 %************************�ǳ���Ҫ*****************************
 for ni=1:size(DD,2)
     normcol=norm(DD(:,ni),2);
     DD(:,ni)=DD(:,ni)/(normcol+eps);   
 end
  
 
 %******** Ŀ�꺯��ֵ
fobj=0;
 for ii=1:NUMCLASS
     Y=trlowdimfeat{1,ii};
     coeff=XX{1,ii};
     valuerec=norm(Y-DD*coeff,'fro')^2;  % ���ݱ�����
     
     % ***********************************�ͷ��һ����
     coeff1=coeff((ii-1)*subsize+1:ii*subsize,:);
     valuecoeff1=sum(sum(abs(coeff1)));
     coeff2=coeff(NUMCLASS*subsize+1:(NUMCLASS+1)*200,:);
     valuecoeff2=sum(sum(abs(coeff2)));
     valuecoeff3=sum(sum(abs(coeff)))-valuecoeff1-valuecoeff2;
     
     %******************* inchohenrence term
     D2=DD;
     D1=DD(:,(ii-1)*200+1:ii*200);
     D2(:,(ii-1)*200+1:ii*200)=[];
     valueincohe=norm(D1'*D2,'fro')^2;
     %******************* fobj Ŀ�꺯��ֵ
     fobj=valuerec+lam1*valuecoeff1+lam2*valuecoeff2+lam3*valuecoeff3+beta*valueincohe;
 end
 objvalue(iter,1)=fobj;
 timcount=toc;
 fprintf('time used %d\n',timcount);
 plot(objvalue);
 
end    % end*********�����ֵ�ѵ���ĵ���ѭ��*********************




%*******************ʶ��׶�**************************date: 2016 09 21
%**********************************************************************
load 'data\testfe.mat';                    %  testfeat{1,10}
for i=1:NUMCLASS
    testf=testfeat{1,i};
    fprintf('true label %d ',i);
    label=recog(testf,DD,NUMCLASS); 
    fprintf('recognized as %d \n',label);
end

















