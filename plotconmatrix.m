%%
addpath('E:\����\piotr_toolbox_V3.02\toolbox\matlab')
cliptypes = { 'anger','disgust','fear','joy','sadness','surprise' };

 cm=[1 0 0 0 0 0;
     0.02 0.97 0.01 0 0 0;
     0 0 1 0 0 0;
     0 0 0 1 0 0
     0 0 0 0 1 0;
     0 0 0 0 0 1];
 figure,
a=subplot(1,3,1);
 confmatrix_show( cm, cliptypes, {'FontSize',12} )
% set(gcf,'Position',[100 100 200 200]);
%  set(gca,'Position',[.4 .1 .8 .6]);
%  
% set(gcf,'Position',[100 100 200 200]);
%  set(gca,'Position',[.20 .17 .80 .74]);
PPP=get(a,'pos');%��NN����ͼ�ĵ�ǰλ��
PPP(1)=PPP(1)-0.04;%���ұ���չ0.04
PPP(4)=PPP(4)+0.07;%���ұ���չ0.04
% %PPP(4)=PPP(4)+0.03;;%���Ϸ���չ0.03
set(a,'Position',PPP)%�����µı߽����á�
%  
 %%
 
 cm=[0.58 0.3 .12 0 0 0;
     .02 .98 0 0 0 0;
     .12 .05 .83 0 0 0;
     0 0 0 1 0 0;
     .05 0 0 0 .95 0;
     0 0 0 0 0 1];
b=subplot(1,3,2);
 confmatrix_show( cm, cliptypes, {'FontSize',12} )
 PPP=get(b,'pos');%��NN����ͼ�ĵ�ǰλ��
PPP(4)=PPP(4)+0.07;%���ұ���չ0.04
%PPP(4)=PPP(4)+0.03;;%���Ϸ���չ0.03
set(b,'Position',PPP)%�����µı߽����á�
 %set(gcf,'Position',[100 100 200 200]);
 %set(gca,'Position',[.20 .17 .80 .74]);
%  set(gca,'Position',[.2 .1 .80 .7]);
 %%
 cm=[1 0 0 0 0 0;
     .15 .85 0 0 0 0;
     0 .15 .85 0 0 0;
     0 0 0 1 0 0
     .20 0 .20 0 .6 0 ;
     0 0 0 0  0 1];
c=subplot(1,3,3);
  confmatrix_show( cm, cliptypes, {'FontSize',12})
  PPP=get(c,'pos');%��NN����ͼ�ĵ�ǰλ��
PPP(1)=PPP(1)+0.04;%���ұ���չ0.04
PPP(4)=PPP(4)+0.07;%���ұ���չ0.04
%PPP(4)=PPP(4)+0.03;;%���Ϸ���չ0.03
set(c,'Position',PPP)%�����µı߽����á�



%%
cliptypes={ 'Bend','Jack','F-jump','P-jump','Run','S-walk' ,'Skip','Walk','Wave1','Wave2'};
cm=[1 0 0 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0;
     0 0 0 .97 .02 .01 0 0 0 0;
     0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0;
     0 0 0 0 0 0 1 0 0 0;
     0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 0 .99 .01;
     0 0 0 0 0 0 0 0 0 1];
  confmatrix_show( cm, cliptypes, {'FontSize',12} )
  set(gcf,'Position',[100 100 200 200]);
 set(gca,'Position',[.20 .17 .7 .74]);
 