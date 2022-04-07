function glm_coherence_eval_left(S_OG,S_EKSO,channels,freq,muscle,phase,sel_ersp_data)
%% comment this section if you already have the data loaded
## PARAMETERS -> channels: vector of channels index depending on the channel index given in the initial analyisis, freq: frequency vector with maximum between 0 and 100Hz, muscle:1->SO, 2-> ST, 3->TA, 4-> RF, phase: select the phase to analyze in the gait cycle, sel_ersp_data: it will select the limb to analyze in the coherence analysis 0->left, right-> 1.
S_OG{1}=load([pwd '/data_res_OG_vals_formal/Subj 01_Run 4_res_coherence_OG.mat']);
S_OG{2}=load([pwd '/data_res_OG_vals_formal/Subj 02_Run 4_res_coherence_OG.mat']);
S_OG{3}=load([pwd '/data_res_OG_vals_formal/Subj 03_Run 1_res_coherence_OG.mat']);
S_OG{4}=load([pwd '/data_res_OG_vals_formal/Subj 04_Run 3_res_coherence_OG.mat']);
S_OG{5}=load([pwd '/data_res_OG_vals_formal/Subj 05_Run 1_res_coherence_OG.mat']);
S_EKSO{1}=load([pwd '/data_res_cohe_opt_formal/Subj 01_Run 3_res_coherence.mat']);
S_EKSO{2}=load([pwd '/data_res_cohe_opt_formal/Subj 02_Run 3_res_coherence.mat']);
S_EKSO{3}=load([pwd '/data_res_cohe_opt_formal/Subj 03_Run 3_res_coherence.mat']);
S_EKSO{4}=load([pwd '/data_res_cohe_opt_formal/Subj 04_Run 2_res_coherence.mat']);
S_EKSO{5}=load([pwd '/data_res_cohe_opt_formal/Subj 05_Run 1_res_coherence.mat']);
S_EKSO{6}=load([pwd '/data_res_cohe_opt_formal/Subj 06_Run 1_res_coherence.mat']);
%% select the ERSP data
if sel_ersp_data ==0 %% left
    ERSP_OG=load('data_ERSP_left_left_gamma_OG.mat');
    ERSP_EKSO=load('data_ERSP_left_left_theta_EKSO.mat');
elseif sel_ersp_data==1 %% right
    ERSP_OG=load('data_ERSP_left_right_gamma_OG.mat');
    ERSP_EKSO=load('data_ERSP_left_right_theta_EKSO.mat');
end;
T_OG=load('OG_times_left.mat');
T_EKSO=load('ekso_times_left.mat');
[p_og,F_og,data_OG]=evaluate_coherence_OG_left(S_OG,channels,freq,phase,[100,100],muscle,[0.15 0.2],0,0);
[p_ekso,F_ekso,data_EKSO]=evaluate_coherence_left(S_EKSO,channels,freq,phase,[100,100],muscle,[0.15 0.2],0,0);

%% validate time ranges
data_OG{1}(T_OG.T1L>=30)=0;
data_OG{2}(T_OG.T2L>=30)=0;
ERSP_OG.data_l_G(T_OG.T1L>=30)=0;
ERSP_OG.data_l_G_ST(T_OG.T2L>=30)=0;
T_OG.T1L(T_OG.T1L>=30)=0;
T_OG.T2L(T_OG.T2L>=30)=0;
data_OG{1}=nonzeros(data_OG{1});
data_OG_w{1}=data_OG{1};
data_OG{2}=nonzeros(data_OG{2});
data_OG_w{2}=data_OG{2};
ERSP_OG.data_l_G=nonzeros(ERSP_OG.data_l_G);
ERSP_OG.data_l_G_ST=nonzeros(ERSP_OG.data_l_G_ST);
data_OG{1}(find(T_OG.T1Lp>=6.5 | T_OG.T1Lp==0))=0;
data_OG{2}(find(T_OG.T2Lp>=6.5 | T_OG.T2Lp==0))=0;
data_OG{3}(find(T_OG.T1Rp>=6.5 | T_OG.T1Rp==0))=0;
data_OG{4}(find(T_OG.T2Rp>=6.5 | T_OG.T2Rp==0))=0;
ERSP_OG.data_val_l(find(T_OG.T1Lp>=6.5 | T_OG.T1Lp==0))=0;
ERSP_OG.data_val_l_st(find(T_OG.T2Lp>=6.5 | T_OG.T2Lp==0))=0;
ERSP_OG.data_val_r(find(T_OG.T1Rp>=6.5 | T_OG.T1Rp==0))=0;
ERSP_OG.data_val_r_st(find(T_OG.T2Rp>=6.5 | T_OG.T2Rp==0))=0;
T_OG.T1Lh(T_OG.T1Lp>=6.5)=0;
T_OG.T1Rh(T_OG.T1Rp>=6.5 | T_OG.T1Rp==0)=0;
T_OG.T2Lh(T_OG.T2Lp>=6.5)=0;
T_OG.T2Rh(T_OG.T2Rp>=6.5 | T_OG.T2Rp==0)=0;
T_OG.T1Lp(T_OG.T1Lp>=6.5)=0;
T_OG.T1Rp(T_OG.T1Rp>=6.5)=0;
T_OG.T2Lp(T_OG.T2Lp>=6.5)=0;
T_OG.T2Rp(T_OG.T2Rp>=6.5)=0;
T_OG.T1L=nonzeros(T_OG.T1L)';
T_OG.T2L=nonzeros(T_OG.T2L)';
T_OG.T1Lp=nonzeros(T_OG.T1Lp);
T_OG.T1Rp=nonzeros(T_OG.T1Rp);
T_OG.T2Lp=nonzeros(T_OG.T2Lp);
T_OG.T2Rp=nonzeros(T_OG.T2Rp);
T_OG.T1Lh=nonzeros(T_OG.T1Lh);
T_OG.T1Rh=nonzeros(T_OG.T1Rh);
T_OG.T2Lh=nonzeros(T_OG.T2Lh);
T_OG.T2Rh=nonzeros(T_OG.T2Rh);
data_OG{1}=nonzeros(data_OG{1});
data_OG{2}=nonzeros(data_OG{2});
data_OG{3}=nonzeros(data_OG{3});
data_OG{4}=nonzeros(data_OG{4});
ERSP_OG.data_val_l=nonzeros(ERSP_OG.data_val_l);
ERSP_OG.data_val_l_st=nonzeros(ERSP_OG.data_val_l_st);
ERSP_OG.data_val_r=nonzeros(ERSP_OG.data_val_r);
ERSP_OG.data_val_r_st=nonzeros(ERSP_OG.data_val_r_st);

data_EKSO{1}(T_EKSO.T1L>=30)=0;
data_EKSO{2}(T_EKSO.T2L>=30)=0;
ERSP_EKSO.data_l_G(T_OG.T1L>=30)=0;
ERSP_EKSO.data_l_G_ST(T_OG.T2L>=30)=0;
T_EKSO.T1L(T_EKSO.T1L>=30)=0;
T_EKSO.T2L(T_EKSO.T2L>=30)=0;
data_EKSO{1}=nonzeros(data_EKSO{1});
data_EKSO_w{1}=data_EKSO{1};
data_EKSO{2}=nonzeros(data_EKSO{2});
data_EKSO_w{2}=data_EKSO{2};
ERSP_EKSO.data_l_G=nonzeros(ERSP_EKSO.data_l_G);
ERSP_EKSO.data_l_G_ST=nonzeros(ERSP_EKSO.data_l_G_ST);
data_EKSO{1}(find(T_EKSO.T1Lp>=6.5 | T_EKSO.T1Lp==0))=0;
data_EKSO{2}(find(T_EKSO.T2Lp>=6.5 | T_EKSO.T2Lp==0))=0;
data_EKSO{3}(find(T_EKSO.T1Rp>=6.5 | T_EKSO.T1Rp==0))=0;
data_EKSO{4}(find(T_EKSO.T2Rp>=6.5 | T_EKSO.T2Rp==0))=0;
ERSP_EKSO.data_val_l(find(T_EKSO.T1Lp>=6.5 | T_EKSO.T1Lp==0))=0;
ERSP_EKSO.data_val_l_st(find(T_EKSO.T2Lp>=6.5 | T_EKSO.T2Lp==0))=0;
ERSP_EKSO.data_val_r(find(T_EKSO.T1Rp>=6.5 | T_EKSO.T1Rp==0))=0;
ERSP_EKSO.data_val_r_st(find(T_EKSO.T2Rp>=6.5 | T_EKSO.T2Rp==0))=0;
T_EKSO.T1Lh(T_EKSO.T1Lp>=6.5 | T_EKSO.T1Lp==0)=0;
T_EKSO.T1Rh(T_EKSO.T1Rp>=6.5 | T_EKSO.T1Rp==0)=0;
T_EKSO.T2Lh(T_EKSO.T2Lp>=6.5 | T_EKSO.T2Lp==0)=0;
T_EKSO.T2Rh(T_EKSO.T2Rp>=6.5 | T_EKSO.T2Rp==0)=0;
T_EKSO.T1Lp(T_EKSO.T1Lp>=6.5)=0;
T_EKSO.T1Rp(T_EKSO.T1Rp>=6.5)=0;
T_EKSO.T2Lp(T_EKSO.T2Lp>=6.5)=0;
T_EKSO.T2Rp(T_EKSO.T2Rp>=6.5)=0;
T_EKSO.T1L=nonzeros(T_EKSO.T1L)';
%T_EKSO.T2L=nonzeros(T_EKSO.T2L)';
T_EKSO.T1Lp=nonzeros(T_EKSO.T1Lp);
T_EKSO.T1Rp=nonzeros(T_EKSO.T1Rp);
T_EKSO.T2Lp=nonzeros(T_EKSO.T2Lp);
T_EKSO.T2Rp=nonzeros(T_EKSO.T2Rp);
T_EKSO.T1Lh=nonzeros(T_EKSO.T1Lh);
T_EKSO.T1Rh=nonzeros(T_EKSO.T1Rh);
T_EKSO.T2Lh=nonzeros(T_EKSO.T2Lh);
T_EKSO.T2Rh=nonzeros(T_EKSO.T2Rh);
data_EKSO{1}=nonzeros(data_EKSO{1});
data_EKSO{2}=nonzeros(data_EKSO{2});
data_EKSO{3}=nonzeros(data_EKSO{3});
data_EKSO{4}=nonzeros(data_EKSO{4});
ERSP_EKSO.data_val_l=nonzeros(ERSP_EKSO.data_val_l);
ERSP_EKSO.data_val_l_st=nonzeros(ERSP_EKSO.data_val_l_st);
ERSP_EKSO.data_val_r=nonzeros(ERSP_EKSO.data_val_r);
ERSP_EKSO.data_val_r_st=nonzeros(ERSP_EKSO.data_val_r_st);

%% separate corresponding values for each mdl


TL_S=[T_OG.T1Lh' T_OG.T2Lh' ];
TR_S=[T_OG.T1Rh' T_OG.T2Rh' ];

TL_S_EKSO=[T_EKSO.T1Lh' T_EKSO.T2Lh' ];
TR_S_EKSO=[T_EKSO.T1Rh' T_EKSO.T2Rh' ];


TL_OG=[T_OG.T1Lp' T_OG.T2Lp'];
data_val_L=[real(data_OG{1}') real(data_OG{2}')];
data_val_L_ERSP=[ERSP_OG.data_val_l' ERSP_OG.data_val_l_st'];

TL_EKSO=[T_EKSO.T1Lp' T_EKSO.T2Lp'];
data_val_L_EKSO=[real(data_EKSO{1}') real(data_EKSO{2}')];
data_val_L_ERSP_EKSO=[ERSP_EKSO.data_val_l' ERSP_EKSO.data_val_l_st'];


TR_OG=[T_OG.T1Rp' T_OG.T2Rp' ];
data_val_R=[real(data_OG{3}') real(data_OG{4}')];
data_val_R_ERSP=[ERSP_OG.data_val_r' ERSP_OG.data_val_r_st'];

TR_EKSO=[T_EKSO.T1Rp' T_EKSO.T2Rp'];
data_val_R_EKSO=[real(data_EKSO{3}') real(data_EKSO{4}')];
data_val_R_ERSP_EKSO=[ERSP_EKSO.data_val_r' ERSP_EKSO.data_val_r_st'];

T_T=[T_OG.T1L T_OG.T2L];
data_val_T=[real(data_OG_w{1}') real(data_OG_w{2}')];
data_val_T_ERSP=[ERSP_OG.data_l_G' ERSP_OG.data_l_G_ST'];



T_T_EKSO=[T_EKSO.T1L T_EKSO.T2L];
data_val_T_EKSO=[real(data_EKSO_w{1}') real(data_EKSO_w{2}')];
data_val_T_ERSP_EKSO=[ERSP_EKSO.data_l_G' ERSP_EKSO.data_l_G_ST'];


%% fitlm to test the correlation
mdl1=fitlm(TL_OG',data_val_L','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl1,[[0.01:0.01:7]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp=anova(mdl1,'summary');
pvalv=vals_fp.pValue(2);
Fvalv=vals_fp.F(2);
Rvall=sqrt(mdl1.Rsquared.Ordinary);


x2 = [[0.01:0.01:7], fliplr([0.01:0.01:7])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl1,'x1');
hold on
plot([0.01:0.01:7],ci,'r--');

%hold on;
scatter(TL_OG',data_val_L',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Left R=' num2str(Rvall) ' p=' num2str(pvalv)],'Interpreter','tex')
ylabel('CMC');
xlabel('LHS-RTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl2=fitlm(TR_OG',data_val_R','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl2,[[0.2:0.01:7]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp=anova(mdl2,'summary');
pvalvn=vals_fp.pValue(2);
Fvalvn=vals_fp.F(2);
Rvalln=sqrt(mdl2.Rsquared.Ordinary);


x2 = [[0.2:0.01:7], fliplr([0.2:0.01:7])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;

hold on

plotAdjustedResponse(mdl2,'x1');
hold on
plot([0.2:0.01:7],ci,'r--');

%hold on;
scatter(TR_OG',data_val_R',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Right R=' num2str(Rvalln) ' p=' num2str(pvalvn)],'Interpreter','tex')
ylabel('CMC');
xlabel('RHS-LTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl3=fitlm(T_T',data_val_T','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl3,[[0.2:0.01:8]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp=anova(mdl3,'summary');
pvalvq=vals_fp.pValue(2);
Fvalvq=vals_fp.F(2);
Rvallq=sqrt(mdl3.Rsquared.Ordinary);

x2 = [[0.2:0.01:8], fliplr([0.2:0.01:8])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl3,'x1');
hold on
plot([0.2:0.01:8],ci,'r--');
%hold on;

scatter(T_T',data_val_T',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG R=' num2str(Rvallq) ' p=' num2str(pvalvq)],'Interpreter','tex')
ylabel('CMC');
xlabel('LTO-LTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl4=fitlm(TL_EKSO',data_val_L_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl4,[[0.2:0.01:7]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp_ekso=anova(mdl4,'summary');
pvalv_ekso=vals_fp_ekso.pValue(2);
Fvalv_ekso=vals_fp_ekso.F(2);
Rvall_ekso=sqrt(mdl4.Rsquared.Ordinary);


x2 = [[0.2:0.01:7], fliplr([0.2:0.01:7])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;

hold on

plotAdjustedResponse(mdl4,'x1');
hold on
plot([0.2:0.01:7],ci,'r--');
%hold on;

scatter(TL_EKSO',data_val_L_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Left R=' num2str(Rvall_ekso) ' p=' num2str(pvalv_ekso)],'Interpreter','tex')
ylabel('CMC');
xlabel('LHS-RTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl5=fitlm(TR_EKSO',data_val_R_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl5,[[0.2:0.01:7]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp_ekso=anova(mdl5,'summary');
pvalvn_ekso=vals_fp_ekso.pValue(2);
Fvalvn_ekso=vals_fp_ekso.F(2);
Rvalln_ekso=sqrt(mdl5.Rsquared.Ordinary);

x2 = [[0.2:0.01:7], fliplr([0.2:0.01:7])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl5,'x1');
hold on
plot([0.2:0.01:7],ci,'r--');
%hold on;

scatter(TR_EKSO',data_val_R_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Right R=' num2str(Rvalln_ekso) ' p=' num2str(pvalvn_ekso)],'Interpreter','tex')
ylabel('CMC');
xlabel('RHS-LTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl6=fitlm(T_T_EKSO',data_val_T_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl6,[[0.2:0.01:8]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_fp_ekso=anova(mdl6,'summary');
pvalvq_ekso=vals_fp_ekso.pValue(2);
Fvalvq_ekso=vals_fp_ekso.F(2);
Rvallq_ekso=sqrt(mdl6.Rsquared.Ordinary);


x2 = [[0.2:0.01:8], fliplr([0.2:0.01:8])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;

hold on

plotAdjustedResponse(mdl6,'x1');
hold on
plot([0.2:0.01:8],ci,'r--');
%hold on;

scatter(T_T_EKSO',data_val_T_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO R=' num2str(Rvallq_ekso) ' p=' num2str(pvalvq_ekso)],'Interpreter','tex')
ylabel('CMC');
xlabel('LTO-LTO Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl7=fitlm(TL_S',data_val_L','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl7,[[0.1:0.01:1.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_h=anova(mdl7,'summary');
pvalh=vals_h.pValue(2);
Fvalh=vals_h.F(2);
Rvall_h=sqrt(mdl7.Rsquared.Ordinary);


x2 = [[0.1:0.01:1.5], fliplr([0.1:0.01:1.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl7,'x1');
hold on
plot([0.1:0.01:1.5],ci,'r--');
%hold on;

scatter(TL_S',data_val_L',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Left R=' num2str(Rvall_h) ' p=' num2str(pvalh)],'Interpreter','tex')
ylabel('CMC');
xlabel('LTO-LHS Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl8=fitlm(TR_S',data_val_R','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl8,[[0.1:0.01:1.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_hr=anova(mdl8,'summary');
pvalhr=vals_hr.pValue(2);
Fvalhr=vals_hr.F(2);
Rvall_hr=sqrt(mdl8.Rsquared.Ordinary);

x2 = [[0.1:0.01:1.5], fliplr([0.1:0.01:1.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on

plotAdjustedResponse(mdl8,'x1');
hold on
plot([0.1:0.01:1.5],ci,'r--');
%hold on;

scatter(TR_S',data_val_R',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Right R=' num2str(Rvall_hr) ' p=' num2str(pvalhr)],'Interpreter','tex')
ylabel('CMC');
xlabel('RTO-RHS Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl9=fitlm(TL_S_EKSO',data_val_L_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl9,[[0.1:0.01:1.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);


%% pvalues and Fvalues comp
vals_he=anova(mdl9,'summary');
pvalhe=vals_he.pValue(2);
Fvalhe=vals_he.F(2);
Rvall_he=sqrt(mdl9.Rsquared.Ordinary);

x2 = [[0.1:0.01:1.5], fliplr([0.1:0.01:1.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;

hold on

plotAdjustedResponse(mdl9,'x1');
hold on
plot([0.1:0.01:1.5],ci,'r--');
%hold on;
scatter(TL_S_EKSO',data_val_L_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Left R=' num2str(Rvall_he) ' p=' num2str(pvalhe)],'Interpreter','tex')
ylabel('CMC');
xlabel('LTO-LHS Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl10=fitlm(TR_S_EKSO',data_val_R_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl10,[[0.1:0.01:1.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);


%% pvalues and Fvalues comp
vals_her=anova(mdl10,'summary');
pvalher=vals_her.pValue(2);
Fvalher=vals_her.F(2);
Rvall_her=sqrt(mdl10.Rsquared.Ordinary);


x2 = [[0.1:0.01:1.5], fliplr([0.1:0.01:1.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl10,'x1');
hold on
plot([0.1:0.01:1.5],ci,'r--');

scatter(TR_S_EKSO',data_val_R_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Right R=' num2str(Rvall_her) ' p=' num2str(pvalher)],'Interpreter','tex')
ylabel('CMC');
xlabel('RTO-RHS Time [s]')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl11=fitlm(data_val_L_ERSP'./12+0.2,data_val_L','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl11,[[-0.8:0.001:0.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_11=anova(mdl11,'summary');
pval11=vals_11.pValue(2);
Fval11=vals_11.F(2);
Rval11=sqrt(mdl11.Rsquared.Ordinary);


x2 = [[-0.8:0.001:0.5], fliplr([-0.8:0.001:0.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl11,'x1');
hold on
plot([-0.8:0.001:0.5],ci,'r--');

%hold on;
scatter(data_val_L_ERSP'./12+0.2,data_val_L',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Left R=' num2str(Rval11) ' p=' num2str(pval11)],'Interpreter','tex')
ylabel('CMC');
xlabel('\gamma ERSP')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl12=fitlm(data_val_L_ERSP_EKSO'./12+0.2,data_val_L_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl12,[[-0.8:0.001:0.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_12=anova(mdl12,'summary');
pval12=vals_12.pValue(2);
Fval12=vals_12.F(2);
Rval12=sqrt(mdl12.Rsquared.Ordinary);


x2 = [[-0.8:0.001:0.5], fliplr([-0.8:0.001:0.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl12,'x1');
hold on
plot([-0.8:0.001:0.5],ci,'r--');

%hold on;
scatter(data_val_L_ERSP_EKSO'./12+0.2,data_val_L_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Left R=' num2str(Rval12) ' p=' num2str(pval12)],'Interpreter','tex')
ylabel('CMC');
xlabel('\theta ERSP')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl13=fitlm(data_val_R_ERSP'./12+0.2,data_val_R','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl13,[[-0.8:0.001:0.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_13=anova(mdl13,'summary');
pval13=vals_13.pValue(2);
Fval13=vals_13.F(2);
Rval13=sqrt(mdl13.Rsquared.Ordinary);


x2 = [[-0.8:0.001:0.5], fliplr([-0.8:0.001:0.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl13,'x1');
hold on
plot([-0.8:0.001:0.5],ci,'r--');

%hold on;
scatter(data_val_R_ERSP'./12+0.2,data_val_R',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['OG Right R=' num2str(Rval13) ' p=' num2str(pval13)],'Interpreter','tex')
ylabel('CMC');
xlabel('\gamma ERSP')
grid on
set(gca,'FontSize',17);

%% fitlm to test the correlation
mdl14=fitlm(data_val_R_ERSP_EKSO'./12+0.2,data_val_R_EKSO','RobustOpts','off');
figure;
%plot(mdl,'LineWidth',2.5);
[yh,ci]=predict(mdl14,[[-0.8:0.001:0.5]]','Alpha',0.05,'Simultaneous',true);
ci(:,1)=ci(:,1);

%% pvalues and Fvalues comp
vals_14=anova(mdl14,'summary');
pval14=vals_14.pValue(2);
Fval14=vals_14.F(2);
Rval14=sqrt(mdl14.Rsquared.Ordinary);


x2 = [[-0.8:0.001:0.5], fliplr([-0.8:0.001:0.5])];
inBetween = [ci(:,2)', fliplr(ci(:,1)')];
hval=fill(x2, inBetween,[17 17 17]./255);

hval.FaceAlpha = 0.15;
hold on;

plotAdjustedResponse(mdl14,'x1');
hold on
plot([-0.8:0.001:0.5],ci,'r--');

%hold on;
scatter(data_val_R_ERSP_EKSO'./12+0.2,data_val_R_EKSO',120,'bo','LineWidth',4)
legend off
set(findall(gca, 'Type', 'Line'),'LineWidth',4,'MarkerSize',10);
title(['EKSO Right R=' num2str(Rval14) ' p=' num2str(pval14)],'Interpreter','tex')
ylabel('CMC');
xlabel('\theta ERSP')
grid on
set(gca,'FontSize',17);


PVAL=bonf_holm([pvalv pvalvn pvalvq])
PVALQ=bonf_holm([pvalv_ekso pvalvn_ekso pvalvq])
