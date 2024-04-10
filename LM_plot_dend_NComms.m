

timeBin = 1;
[s_OFC_popVec] = LM_McKenzie_medFR_corrMat_NComms(s_out.cellResponses_OFC_WS,'timeBin',timeBin)
s_OFC_nan = isnan(s_OFC_popVec);
s_OFC_nan = sum(s_OFC_nan,2);
s_OFC_include_popVec = s_OFC_popVec(s_OFC_nan==0,:)
s_OFC_include_popVec = normalize(s_OFC_include_popVec,2)%to zscore
s_OFC_nan = isnan(s_OFC_include_popVec);
s_OFC_nan = sum(s_OFC_nan,2);
s_OFC_include_popVec = s_OFC_include_popVec(s_OFC_nan==0,:)


[s_PL_popVec] = LM_McKenzie_medFR_corrMat_NComms(s_out.cellResponses_PL_WS,'timeBin',timeBin)
s_PL_nan = isnan(s_PL_popVec);
s_PL_nan = sum(s_PL_nan,2);
s_PL_include_popVec = s_PL_popVec(s_PL_nan==0,:)
s_PL_include_popVec = normalize(s_PL_include_popVec,2)%to zscore
s_PL_nan = isnan(s_PL_include_popVec);
s_PL_nan = sum(s_PL_nan,2);
s_PL_include_popVec = s_PL_include_popVec(s_PL_nan==0,:)



[c_OFC_popVec] = LM_McKenzie_medFR_corrMat_NComms(c_out.cellResponses_OFC_WS,'timeBin',timeBin)
c_OFC_nan = isnan(c_OFC_popVec);
c_OFC_nan = sum(c_OFC_nan,2);
c_OFC_include_popVec = c_OFC_popVec(c_OFC_nan==0,:)
c_OFC_include_popVec = normalize(c_OFC_include_popVec,2)%to zscore
c_OFC_nan = isnan(c_OFC_include_popVec);
c_OFC_nan = sum(c_OFC_nan,2);
c_OFC_include_popVec = c_OFC_include_popVec(c_OFC_nan==0,:)


[c_PL_popVec] = LM_McKenzie_medFR_corrMat_NComms(c_out.cellResponses_PL_WS,'timeBin',timeBin)
c_PL_nan = isnan(c_PL_popVec);
c_PL_nan = sum(c_PL_nan,2);
c_PL_include_popVec = c_PL_popVec(c_PL_nan==0,:)
c_PL_include_popVec = normalize(c_PL_include_popVec,2)%to zscore
c_PL_nan = isnan(c_PL_include_popVec);
c_PL_nan = sum(c_PL_nan,2);
c_PL_include_popVec = c_PL_include_popVec(c_PL_nan==0,:)




%% trees
figure
s_OFC_z = linkage(s_OFC_include_popVec','average','correlation');
dendrogram(s_OFC_z)
title('s OFC')
ylim([0.6 1.2])


figure
s_PL_z = linkage(s_PL_include_popVec','average','correlation');
dendrogram(s_PL_z)
title('s PL')
ylim([0.6 1.2])


figure
c_OFC_z = linkage(c_OFC_include_popVec','average','correlation');
dendrogram(c_OFC_z)

title('c OFC')
ylim([0.6 1.2])



figure
c_PL_z = linkage(c_PL_include_popVec','average','correlation');
dendrogram(c_PL_z)
title('c PL')
ylim([0.6 1.2])
