function [] = plot_dPrime_shaded(s,c,varargin);

% s = sucrose dprime values
%c = cocaine dprime values

s_dividers = NaN(length(s.dp_choiceType),1)
s_choice = [s.dp_choiceType(:,9:13)  s_dividers s.dp_choiceType(:,14:18)  s_dividers s.dp_choiceType(:,19:23)  s_dividers s.dp_choiceType(:,24:28) s_dividers s.dp_choiceType(:,29:end) s_dividers]
s_dir = [s.dp_dir(:,9:13)  s_dividers s.dp_dir(:,14:18)  s_dividers s.dp_dir(:,19:23) s_dividers  s.dp_dir(:,24:28) s_dividers  s.dp_dir(:,29:end) s_dividers]
s_size = [s.dp_size(:,9:13)  s_dividers s.dp_size(:,14:18)  s_dividers s.dp_size(:,19:23)  s_dividers s.dp_size(:,24:28)  s_dividers s.dp_size(:,29:end) s_dividers]
s_flav = [s.dp_flav(:,9:13)  s_dividers s.dp_flav(:,14:18)  s_dividers s.dp_flav(:,19:23)  s_dividers s.dp_flav(:,24:28)  s_dividers s.dp_flav(:,29:end) s_dividers]

s_choice_shuff = [s.dp_choiceType_shuff(:,9:13)  s_dividers s.dp_choiceType_shuff(:,14:18)  s_dividers s.dp_choiceType_shuff(:,19:23)  s_dividers s.dp_choiceType_shuff(:,24:28)  s_dividers s.dp_choiceType_shuff(:,29:end) s_dividers]
s_dir_shuff = [s.dp_dir_shuff(:,9:13)  s_dividers s.dp_dir_shuff(:,14:18)  s_dividers s.dp_dir_shuff(:,19:23)  s_dividers s.dp_dir_shuff(:,24:28)  s_dividers s.dp_dir_shuff(:,29:end) s_dividers]
s_size_shuff = [s.dp_size_shuff(:,9:13)  s_dividers s.dp_size_shuff(:,14:18)  s_dividers s.dp_size_shuff(:,19:23)  s_dividers s.dp_size_shuff(:,24:28)  s_dividers s.dp_size_shuff(:,29:end) s_dividers]
s_flav_shuff = [s.dp_flav_shuff(:,9:13)  s_dividers s.dp_flav_shuff(:,14:18)  s_dividers s.dp_flav_shuff(:,19:23)  s_dividers s.dp_flav_shuff(:,24:28)  s_dividers s.dp_flav_shuff(:,29:end) s_dividers]

figure
subplot(2,4,[1,2]);
shadedErrorBar([],s_choice,{@mean,@nanstderr},'lineprops',{'ro','MarkerFaceColor','r'})
hold on
shadedErrorBar([],s_dir,{@mean,@nanstderr},'lineprops',{'bo','MarkerFaceColor','b'})
shadedErrorBar([],s_size,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[0,0.60,0.29],'MarkerFaceColor',[0,0.60,0.29]})
shadedErrorBar([],s_flav,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[1,0.87,0.1],'MarkerFaceColor',[1,0.87,0.1]})



plot(nanmean(s_choice_shuff),'r:');
plot(nanmean(s_dir_shuff),'b:');
plot(nanmean(s_size_shuff),':','Color',[0,0.60,0.29]);
plot(nanmean(s_flav_shuff),':','Color',[1,0.87,0.1]);

ylabel('d prime');
title('Sucrose')
xlim([-1 33])
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
legend('Choice type','Direction','Size','Flavor','Choice type shuff','Direction shuff','Size shuff','Flavor shuff','Location','northwest');
legend boxoff

% cocaine main plot

c_dividers = NaN(length(c.dp_choiceType),1)
c_choice = [c.dp_choiceType(:,9:13)  c_dividers c.dp_choiceType(:,14:18)  c_dividers c.dp_choiceType(:,19:23)  c_dividers c.dp_choiceType(:,24:28) c_dividers c.dp_choiceType(:,29:end) c_dividers]
c_dir = [c.dp_dir(:,9:13)  c_dividers c.dp_dir(:,14:18)  c_dividers c.dp_dir(:,19:23) c_dividers  c.dp_dir(:,24:28) c_dividers  c.dp_dir(:,29:end) c_dividers]
c_size = [c.dp_size(:,9:13)  c_dividers c.dp_size(:,14:18)  c_dividers c.dp_size(:,19:23)  c_dividers c.dp_size(:,24:28)  c_dividers c.dp_size(:,29:end) c_dividers]
c_flav = [c.dp_flav(:,9:13)  c_dividers c.dp_flav(:,14:18)  c_dividers c.dp_flav(:,19:23)  c_dividers c.dp_flav(:,24:28)  c_dividers c.dp_flav(:,29:end) c_dividers]

c_choice_shuff = [c.dp_choiceType_shuff(:,9:13)  c_dividers c.dp_choiceType_shuff(:,14:18)  c_dividers c.dp_choiceType_shuff(:,19:23)  c_dividers c.dp_choiceType_shuff(:,24:28)  c_dividers c.dp_choiceType_shuff(:,29:end) c_dividers]
c_dir_shuff = [c.dp_dir_shuff(:,9:13)  c_dividers c.dp_dir_shuff(:,14:18)  c_dividers c.dp_dir_shuff(:,19:23)  c_dividers c.dp_dir_shuff(:,24:28)  c_dividers c.dp_dir_shuff(:,29:end) c_dividers]
c_size_shuff = [c.dp_size_shuff(:,9:13)  c_dividers c.dp_size_shuff(:,14:18)  c_dividers c.dp_size_shuff(:,19:23)  c_dividers c.dp_size_shuff(:,24:28)  c_dividers c.dp_size_shuff(:,29:end) c_dividers]
c_flav_shuff = [c.dp_flav_shuff(:,9:13)  c_dividers c.dp_flav_shuff(:,14:18)  c_dividers c.dp_flav_shuff(:,19:23)  c_dividers c.dp_flav_shuff(:,24:28)  c_dividers c.dp_flav_shuff(:,29:end) c_dividers]

subplot(2,4,[3,4]);
shadedErrorBar([],c_choice,{@mean,@nanstderr},'lineprops',{'ro','MarkerFaceColor','w'})
hold on
shadedErrorBar([],c_dir,{@mean,@nanstderr},'lineprops',{'bo','MarkerFaceColor','w'})
shadedErrorBar([],c_size,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[0,0.60,0.29],'MarkerFaceColor','w'})
shadedErrorBar([],c_flav,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[1,0.87,0.1],'MarkerFaceColor','w'})



plot(nanmean(c_choice_shuff),'r:');
plot(nanmean(c_dir_shuff),'b:');
plot(nanmean(c_size_shuff),':','Color',[0,0.60,0.29]);
plot(nanmean(c_flav_shuff),':','Color',[1,0.87,0.1]);

ylabel('d prime');
title('Cocaine')
xlim([-1 33])
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
legend('Choice type','Direction','Size','Flavor','Choice type shuff','Direction shuff','Size shuff','Flavor shuff','Location','northwest');
legend boxoff

%% individual plots

% choice
subplot(2,4,5);
shadedErrorBar([],s_choice,{@mean,@nanstderr},'lineprops',{'ro','MarkerFaceColor','r'})
hold on
shadedErrorBar([],c_choice,{@mean,@nanstderr},'lineprops',{'ro','MarkerFaceColor','w'})
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
title('Choice type')
ylabel('d prime');
box off
legend('Sucrose','Cocaine','Location','northwest');
legend boxoff

% dir
subplot(2,4,6);
shadedErrorBar([],s_dir,{@mean,@nanstderr},'lineprops',{'bo','MarkerFaceColor','b'})
hold on
shadedErrorBar([],c_dir,{@mean,@nanstderr},'lineprops',{'bo','MarkerFaceColor','w'})
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
title('Direction')
ylabel('d prime');
box off
legend('Sucrose','Cocaine','Location','northwest');
legend boxoff

% size
subplot(2,4,7);
shadedErrorBar([],s_size,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[0,0.60,0.29],'MarkerFaceColor',[0,0.60,0.29]})
hold on
shadedErrorBar([],c_size,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[0,0.60,0.29],'MarkerFaceColor','w'})
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
title('Size')
ylabel('d prime');
box off
legend('Sucrose','Cocaine','Location','northwest');
legend boxoff

%flavor
subplot(2,4,8);
shadedErrorBar([],s_flav,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[1,0.87,0.1],'MarkerFaceColor',[1,0.87,0.1]})
hold on
shadedErrorBar([],c_flav,{@mean,@nanstderr},'lineprops',{'Marker','o','Color',[1,0.87,0.1],'MarkerFaceColor','w'})
ylim([-0.3 1.5])
yticks([-0.3 0.0 0.3 0.6 0.9 1.2 1.5])
set(gca,'xtick',[])
box off
title('Flavor')
ylabel('d prime');
box off
legend('Sucrose','Cocaine','Location','northwest');
legend boxoff


end
