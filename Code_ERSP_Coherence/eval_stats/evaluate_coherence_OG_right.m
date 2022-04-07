function [p,F,data_sal]=evaluate_coherence_OG_right(S,channel_ind,val_freq,timev,samp_size_2d,sel,lims,sel_limb,plot_sel)
close all;
close all hidden;
%% all sample with exo-skeleton
S_OG{1}=load([pwd '/data_res_OG_vals_def/Subj 01_Run 4_res_coherence_OG.mat']);
S_OG{2}=load([pwd '/data_res_OG_vals_def/Subj 02_Run 4_res_coherence_OG.mat']);
S_OG{3}=load([pwd '/data_res_OG_vals_def/Subj 03_Run 1_res_coherence_OG.mat']);
S_OG{4}=load([pwd '/data_res_OG_vals_def/Subj 04_Run 3_res_coherence_OG.mat']);
S_OG{5}=load([pwd '/data_res_OG_vals_def/Subj 05_Run 1_res_coherence_OG.mat']);
S=S_OG;
%% Subject 6 can not walk without exo-skeleton
channel_labels={'FP1','FP2','AF3','AF4','F7','F3','Fz','F4','F8','FC5','FC1','FC2','FC6', 'T7','C3','Cz','C4','T8','CP5','CP1','CP2','CP6','P7','P3','Pz','P4','P8','PO7','PO3','PO4','PO8','Oz'};
%% set the time and frequency ranges
freqcoherence=linspace(0,100,80);
time_coherence=linspace(0,1,samp_size_2d(2));
posbeta1=min(find(freqcoherence>=val_freq(1)));
posbeta2=max(find(freqcoherence<=val_freq(2)));
post1=min(find(time_coherence>=timev(1)));
post2=max(find(time_coherence<=timev(2)));

%% healthy patients first
dataHEALL=zeros([3,80,samp_size_2d(2)]);
dataHEALR=zeros([3,80,samp_size_2d(2)]);
dataHEALLch=zeros([3,32,80,samp_size_2d(2)]);
dataHEALRch=zeros([3,32,80,samp_size_2d(2)]);
dataHEALtot=zeros([3,80,samp_size_2d(2)]);
dataHEALtotch=zeros([3,32,80,samp_size_2d(2)]);
c=1;

data_val_l=[];
data_val_r=[];

for i=[2 4 5]
    if sel==1
        dataL=S{i}.coh_SO_Ls;
        dataR=S{i}.coh_SO_Rs;
    elseif sel==2
        dataL=S{i}.coh_ST_Ls;
        dataR=S{i}.coh_ST_Rs;
    elseif sel==3
        dataL=S{i}.coh_TA_Ls;
        dataR=S{i}.coh_TA_Rs;
    elseif sel==4
        dataL=S{i}.coh_RF_Ls;
        dataR=S{i}.coh_RF_Rs;
    end;
    dataresL=zeros([size(dataL,1),80,samp_size_2d(2)]);
    dataresR=zeros([size(dataR,1),80,samp_size_2d(2)]);
    dataresLD=zeros([size(dataL,1),size(dataL,2),80,samp_size_2d(2)]);
    dataresRD=zeros([size(dataR,1),size(dataR,2),80,samp_size_2d(2)]);
    for k=1:size(dataL,1)
        for q=1:size(dataL,2)
            if any(q==channel_ind)
                if length(channel_ind)==1
                   dataresL(k,:,:)=dataL{k,q}(1:80,:);
                   dataresR(k,:,:)=dataR{k,q}(1:80,:);
                   data_val_l=[data_val_l squeeze(mean(mean(mean(dataresL(k,posbeta1:posbeta2,post1:post2)))))];
                   data_val_r=[data_val_r squeeze(mean(mean(mean(dataresR(k,posbeta1:posbeta2,post1:post2)))))];
                else
                   dataresL(k,:,:)=squeeze(dataresL(k,:,:))+dataL{k,q}(1:80,:);
                   dataresR(k,:,:)=squeeze(dataresR(k,:,:))+dataR{k,q}(1:80,:);
                end;
            end;
            dataresLD(k,q,:,:)=dataL{k,q}(1:80,:);
            dataresRD(k,q,:,:)=dataR{k,q}(1:80,:);
       
        end;
        if length(channel_ind)>1
           dataresL(k,:,:)=dataresL(k,:,:)./length(channel_ind);
           dataresR(k,:,:)=dataresR(k,:,:)./length(channel_ind);
           data_val_l=[data_val_l squeeze(mean(mean(mean(dataresL(k,posbeta1:posbeta2,post1:post2)))))];
           data_val_r=[data_val_r squeeze(mean(mean(mean(dataresR(k,posbeta1:posbeta2,post1:post2)))))];
        end;
    end;
    dataHEALL(c,:,:)=mean(dataresL,1);
    dataHEALR(c,:,:)=mean(dataresR,1);
    dataHEALtot(c,:,:)=mean(dataresL,1);
    dataHEALtot(c,:,samp_size_2d(2)/2+1:samp_size_2d(2))=mean(dataresR(:,:,1:samp_size_2d(2)/2),1);
    dataHEALLch(c,:,:,:)=mean(dataresLD,1);
    dataHEALRch(c,:,:,:)=mean(dataresRD,1);
    dataHEALtotch(c,:,:,:)=mean(dataresLD,1);
    dataHEALtotch(c,:,:,samp_size_2d(2)/2+1:samp_size_2d(2))=mean(dataresRD(:,:,:,1:samp_size_2d(2)/2),1);
    c
    c=c+1;
end;

%% stroke patients first
dataHEALLst=zeros([1,80,samp_size_2d(2)]);
dataHEALRst=zeros([1,80,samp_size_2d(2)]);
dataHEALLchst=zeros([1,32,80,samp_size_2d(2)]);
dataHEALRchst=zeros([1,32,80,samp_size_2d(2)]);
dataHEALtotst=zeros([1,80,samp_size_2d(2)]);
dataHEALtotchst=zeros([1,32,80,samp_size_2d(2)]);
c=1;

data_val_lst=[];
data_val_rst=[];

for i=[3]
    if sel==1
        dataLst=S{i}.coh_SO_Ls;
        dataRst=S{i}.coh_SO_Rs;
    elseif sel==2
        dataLst=S{i}.coh_ST_Ls;
        dataRst=S{i}.coh_ST_Rs;
    elseif sel==3
        dataLst=S{i}.coh_TA_Ls;
        dataRst=S{i}.coh_TA_Rs;
    elseif sel==4
        dataLst=S{i}.coh_RF_Ls;
        dataRst=S{i}.coh_RF_Rs;
    end;
    dataresLst=zeros([size(dataLst,1),80,samp_size_2d(2)]);
    dataresRst=zeros([size(dataRst,1),80,samp_size_2d(2)]);
    dataresLDst=zeros([size(dataLst,1),size(dataLst,2),80,samp_size_2d(2)]);
    dataresRDst=zeros([size(dataRst,1),size(dataRst,2),80,samp_size_2d(2)]);
    for k=1:size(dataLst,1)
        for q=1:size(dataLst,2)
            if any(q==channel_ind)
                if length(channel_ind)==1
                   dataresLst(k,:,:)=dataLst{k,q}(1:80,:);
                   dataresRst(k,:,:)=dataRst{k,q}(1:80,:);
                   data_val_lst=[data_val_lst squeeze(mean(mean(mean(dataresLst(k,posbeta1:posbeta2,post1:post2)))))];
                   data_val_rst=[data_val_rst squeeze(mean(mean(mean(dataresRst(k,posbeta1:posbeta2,post1:post2)))))];
                else
                   dataresLst(k,:,:)=squeeze(dataresLst(k,:,:))+dataLst{k,q}(1:80,:);
                   dataresRst(k,:,:)=squeeze(dataresRst(k,:,:))+dataRst{k,q}(1:80,:);
                end;
            end;
            dataresLDst(k,q,:,:)=dataLst{k,q}(1:80,:);
            dataresRDst(k,q,:,:)=dataRst{k,q}(1:80,:);
       
        end;
        if length(channel_ind)>1
           dataresLst(k,:,:)=dataresLst(k,:,:)./length(channel_ind);
           dataresRst(k,:,:)=dataresRst(k,:,:)./length(channel_ind);
           data_val_lst=[data_val_l squeeze(mean(mean(mean(dataresLst(k,posbeta1:posbeta2,post1:post2)))))];
           data_val_rst=[data_val_r squeeze(mean(mean(mean(dataresRst(k,posbeta1:posbeta2,post1:post2)))))];
        end;
    end;
    dataHEALLst(c,:,:)=mean(dataresLst,1);
    dataHEALRst(c,:,:)=mean(dataresRst,1);
    dataHEALtotst(c,:,:)=mean(dataresLst,1);
    dataHEALtotst(c,:,samp_size_2d(2)/2+1:samp_size_2d(2))=mean(dataresRst(:,:,1:samp_size_2d(2)/2),1);
    dataHEALLchst(c,:,:,:)=mean(dataresLDst,1);
    dataHEALRchst(c,:,:,:)=mean(dataresRDst,1);
    dataHEALtotchst(c,:,:,:)=mean(dataresLDst,1);
    dataHEALtotchst(c,:,:,samp_size_2d(2)/2+1:samp_size_2d(2))=mean(dataresRDst(:,:,:,1:samp_size_2d(2)/2),1);
    c
    c=c+1;
end;

%% save data outputs
data_sal={sqrt(data_val_l),sqrt(data_val_lst),sqrt(data_val_r),sqrt(data_val_rst)};
% 
    dataHEALL(dataHEALL<=0)=0;
    dataHEALLst(dataHEALLst<=0)=0;
    dataHEALR(dataHEALR<=0)=0;
    dataHEALRst(dataHEALRst<=0)=0;
    dataHEALLch(dataHEALLch<=0)=0;
    dataHEALLchst(dataHEALLchst<=0)=0;
    dataHEALRch(dataHEALRch<=0)=0;
    dataHEALRchst(dataHEALRchst<=0)=0;

if sel_limb==0 %% left
    data_HC=dataHEALL;
    data_ST=dataHEALLst;
    data_HC_ch=dataHEALLch;
    data_ST_ch=dataHEALLchst;
    title_h='HC - Left';
    title_s='ST - Left';
    label_s={'LTO','LHS','RTO','RHS','LTO'};
else
    data_HC=dataHEALR;
    data_ST=dataHEALRst;
    data_HC_ch=dataHEALRch;
    data_ST_ch=dataHEALRchst;
    title_h='HC - Right';
    title_s='ST - Right';
    label_s={'RTO','RHS','LTO','LHS','RTO'};
end;

if plot_sel==1

        %% plotting here
        %% healthy first
        figure;
        imagesc(linspace(0,1,samp_size_2d(2)),linspace(0,100,80),imgaussfilt(sqrt(squeeze(mean((data_HC),1))),3));
        colormap(jet);
        caxis(lims)
        set(gca,'FontSize',20);
        ylabel('Frequency [Hz]');
        title(title_h);
        xlabel('walking cycle');
        xticks([0 0.25 0.5 0.75 1]);
        xticklabels(label_s);
        colorbar;

        %% stroke second
        figure;
        imagesc(linspace(0,1,samp_size_2d(2)),linspace(0,100,80),imgaussfilt(sqrt(squeeze(mean((data_ST),1))),3));
        colormap(jet);
        caxis(lims)
        set(gca,'FontSize',20);
        ylabel('Frequency [Hz]');
        title(title_s);
        xlabel('walking cycle');
        xticks([0 0.25 0.5 0.75 1]);
        xticklabels(label_s);
        colorbar;

        %% topoplots
        figure;
        subplot(121)
        locs=readlocs('pos_10_20_for_Mater.loc');
        topoplot((squeeze(mean(squeeze(mean(sqrt(squeeze(mean(data_HC_ch(:,:,posbeta1:posbeta2,post1:post2),1))),2)),2))'),locs,'electrodes','on','electrodes','labels');
        caxis(lims)
        colorbar
        subplot(122)
        topoplot((squeeze(mean(squeeze(mean(sqrt(squeeze(mean(data_ST_ch(:,:,posbeta1:posbeta2,post1:post2),1))),2)),2))'),locs,'electrodes','on','electrodes','labels');
        caxis(lims)
        colorbar

end;
%% statitical evaluation
valsh=(squeeze(sqrt(mean(mean(mean(data_HC_ch(:,channel_ind,posbeta1:posbeta2,post1:post2),4),3),2))));
valst=(squeeze(sqrt(mean(mean(mean(data_ST_ch(:,channel_ind,posbeta1:posbeta2,post1:post2),4),3),2))));
figure;
if plot_sel==1
      [p,F]=anova1([valsh',valst'],[zeros([1 3]) ones([1 1])]);
else
      [p,F]=anova1([valsh',valst'],[zeros([1 3]) ones([1 1])],'off');
end;