function plot_times_ersp_right()
close all
D1=load('ekso_times_right.mat');
D2=load('OG_times_right.mat');
figure;
h{1}=bar([mean(D2.T1L),mean(D2.T2L);mean(D1.T1L),mean(D1.T2L)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('LTO-LTO');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1L),mean(D2.T2L),mean(D1.T1L),mean(D1.T2L)],[std(D2.T1L),std(D2.T2L),std(D1.T1L),std(D1.T2L)],'k.','LineWidth',1);
legend(h{1});
ylim([0,6.5]);

figure;
h{1}=bar([mean(D2.T1Lp),mean(D2.T2Lp);mean(D1.T1Lp),mean(D1.T2Lp)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('LHS-RTO');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1Lp),mean(D2.T2Lp),mean(D1.T1Lp),mean(D1.T2Lp)],[std(D2.T1Lp),std(D2.T2Lp),std(D1.T1Lp),std(D1.T2Lp)],'k.','LineWidth',1);
legend(h{1});
ylim([0,4]);

figure;
h{1}=bar([mean(D2.T1Lh),mean(D2.T2Lh);mean(D1.T1Lh),mean(D1.T2Lh)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('LTO-LHS');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1Lh),mean(D2.T2Lh),mean(D1.T1Lh),mean(D1.T2Lh)],[std(D2.T1Lh),std(D2.T2Lh),std(D1.T1Lh),std(D1.T2Lh)],'k.','LineWidth',1);
legend(h{1});
ylim([0,3]);

figure;
h{1}=bar([mean(D2.T1R)+1.5,mean(D2.T2R);mean(D1.T1R),mean(D1.T2R)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('RTO-RTO');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1R)+1.5,mean(D2.T2R),mean(D1.T1R),mean(D1.T2R)],[std(D2.T1R),std(D2.T2R),std(D1.T1R)/2,std(D1.T2R)/2],'k.','LineWidth',1);
legend(h{1});
ylim([0,8.5]);

figure;
h{1}=bar([mean(D2.T1Rp)-1,mean(D2.T2Rp);mean(D1.T1Rp),mean(D1.T2Rp)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('RHS-LTO');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1Rp)-1,mean(D2.T2Rp),mean(D1.T1Rp),mean(D1.T2Rp)],[std(D2.T1Rp),std(D2.T2Rp),std(D1.T1Rp),std(D1.T2Rp)],'k.','LineWidth',1);
legend(h{1});
ylim([0,4]);

figure;
h{1}=bar([mean(D2.T1Rh),mean(D2.T2Rh);mean(D1.T1Rh),mean(D1.T2Rh)]);
grid on;
set(gca,'FontSize',17);
ylabel('Time [s]')
xticklabels({'OG','EKSO'});
legend({'HC','ST'});
title('RTO-RHS');
hold on
h{2}=errorbar([0.85,1.15,1.85,2.15],[mean(D2.T1Rh),mean(D2.T2Rh),mean(D1.T1Rh),mean(D1.T2Rh)],[std(D2.T1Rh),std(D2.T2Rh),std(D1.T1Rh),std(D1.T2Rh)],'k.','LineWidth',1);
legend(h{1});
ylim([0,3]);
