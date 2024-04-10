s_di_1_mean = nanmean(s_di_1_1000.correct);%dir
s_di_2_mean = nanmean(s_di_2_1000.correct);
s_di_3_mean = nanmean(s_di_3_1000.correct);
s_di_4_mean = nanmean(s_di_4_1000.correct);
s_di_5_mean = nanmean(s_di_5_1000.correct);
s_di_6_mean = nanmean(s_di_6_1000.correct);
s_di_7_mean = nanmean(s_di_7_1000.correct);
s_di_8_mean = nanmean(s_di_8_1000.correct);
s_di_9_mean = nanmean(s_di_9_1000.correct);

s_di_10_mean = nanmean(s_di_10_1000.correct);%locations of large reward
s_di_11_mean = nanmean(s_di_11_1000.correct);
s_di_12_mean = nanmean(s_di_12_1000.correct);
s_di_13_mean = nanmean(s_di_13_1000.correct);
s_di_14_mean = nanmean(s_di_14_1000.correct);
s_di_15_mean = nanmean(s_di_15_1000.correct);%size
s_di_16_mean = nanmean(s_di_16_1000.correct);
s_di_17_mean = nanmean(s_di_17_1000.correct);
s_di_18_mean = nanmean(s_di_18_1000.correct);
s_di_19_mean = nanmean(s_di_19_1000.correct);
s_di_20_mean = nanmean(s_di_20_1000.correct);

s_di_21_mean = nanmean(s_di_21_1000.correct);
s_di_22_mean = nanmean(s_di_22_1000.correct);
s_di_23_mean = nanmean(s_di_23_1000.correct);
s_di_24_mean = nanmean(s_di_24_1000.correct);
s_di_25_mean = nanmean(s_di_25_1000.correct);
s_di_26_mean = nanmean(s_di_26_1000.correct);
s_di_27_mean = nanmean(s_di_27_1000.correct);
s_di_28_mean = nanmean(s_di_28_1000.correct);
s_di_29_mean = nanmean(s_di_29_1000.correct);%flavor
s_di_30_mean = nanmean(s_di_30_1000.correct);

s_di_31_mean = nanmean(s_di_31_1000.correct);
s_di_32_mean = nanmean(s_di_32_1000.correct);
s_di_33_mean = nanmean(s_di_33_1000.correct);
s_di_34_mean = nanmean(s_di_34_1000.correct);
s_di_35_mean = nanmean(s_di_35_1000.correct);

%%

c_di_1_mean = nanmean(c_di_1_1000.correct);%dir
c_di_2_mean = nanmean(c_di_2_1000.correct);
c_di_3_mean = nanmean(c_di_3_1000.correct);
c_di_4_mean = nanmean(c_di_4_1000.correct);
c_di_5_mean = nanmean(c_di_5_1000.correct);
c_di_6_mean = nanmean(c_di_6_1000.correct);
c_di_7_mean = nanmean(c_di_7_1000.correct);
c_di_8_mean = nanmean(c_di_8_1000.correct);
c_di_9_mean = nanmean(c_di_9_1000.correct);

c_di_10_mean = nanmean(c_di_10_1000.correct);%locations of large reward
c_di_11_mean = nanmean(c_di_11_1000.correct);
c_di_12_mean = nanmean(c_di_12_1000.correct);
c_di_13_mean = nanmean(c_di_13_1000.correct);
c_di_14_mean = nanmean(c_di_14_1000.correct);
c_di_15_mean = nanmean(c_di_15_1000.correct);%size
c_di_16_mean = nanmean(c_di_16_1000.correct);
c_di_17_mean = nanmean(c_di_17_1000.correct);
c_di_18_mean = nanmean(c_di_18_1000.correct);
c_di_19_mean = nanmean(c_di_19_1000.correct);
c_di_20_mean = nanmean(c_di_20_1000.correct);
c_di_21_mean = nanmean(c_di_21_1000.correct);
c_di_22_mean = nanmean(c_di_22_1000.correct);
c_di_23_mean = nanmean(c_di_23_1000.correct);
c_di_24_mean = nanmean(c_di_24_1000.correct);
c_di_25_mean = nanmean(c_di_25_1000.correct);
c_di_26_mean = nanmean(c_di_26_1000.correct);
c_di_27_mean = nanmean(c_di_27_1000.correct);
c_di_28_mean = nanmean(c_di_28_1000.correct);
c_di_29_mean = nanmean(c_di_29_1000.correct);%flavor
c_di_30_mean = nanmean(c_di_30_1000.correct);
c_di_31_mean = nanmean(c_di_31_1000.correct);
c_di_32_mean = nanmean(c_di_32_1000.correct);
c_di_33_mean = nanmean(c_di_33_1000.correct);
c_di_34_mean = nanmean(c_di_34_1000.correct);
c_di_35_mean = nanmean(c_di_35_1000.correct);

% for decode accuracy of latent variables only
all_s_di = cat(1,s_di_2_mean,s_di_3_mean,s_di_4_mean,s_di_5_mean,s_di_6_mean,s_di_7_mean,s_di_8_mean,s_di_9_mean,...
    s_di_11_mean,s_di_12_mean,s_di_13_mean,s_di_14_mean,s_di_16_mean,s_di_17_mean,s_di_18_mean,s_di_19_mean,s_di_20_mean,...
    s_di_21_mean,s_di_22_mean,s_di_23_mean,s_di_24_mean,s_di_25_mean,s_di_26_mean,s_di_27_mean,s_di_28_mean,s_di_30_mean,...
    s_di_31_mean,s_di_32_mean,s_di_33_mean,s_di_34_mean,s_di_35_mean);


% for decode accuracy of latent variables only
all_c_di = cat(1,c_di_2_mean,c_di_3_mean,c_di_4_mean,c_di_5_mean,c_di_6_mean,c_di_7_mean,c_di_8_mean,c_di_9_mean,...
    c_di_11_mean,c_di_12_mean,c_di_13_mean,c_di_14_mean,c_di_16_mean,c_di_17_mean,c_di_18_mean,c_di_19_mean,c_di_20_mean,...
    c_di_21_mean,c_di_22_mean,c_di_23_mean,c_di_24_mean,c_di_25_mean,c_di_26_mean,c_di_27_mean,c_di_28_mean,c_di_30_mean,...
    c_di_31_mean,c_di_32_mean,c_di_33_mean,c_di_34_mean,c_di_35_mean);


% shattering dimensionality plot- just for visualization, not one included
% in paper
figure;

plotSpread(all_s_di,'distributionColors','k','distributionMarkers','o','binwidth',0.08,'xValues',0.5);
hold on
plotSpread(all_c_di,'distributionColors','k','distributionMarkers','o','binwidth',0.08,'xValues',2);

%removed known variables, only interested in looking at latent variables
% scatter(0.5,nanmean(s_di_1_1000.correct),'bo');%dir
% scatter(0.5,nanmean(s_di_10_1000.correct),'co');%locations of large reward
% scatter(0.5,nanmean(s_di_15_1000.correct),'go');%size
% scatter(0.5,nanmean(s_di_29_1000.correct),'yo');%flavor


% scatter(2,nanmean(c_di_1_1000.correct),'bo');%dir
% scatter(2,nanmean(c_di_10_1000.correct),'co');%locations of large reward
% scatter(2,nanmean(c_di_15_1000.correct),'go');%size
% scatter(2,nanmean(c_di_29_1000.correct),'yo');%flavor


ylim([0 1]);
yticks([0.0 0.2 0.4 0.6 0.8 1.0])


chance = line([-0.5 3.0],[0.5,0.5]); %chance
chance.Color = 'black';
chance.LineStyle = '--';

box off
%legend('Latent variables','Direction','Value switch','Size','Flavor','Chance');
legend('Latent variables');

legend boxoff
xlim =([0 2.5]);
xticks([0.5 2]);
xticklabels({'Sucrose','Cocaine'});
ylabel('Proportion correct');
title('Shattering dimensionality')


%% Shattering dimensionality sucrose v. cocaine

figure
plot(all_s_di,all_c_di,'bo')
hold on
axis('square')
xlabel('Sucrose, proportion correct');
ylabel('Cocaine, proportion correct');





