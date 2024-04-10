function [out] = LM_Cortex_dichotomyClassify_time_NComms(cellResponses,varargin);

%parpool('local');


nCells = length(cellResponses);
nBoot = 1000; 
minTrials = 15;
shuffle = false;
process_varargin(varargin);

%get some info
nCells_in = size(cellResponses,1);
nTime = size(cellResponses,2);
nType = size(cellResponses,3);

%preallocate
pred_class = cell(nTime,1);
class = cell(nTime,1);
correct = NaN(nBoot,nTime);




for iB = 1:nBoot;

   
    for iT = 1:nTime;
        
        %select cells and trials
        
        cellResponses_temp = squeeze(cellResponses(:,iT,:));
        
        %count minimum trials per cell
        minTrialsxCell = min(cellfun(@length,cellResponses_temp),[],2);
        bad = minTrialsxCell<minTrials;     
        cellResponses_temp = cellResponses_temp(~bad,:);


        bad2 = cellfun(@sum,cellResponses_temp);%find cells that didn't fire
        bad2 = sum(bad2,2) == 0;
        cellResponses_temp = cellResponses_temp(~bad2,:);
        nCells = length(cellResponses_temp);


        cellResponses_classify = cellResponses_temp;

        %pick the trials to include from each cell
        allTest = [];
        allTrain = [];
        for iC = 1:length(cellResponses_classify);
            temp_allTest = [];
            temp_allTrain = [];

            for iType = 1:nType;
                take_15 = randperm(length(cellResponses_classify{iC,iType}));
                take_15 = take_15(1:15);
                temp_takeTrials = cellResponses_classify{iC,iType}(take_15);
                tempTrainSet = temp_takeTrials(1:10);
                tempTestSet = temp_takeTrials(11:15);
                ix_trialTrain = randi(10,10000,1);
                ix_trialTest = randi(5,1000,1);
                temp_allTest = cat(1,temp_allTest,tempTestSet(ix_trialTest));
                temp_allTrain = cat(1,temp_allTrain,tempTrainSet(ix_trialTrain));

            end

            mu=nanmean(temp_allTrain);
            calc_std = nanstd(temp_allTrain);

            if mu>0 & calc_std>0;
                temp_allTrain = (temp_allTrain - mu)./calc_std;
                temp_allTest = (temp_allTest - mu)./calc_std;

                allTest = cat(2,allTest,temp_allTest);
                allTrain = cat(2,allTrain,temp_allTrain);
            end
        end



        %re-format cellResponses for classifier
     
        train_trueClass = cat(1,ones(10000,1),...
            ones(10000,1).*1,...
            ones(10000,1).*1,...
            ones(10000,1).*1,...%
            ones(10000,1).*2,...
            ones(10000,1).*2,...
            ones(10000,1).*2,...
            ones(10000,1).*2);

        test_trueClass = cat(1,ones(1000,1),...
            ones(1000,1).*1,...
            ones(1000,1).*1,...
            ones(1000,1).*1,...%
            ones(1000,1).*2,...
            ones(1000,1).*2,...
            ones(1000,1).*2,...
            ones(1000,1).*2);





%change
        if shuffle==1;
            ix = randperm(length(allTrain));
            allTrain  = allTrain(ix,:);
        end

        Mdl = fitcsvm(allTrain,train_trueClass);%SVM, with linear kernel as default, change back

       

                pred_class_temp=predict(Mdl,allTest);
           


        %package for this bootstrap
        pred_class{iT} = cat(1,pred_class{iT},pred_class_temp);
        class{iT} = cat(1,class{iT},test_trueClass);
        
        classify_corr = pred_class_temp == test_trueClass;
        proportion_corr = sum(classify_corr)/length(classify_corr);
           
        correct(iB,iT) = proportion_corr;
    end  
    disp(iB)
end


%package actual outputs from function

out.correct = correct;


