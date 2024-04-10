%plot of cells maximally active

%maxActive created from LM_maxActive

%PL HF, NS
% s_maxActive = s_HF_PL_max;
% c_maxActive = c_HF_PL_max;

%PL WS
% s_maxActive = s_PL_WS_max;
% c_maxActive = c_PL_WS_max;

%OFC HF, NS
% s_maxActive = s_HF_OFC_max;
% c_maxActive = c_HF_OFC_max;

%OFC WS
s_maxActive = s_OFC_WS_max;
c_maxActive = c_OFC_WS_max;


figure;


xlim([0 15]);%truncated
hold on;

%fixation

 bar(1,s_maxActive.Fixation,'b');
hold on
bar(2,c_maxActive.Fixation,'w');

%odor sampling
 bar(4,s_maxActive.OdorSampling,'b');
bar(5,c_maxActive.OdorSampling,'w');

%movement
bar(7,s_maxActive.Movement,'b');
bar(8,c_maxActive.Movement,'w');


%outcome anticipation
bar(10,s_maxActive.OutcomeAnticipation,'b');
bar(11,c_maxActive.OutcomeAnticipation,'w');

%outcome consumption
 bar(13,s_maxActive.OutcomeConsumption,'b');
bar(14,c_maxActive.OutcomeConsumption,'w');

box off;
ylabel('% of cells maximally active');
ylim([0 60])
yticks([0 15 30 45 60]);
xticks([1.5,4.5,7.5,10.5,13.5,16.5]);
xtickangle(45);
a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'}); 
set(gca, 'Ticklength', [0 0]);

legend('Sucrose','Cocaine');
legend box off;
title('OFC WS, max active per epoch')
% 
