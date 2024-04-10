function [out] = LM_Cortex_RSA_ensemble_d(cellResponses,varargin)


nCells = [100];
nBoot = 250; %bootstraps over which neurons are in the pseudoensemble
minTrials = 1;
process_varargin(varargin);


%get some info
nCells_in = size(cellResponses,1);
nTime = size(cellResponses,2);
nType = size(cellResponses,3);
% 
% %preallocate
dp_choiceType = NaN(nBoot,nTime);
dp_dir = NaN(nBoot,nTime);
dp_size = NaN(nBoot,nTime);
dp_flav = NaN(nBoot,nTime);

%loop over bootstraps of which cells are selected

for iB = 1:nBoot;
    tempCorr = NaN(minTrials,nTime);
    for iT = 1:nTime;
        
        %select cells and trials
        
        cellResponses_temp = squeeze(cellResponses(:,iT,:));
        
        %count minimum trials per cell
        minTrialsxCell = min(cellfun(@length,cellResponses_temp),[],2);
        bad = minTrialsxCell<minTrials;
        
        cellResponses_temp = cellResponses_temp(~bad,:);
        
        %pick the cells we want to include
        ix_cell = randperm(length(cellResponses_temp))';
        cellResponses_corr = cellResponses_temp(ix_cell,:);
        cellResponses_corr = cellResponses_corr(1:nCells,:);
        
%calculate the median FR per ensembles, create pop vector
temp_popVec = cellfun(@nanmedian,cellResponses_corr);%compute median FR, unit number x trial type matrix

% %get rid of nans and z score
temp_popVec_nan = isnan(temp_popVec);
temp_popVec_nan = sum(temp_popVec_nan,2);
temp_include_popVec = temp_popVec(temp_popVec_nan==0,:);
temp_include_popVec = normalize(temp_include_popVec,2);%to zscore
temp_popVec_nan = isnan(temp_include_popVec);
temp_popVec_nan = sum(temp_popVec_nan,2);
temp_include_popVec= temp_include_popVec(temp_popVec_nan==0,:);


[cMat]= corrcoef(temp_include_popVec,'Rows','complete');

%% correlations, take within and between factors of variables to create distributions for d'

%choice type 
within_choice =cMat([2 3 4 5 6 7 8 19 20 21 22 23 24 36 37 38 39 40 53 54 55 56 70 71 72 87 88 104 138 139 140 141 142 143 144 155 ...
    156 157 158 159 160 172 173 174 175 176 189 190 191 192 206 207 208 223 224 240]);
mean_within_choice = nanmean(within_choice);

between_choice = cMat([9 10 11 12 13 14 15 16 25 26 27 28 29 30 31 32 41 42 43 44 45 46 47 48 57 58 59 ...
    60 61 62 63 64 73 74 75 76 77 78 79 80 89 90 91 92 93 94 95 96 105 106 107 108 109 110 111 112 121 122 123 124 125 126 127 128]);
mean_between_choice = nanmean(between_choice);

choice_std= max(std(within_choice),std(between_choice));% find highest sd
d_choiceType = (mean_within_choice-mean_between_choice)/choice_std;


% choice type, shuffle

all_choice = cat(1,within_choice',between_choice');%get all values assc within and between factor of interest
all_choice_shuff = all_choice(randperm(length(all_choice)));%shuffle all of the values

within_choice_shuff = all_choice_shuff(1:length(within_choice)); %assign appropriate number of shuffled values to within distributions, should be 56 values
between_choice_shuff =all_choice_shuff(length(within_choice)+1:end);;%assign remaining shuffled values to within distributions, should be 64 values

mean_within_choice_shuff = nanmean(within_choice_shuff);
mean_between_choice_shuff = nanmean(between_choice_shuff);
choice_std_shuff= max(std(within_choice_shuff),std(between_choice_shuff));% find highest sd
d_choiceType_shuff = (mean_within_choice_shuff-mean_between_choice_shuff)/choice_std_shuff;


%%

%direction
within_dir =cMat([2 3 4 19 20 36 70 71 72 87 88 104 138 139 140 155 156 172 206 207 208 ...
223 224 240 9 10 11 12 25 26 27 28 41 42 43 44 57 58 59 60 77 78 79 80 93 94 95 96 109 110 111 112 125 126 127 128]);
mean_within_dir = nanmean(within_dir);

between_dir = cMat([5 6 7 8 21 22 23 24 37 38 39 40 53 54 55 56 141 142 143 144 157 158 159 160 173 174 175 176 189 190 ...
    191 192 13 14 15 16 29 30 31 32 45 46 47 48 61 62 63 64 73 74 75 76 89 90 91 92 105 106 107 108 121 122 123 124]);
mean_between_dir = nanmean(between_dir);

dir_std= max(std(within_dir),std(between_dir));
d_direction = (mean_within_dir-mean_between_dir)/dir_std;

%direction, shuffle

all_dir = cat(1,within_dir',between_dir');%get all values assc within and between factor of interest
all_dir_shuff = all_dir(randperm(length(all_dir)));%shuffle all of the values

within_dir_shuff = all_dir_shuff(1:length(within_dir)); %assign appropriate number of shuffled values to within distributions, should be 56 values
between_dir_shuff =all_dir_shuff(length(within_dir)+1:end);;%assign remaining shuffled values to within distributions, should be 64 values

mean_within_dir_shuff = nanmean(within_dir_shuff);
mean_between_dir_shuff = nanmean(between_dir_shuff);
dir_std_shuff= max(std(within_dir_shuff),std(between_dir_shuff));% find highest sd
d_direction_shuff = (mean_within_dir_shuff-mean_between_dir_shuff)/dir_std_shuff;


%size 
within_size =cMat([2 36 70 104 138 172 206 240 9 10 25 26 43 44 59 60 77 78 93 94 111 112 127 128 5 6 21 22 39 40 55 56 141 ...
    142 157 158 175 176 191 192 13 14 29 30 47 48 63 64 73 74 89 90 107 108 123 124]);
mean_within_size = nanmean(within_size);

between_size =cMat([3 4 19 20 71 72 87 88 139 140 155 156 207 208 223 224 11 12 27 28 41 42 57 58 79 80 95 96 109 110 125 126 ...
    7 8 23 24 37 38 53 54 143 144 159 160 173 174 189 190 15 16 31 32 45 46 61 62 75 76 91 92 105 106 121 122]);
mean_between_size = nanmean(between_size);

size_std= max(std(within_size),std(between_size));
d_size = (mean_within_size-mean_between_size)/size_std;

all_size = cat(1,within_size',between_size');%get all values assc within and between factor of interest
all_size_shuff = all_size(randperm(length(all_size)));%shuffle all of the values

within_size_shuff = all_size_shuff(1:length(within_size)); %assign appropriate number of shuffled values to within distributions, should be 56 values
between_size_shuff =all_size_shuff(length(within_size)+1:end);;%assign remaining shuffled values to within distributions, should be 64 values

mean_within_size_shuff = nanmean(within_size_shuff);
mean_between_size_shuff = nanmean(between_size_shuff);
size_std_shuff= max(std(within_size_shuff),std(between_size_shuff));% find highest sd
d_size_shuff = (mean_within_size_shuff-mean_between_size_shuff)/size_std_shuff;


%flavor
within_flav =cMat([3 20 71 88 139 156 207 224 9 11 26 28 41 43 58 60 77 79 94 111 126 128 5 7 22 24 37 39 54 56 141 143 158 160 173 ...
    175 190 192 13 15 30 32 45 47 62 64 73 75 90 92 105 107 122 124 96 109]);
mean_within_flav = nanmean(within_flav);

between_flav = cMat([2 4 19 36 70 72 87 104 138 140 155 172 206 208 223 240 10 12 25 27 42 44 57 59 78 80 93 95 110 112 125 127 6 ...
    8 21 23 38 40 53 55 142 144 157 159 174 176 189 191 14 16 29 31 46 48 61 63 74 76 89 91 106 108 121 123]);
mean_between_flav = nanmean(between_flav);


flav_std= max(std(within_flav),std(between_flav));
d_flav = (mean_within_flav-mean_between_flav)/flav_std;

all_flav = cat(1,within_flav',between_flav');%get all values assc within and between factor of interest
all_flav_shuff = all_flav(randperm(length(all_flav)));%shuffle all of the values

within_flav_shuff = all_flav_shuff(1:length(within_flav)); %assign appropriate number of shuffled values to within distributions, should be 56 values
between_flav_shuff =all_flav_shuff(length(within_flav)+1:end);;%assign remaining shuffled values to within distributions, should be 64 values

mean_within_flav_shuff = nanmean(within_flav_shuff);
mean_between_flav_shuff = nanmean(between_flav_shuff);
flav_std_shuff= max(std(within_flav_shuff),std(between_flav_shuff));% find highest sd
d_flav_shuff = (mean_within_flav_shuff-mean_between_flav_shuff)/flav_std_shuff;


        
        dp_choiceType(iB,iT) = d_choiceType;
        dp_dir(iB,iT) = d_direction;
        dp_size(iB,iT) = d_size;
        dp_flav(iB,iT) = d_flav;
        
        dp_choiceType_shuff(iB,iT) = d_choiceType_shuff;
        dp_dir_shuff(iB,iT) = d_direction_shuff;
        dp_size_shuff(iB,iT) = d_size_shuff;
        dp_flav_shuff(iB,iT) = d_flav_shuff;
        
    end  
    disp(iB)
end


%package actual outputs from function


out.dp_choiceType = dp_choiceType;
out.dp_dir = dp_dir;
out.dp_size = dp_size;
out.dp_flav = dp_flav;
out.dp_choiceType_shuff = dp_choiceType_shuff;
out.dp_dir_shuff = dp_dir_shuff;
out.dp_size_shuff = dp_size_shuff;
out.dp_flav_shuff = dp_flav_shuff;
