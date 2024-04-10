function [betaDir,betaSize,betaFlav,betaTrial,pValDir,pValSize,pValFlav,pValTrial] = LM_RunGLM_trial(response,predictor,varargin)

process_varargin(varargin);

mdl = cell(size(response,3),size(response,2));
betaDir = NaN(size(response,3),size(response,2));
betaSize = NaN(size(response,3),size(response,2));
betaFlav = NaN(size(response,3),size(response,2));%new
betaTrial = NaN(size(response,3),size(response,2));%new
pValDir = NaN(size(response,3),size(response,2));
pValSize = NaN(size(response,3),size(response,2));
pValFlav = NaN(size(response,3),size(response,2));%new
pValTrial = NaN(size(response,3),size(response,2));%new

for iC = 1:size(response,3);
    for iT = 1:size(response,2);
        mdl{iC,iT} = fitglm(predictor,response(:,iT,iC));
        betaDir(iC,iT) = mdl{iC,iT}.Coefficients.Estimate(2);
         betaSize(iC,iT) = mdl{iC,iT}.Coefficients.Estimate(3);  
         betaFlav(iC,iT) = mdl{iC,iT}.Coefficients.Estimate(4); %new
         betaTrial(iC,iT) = mdl{iC,iT}.Coefficients.Estimate(5); %new
         pValDir(iC,iT) = mdl{iC,iT}.Coefficients.pValue(2);
        pValSize(iC,iT) = mdl{iC,iT}.Coefficients.pValue(3);
        pValFlav(iC,iT) = mdl{iC,iT}.Coefficients.pValue(4);%new
        pValTrial(iC,iT) = mdl{iC,iT}.Coefficients.pValue(5);%new
        
    end
end