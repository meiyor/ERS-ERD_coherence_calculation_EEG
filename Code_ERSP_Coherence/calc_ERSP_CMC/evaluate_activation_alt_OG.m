function [p,F,pt,Ft,pt1,Ft1,pt2,Ft2,pt3,Ft3,pt4,Ft4,mdl1,mdl2,pvalv,Fvalv,pvalvr,Fvalvr,Rvall,Rvalr]=evaluate_activation_alt_OG(S,channel_ind,val_freq,lims,timev,samp_size)
close all;
close all hidden;
% %% all sample with exo-skeleton
% S{1}=load([pwd '/data_res_OG_vals_def/Subj 01_Run 4_res_vals_OG.mat']);
% S{2}=load([pwd '/data_res_OG_vals_def/Subj 02_Run 4_res_vals_OG.mat']);
% S{3}=load([pwd '/data_res_OG_vals_def/Subj 03_Run 1_res_vals_OG.mat']);
% S{4}=load([pwd '/data_res_OG_vals_def/Subj 04_Run 3_res_vals_OG.mat']);
% S{5}=load([pwd '/data_res_OG_vals_def/Subj 05_Run 1_res_vals_OG.mat']);
% S{1}=load([pwd '/probe_again_OG_zero/Subj 01_Run 4_res_vals_OG.mat']);
% S{2}=load([pwd '/probe_again_OG_zero/Subj 02_Run 4_res_vals_OG.mat']);
% S{3}=load([pwd '/probe_again_OG_zero/Subj 03_Run 1_res_vals_OG.mat']);
% S{4}=load([pwd '/probe_again_OG_zero/Subj 04_Run 3_res_vals_OG.mat']);
% S{5}=load([pwd '/probe_again_OG_zero/Subj 05_Run 1_res_vals_OG.mat']);
channel_labels={'FP1','FP2','AF3','AF4','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6', 'T7','C3','Cz','C4','T8','CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8','PO7','PO3','PO4','PO8','Oz'};
%% set the time and frequency ranges
freqvals=linspace(0,max(S{1}.freql{1}),samp_size(1));
time_vals=linspace(0,1,samp_size(2));
posbeta1=min(find(freqvals>=val_freq(1)));
posbeta2=max(find(freqvals<=val_freq(2)));
post1=min(find(time_vals>=timev(1)));
post2=max(find(time_vals<=timev(2)));

%% healthy patients first
dataHEALL=zeros([3,samp_size(1),samp_size(2)]);
dataHEALR=zeros([3,samp_size(1),samp_size(2)]);
dataHEALLch=zeros([3,32,samp_size(1),samp_size(2)]);
dataHEALRch=zeros([3,32,samp_size(1),samp_size(2)]);
dataHEALtot=zeros([3,samp_size(1),samp_size(2)]);
dataHEALtotch=zeros([3,32,samp_size(1),samp_size(2)]);

c=1;
T1L=[];
T1R=[];
T2L=[];
T2R=[];
T1Lh=[];
T1Rh=[];
T2Lh=[];
T2Rh=[];
T1Lp=[];
T1Rp=[];
T2Lp=[];
T2Rp=[];
data_val_l=[];
data_val_r=[];
for i=[2 4 5]
    dataL=S{i}.erspl;
    dataR=S{i}.erspr;
    T1L=[T1L S{i}.tl];
    T1R=[T1R S{i}.tr];
    T1Lh=[T1Lh S{i}.thl];
    T1Rh=[T1Rh S{i}.thr];
    T1Lp=[T1Lp S{i}.tpl];
    T1Rp=[T1Rp S{i}.tpr];
    dataresL=zeros([size(dataL,1),samp_size(1),samp_size(2)]);
    dataresR=zeros([size(dataR,1),samp_size(1),samp_size(2)]);
    dataresLD=zeros([size(dataL,1),size(dataL,2),samp_size(1),samp_size(2)]);
    dataresRD=zeros([size(dataR,1),size(dataR,2),samp_size(1),samp_size(2)]);
    for k=1:size(dataL,1)
        for q=1:size(dataL,2)
            if any(q==channel_ind)
                if length(channel_ind)==1
                   dataresL(k,:,:)=dataL{k,q};
                   dataresR(k,:,:)=dataR{k,q};
                   data_val_l=[data_val_l squeeze(mean(mean(mean(dataresL(k,posbeta1:posbeta2,post1:post2)))))];
                   data_val_r=[data_val_r squeeze(mean(mean(mean(dataresR(k,posbeta1:posbeta2,post1:post2)))))];
                else
                   dataresL(k,:,:)=squeeze(dataresL(k,:,:))+dataL{k,q};
                   dataresR(k,:,:)=squeeze(dataresR(k,:,:))+dataR{k,q};
                end;
                dataHEALtot(k,:,1:50)=dataresL(k,:,1:50);
                dataHEALtot(k,:,51:samp_size)=(dataresL(k,:,51:samp_size)+dataresR(k,:,1:50))/2;
            end;
            dataresLD(k,q,:,:)=dataL{k,q};
            dataresRD(k,q,:,:)=dataR{k,q};
            %dataHEALtotch(k,q,:,:)=dataresLD(k,q,:,:);
            %dataHEALtotch(k,q,:,51:samp_size)=(dataresLD(k,q,:,51:samp_size)+dataresLD(k,q,:,1:50))/2;
        end;
        if length(channel_ind)>1
           dataresL(k,:,:)=dataresL(k,:,:)./length(channel_ind);
           dataresR(k,:,:)=dataresR(k,:,:)./length(channel_ind);
            data_val_l=[data_val_l squeeze(mean(mean(mean(dataresL(k,posbeta1:posbeta2,post1:post2)))))];
            data_val_r=[data_val_r squeeze(mean(mean(mean(dataresR(k,posbeta1:posbeta2,post1:post2)))))];
        end;
    end;
    %dataresL(dataresL==0)=NaN;
    %dataresR(dataresR==0)=NaN;
    %dataHEALL(c,:,:)=mean(dataresL,1);
    %dataHEALR(c,:,:)=mean(dataresR,1);
    %dataHEALtot(c,:,:)=mean(dataresL,1);
    %dataHEALtot(c,:,samp_size(2)/2+1:samp_size(2))=nanmean((dataresR(:,:,1:samp_size(2)/2)),1);
    dataHEALLch(c,:,:,:)=mean((dataresLD),1);
    dataHEALRch(c,:,:,:)=mean((dataresRD),1);
    dataHEALtotch(c,:,:,:)=mean((dataresLD),1);
    dataHEALtotch(c,:,:,samp_size(2)/2+1:samp_size(2))=mean((dataresRD(:,:,:,1:samp_size(2)/2)),1);
    dataHEALtotch_all{c}=dataresLD;
    for k=1:size(dataL,1)
        dataHEALtotch_all{c}(k,:,:,samp_size(2)/2+1:samp_size(2))=dataresRD(k,:,:,1:samp_size(2)/2);
    end;
    %dataHEALtot(c,:,:)=2*mat2gray(dataHEALtot(c,:,:))-1;
    %dataHEALtotch(c,:,:,:)=2*mat2gray(dataHEALtotch(c,:,:,:))-1;
    c
    c=c+1;
end;
%% plotting here
figure;
imagesc(linspace(0,1,samp_size(2)),S{1}.freql{1},imgaussfilt(squeeze(mean(dataHEALtot,1)),1)/12+0.2);%(2*mat2gray(imgaussfilt(squeeze(mean(dataHEALtot,1)),1.5))-1)./2);
colormap(jet);
caxis(lims)
set(gca,'FontSize',26);
ylabel('Frequency [Hz]');
title(['Healthy ERSP [dB] - ' channel_labels{channel_ind}]);
xlabel('walking cycle');
xticks([0 0.25 0.5 0.75 1]);
xticklabels({'LTO','LHS','RTO','RHS','LTO'});
ax = gca;
ax.YDir= 'normal';
%set(gca,'Ydir','reverse')
colorbar

%% stroke patients second
dataHEALLst=zeros([2,samp_size(1),samp_size(2)]);
dataHEALRst=zeros([2,samp_size(1),samp_size(2)]);
dataHEALLchst=zeros([2,32,samp_size(1),samp_size(2)]);
dataHEALRchst=zeros([2,32,samp_size(1),samp_size(2)]);
dataHEALtotst=zeros([2,samp_size(1),samp_size(2)]);
dataHEALtotchst=zeros([2,32,samp_size(1),samp_size(2)]);
c=1;
data_val_l_st=[];
data_val_r_st=[];
for i=[1]
    dataLst=S{i}.erspl;
    dataRst=S{i}.erspr;
    T2L=[T2L S{i}.tl];
    T2R=[T2R S{i}.tr];
    T2Lh=[T2Lh S{i}.thl];
    T2Rh=[T2Rh S{i}.thr];
    T2Lp=[T2Lp S{i}.tpl];
    T2Rp=[T2Rp S{i}.tpr];
    dataresLst=zeros([size(dataLst,1),samp_size(1),samp_size(2)]);
    dataresRst=zeros([size(dataRst,1),samp_size(1),samp_size(2)]);
    dataresLDst=zeros([size(dataLst,1),size(dataLst,2),samp_size(1),samp_size(2)]);
    dataresRDst=zeros([size(dataRst,1),size(dataRst,2),samp_size(1),samp_size(2)]);
    for k=1:size(dataLst,1)
        for q=1:size(dataLst,2)
            if any(q==channel_ind)
                dataresLst(k,:,:)=dataLst{k,q};
                dataresRst(k,:,:)=dataRst{k,q};
                if length(channel_ind)==1
                   dataresLst(k,:,:)=dataLst{k,q};
                   dataresRst(k,:,:)=dataRst{k,q};
                   data_val_l_st=[data_val_l_st squeeze(mean(mean(mean(dataresLst(k,posbeta1:posbeta2,post1:post2)))))];
                   data_val_r_st=[data_val_r_st squeeze(mean(mean(mean(dataresRst(k,posbeta1:posbeta2,post1:post2)))))];
                else
                   dataresLst(k,:,:)=squeeze(dataresLst(k,:,:))+dataLst{k,q};
                   dataresRst(k,:,:)=squeeze(dataresRst(k,:,:))+dataRst{k,q};
                end;
            end;
            dataresLDst(k,q,:,:)=dataLst{k,q};
            dataresRDst(k,q,:,:)=dataRst{k,q};
        end;
        if length(channel_ind)>1
           dataresLst(k,:,:)=dataresLst(k,:,:)./length(channel_ind);
           dataresRst(k,:,:)=dataresRst(k,:,:)./length(channel_ind);
           data_val_l_st=[data_val_l_st squeeze(mean(mean(mean(dataresLst(k,posbeta1:posbeta2,post1:post2)))))];
           data_val_r_st=[data_val_r_st squeeze(mean(mean(mean(dataresRst(k,posbeta1:posbeta2,post1:post2)))))];
        end;
    end;
    dataHEALLst(c,:,:)=mean(dataresLst,1);
    dataHEALRst(c,:,:)=mean(dataresRst,1);
    dataHEALtotst(c,:,:)=mean(dataresLst,1);
    dataHEALtotst(c,:,samp_size(2)/2+1:samp_size(2))=mean(dataresRst(:,:,1:samp_size(2)/2),1);
    dataHEALLchst(c,:,:,:)=mean(dataresLDst,1);
    dataHEALRchst(c,:,:,:)=mean(dataresRDst,1);
    dataHEALtotchst(c,:,:,:)=mean(dataresLDst,1);
    dataHEALtotchst(c,:,:,samp_size(2)/2+1:samp_size(2))=mean(dataresRDst(:,:,:,1:samp_size(2)/2),1);
    dataHEALtotchst_all{c}=dataresLDst;
    for k=1:size(dataLst,1)
        dataHEALtotchst_all{c}(k,:,:,samp_size(2)/2+1:samp_size(2))=dataresRDst(k,:,:,1:samp_size(2)/2);
    end;
    c
    c=c+1;
end;
T1L(T1L>=30)=0;
T2L(T2L>=30)=0;

data_val_l(data_val_l==0)=0.1;
data_val_r(data_val_r==0)=0.1;
data_val_l_st(data_val_l_st==0)=0.1;
data_val_r_st(data_val_r_st==0)=0.1;

data_val_l(find(T1Lp>=6.5 | T1Lp==0))=0;
data_val_l_st(find(T2Lp>=6.5 | T2Lp==0))=0;
data_val_r(find(T1Rp>=6.5 | T1Rp==0))=0;
data_val_r_st(find(T2Rp>=6.5 | T2Rp==0))=0;
T1Lp(T1Lp>=6.5)=0;
T1Rp(T1Rp>=6.5)=0;
T2Lp(T2Lp>=6.5)=0;
T2Rp(T2Rp>=6.5)=0;
T1L=nonzeros(T1L)';
T2L=nonzeros(T2L)';
T1Lp=nonzeros(T1Lp);
T1Rp=nonzeros(T1Rp);
T2Lp=nonzeros(T2Lp);
T2Rp=nonzeros(T2Rp);
data_val_l=nonzeros(data_val_l);
data_val_l_st=nonzeros(data_val_l_st);
data_val_r=nonzeros(data_val_r);
data_val_r_st=nonzeros(data_val_r_st);


%% plotting here
%% fitlm to test the correlation
mdl1=fitlm([T1Lp' T2Lp'],[data_val_l'/12+0.2 data_val_l_st'./12+0.2],'RobustOpts','on');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl1,[[0.1:0.01:7.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp=anova(mdl1,'summary');
pvalv=vals_fp.pValue(2);
Fvalv=vals_fp.F(2);
Rvall=sqrt(mdl1.Rsquared.Ordinary);

plotAdjustedResponse(mdl1,'x1');
hold on
plot([0.1:0.01:7.5],ci,'r--');
%hold on;
scatter([T1Lp' T2Lp'],[data_val_l'/12+0.2 data_val_l_st'./12+0.2],120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title([channel_labels{channel_ind} '- Left R=' num2str(sqrt(mdl1.Rsquared.Ordinary))],'Interpreter','tex')
ylabel('ERSP [dB]');
xlabel('Time [s]')
grid on
set(gca,'FontSize',17);

mdl2=fitlm([T1Rp' T2Rp'],[data_val_r'/12 data_val_r_st'./12],'RobustOpts','on');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl2,[[0.1:0.01:7.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fpr=anova(mdl2,'summary');
pvalvr=vals_fpr.pValue(2);
Fvalvr=vals_fpr.F(2);
Rvalr=sqrt(mdl2.Rsquared.Ordinary);

plotAdjustedResponse(mdl2,'x1');
hold on
plot([0.1:0.01:7.5],ci,'r--');
%hold on;
scatter([T1Rp' T2Rp'],[data_val_r'/12 data_val_r_st'./12],120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title([channel_labels{channel_ind} '- Right R=' num2str(sqrt(mdl2.Rsquared.Ordinary))],'Interpreter','tex')
ylabel('ERSP [dB]');
xlabel('Time [s]')
grid on
set(gca,'FontSize',17);

figure;
imagesc(linspace(0,1,samp_size(2)),S{1}.freql{1},imgaussfilt(squeeze(mean(dataHEALtotst,1)),1)/12+0.2); %(2*mat2gray(imgaussfilt(squeeze(mean(dataHEALtotst,1)),1.5))-1)./2);
colormap(jet);
caxis(lims)
set(gca,'FontSize',26);
ylabel('Frequency [Hz]');
title(['Stroke ERSP [dB] - ' channel_labels{channel_ind}]);
xlabel('walking cycle');
xticks([0 0.25 0.5 0.75 1]);
xticklabels({'LTO','LHS','RTO','RHS','LTO'});
ax = gca;
ax.YDir= 'normal';

colorbar

%% plotting general activation

figure;
imagesc(linspace(0,1,samp_size(2)),S{1}.freql{1},(2*mat2gray(imgaussfilt(squeeze(mean(squeeze(mean(dataHEALtotch,1)),1)),2))-1)./2);
colormap(jet);
caxis(lims)
set(gca,'FontSize',26);
ylabel('Frequency [Hz]');
title(['ERSP [dB]']);
xlabel('walking cycle');
xticks([0 0.25 0.5 0.75 1]);
xticklabels({'LTO','LHS','RTO','RHS','LTO'});
colorbar;

%% Stroke

figure;
imagesc(linspace(0,1,samp_size(2)),S{1}.freql{1},(2*mat2gray(imgaussfilt(squeeze(mean(squeeze(mean(dataHEALtotchst,1)),1)),2))-1)./2);
colormap(jet);
caxis(lims)
set(gca,'FontSize',26);
ylabel('Frequency [Hz]');
title(['ERSP [dB]']);
xlabel('walking cycle');
xticks([0 0.25 0.5 0.75 1]);
xticklabels({'LTO','LHS','RTO','RHS','LTO'});
%xticks([0 1]);
%xticklabels({'IC','FC'});
colorbar;

figure;
subplot(121)
locs=readlocs('pos_10_20_for_Mater.loc');
topoplot(squeeze(mean(squeeze(mean(squeeze(mean(dataHEALtotch(:,:,posbeta1:posbeta2,post1:post2),1)),2)),2))./12+0.2,locs,'electrodes','on','electrodes','labels');
caxis([lims])
colorbar
subplot(122)
topoplot(squeeze(mean(squeeze(mean(squeeze(mean(dataHEALtotchst(:,:,posbeta1:posbeta2,post1:post2),1)),2)),2))./12+0.5,locs,'electrodes','on','electrodes','labels');
caxis([lims])
colorbar

%% plot the time analysis here
figure;
notBoxPlot([T1L,T2L],[zeros([1 length(T1L)]),ones([1 length(T2L)])],'style','sdline');
ylabel('Time [s]');
title('LTO-LTO');
xticklabels({['Healthy (' num2str(mean(T1L)) '\pm' num2str(std(T1L)) ')'],['Stroke (' num2str(mean(T2L)) '\pm' num2str(std(T2L)) ')']});
set(gca,'FontSize',16);
[pt,Ft]=anova1([T1L,T2L],[zeros([1 length(T1L)]),ones([1 length(T2L)])]);

figure;
notBoxPlot([T1Lh,T2Lh],[zeros([1 length(T1Lh)]),ones([1 length(T2Lh)])],'style','sdline');
ylabel('Time [s]');
title('LTO-LHS');
xticklabels({['Healthy (' num2str(mean(T1Lh)) '\pm' num2str(std(T1Lh)) ')'],['Stroke (' num2str(mean(T2Lh)) '\pm' num2str(std(T2Lh)) ')']});
set(gca,'FontSize',16);
[pt1,Ft1]=anova1([T1Lh,T2Lh],[zeros([1 length(T1Lh)]),ones([1 length(T2Lh)])]);


figure;
notBoxPlot([T1Rh,T2Rh],[zeros([1 length(T1Rh)]),ones([1 length(T2Rh)])],'style','sdline');
ylabel('Time [s]');
title('RTO-RHS');
xticklabels({['Healthy (' num2str(mean(T1Rh)) '\pm' num2str(std(T1Rh)) ')'],['Stroke (' num2str(mean(T2Rh)) '\pm' num2str(std(T2Rh)) ')']});
set(gca,'FontSize',16);
[pt2,Ft2]=anova1([T1Rh,T2Rh],[zeros([1 length(T1Rh)]),ones([1 length(T2Rh)])]);

figure;
notBoxPlot([T1Lp',T2Lp'],[zeros([1 length(T1Lp)]),ones([1 length(T2Lp)])],'style','sdline');
ylabel('Time [s]');
title('LHS-RTO');
xticklabels({['Healthy (' num2str(mean(T1Lp)) '\pm' num2str(std(T1Lp)) ')'],['Stroke (' num2str(mean(T2Lp)) '\pm' num2str(std(T2Lp)) ')']});
set(gca,'FontSize',16);
[pt3,Ft3]=anova1([T1Lp',T2Lp'],[zeros([1 length(T1Lp)]),ones([1 length(T2Lp)])]);

figure;
notBoxPlot([T1Rp',T2Rp'],[zeros([1 length(T1Rp)]),ones([1 length(T2Rp)])],'style','sdline');
ylabel('Time [s]');
title('RHS-LTO');
xticklabels({['Healthy (' num2str(mean(T1Rp)) '\pm' num2str(std(T1Rp)) ')'],['Stroke (' num2str(mean(T2Rp)) '\pm' num2str(std(T2Rp)) ')']});
set(gca,'FontSize',16);
[pt4,Ft4]=anova1([T1Rp',T2Rp'],[zeros([1 length(T1Rp)]),ones([1 length(T2Rp)])]);

%% statitical evaluation
valsh=squeeze(mean(mean(mean(dataHEALtotch(:,channel_ind,posbeta1:posbeta2,post1:post2),4),3),2));
valst=squeeze(mean(mean(mean(dataHEALtotchst(:,channel_ind,posbeta1:posbeta2,post1:post2),4),3),2));
figure;
[p,F]=anova1([valsh',valst'],[zeros([1 3]) ones([1 2])])
A=1;

%% calculate time outliersv
valout1=isoutlier(T1L','movmean',100,'ThresholdFactor',0.7);
valout2=isoutlier(T2L','movmean',100,'ThresholdFactor',0.7);
T1L(valout1)
T2L(valout2)
pos1=find(valout1==1)
pos2=find(valout2==1)


val_quantile=quantile([T1L T1R],0.95);
val_quantile
A=1;