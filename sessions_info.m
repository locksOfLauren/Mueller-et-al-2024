%make vector of cells coming from sessions
function[sessions, ID, nCells, Cell_sessions, SA_responses,sd_sessions,ID_Cell]= sessions_info(sd,varargin);


%free choice latency,organized, first 20

%preallocate space

sessions =[];
ID = [];
nCells = [];
Cell_sessions = [];
SA_responses = [];
sd_sessions = [];
ID_Cell=[];


for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
        %Count the number of cells in each session
       % temp_nCells = length(sd{iS}.S);
        
        
        %pull ID from fn
        temp_fn = sd{iS}.fn;
        temp_ID_Num = strfind(temp_fn,'LM');
        temp_ID = temp_fn(temp_ID_Num+2:temp_ID_Num+3);
        temp_ID= str2num(temp_ID);

                
                

ID = cat(1,ID,temp_ID);
%nCells = cat(1,nCells,temp_nCells);    
  
     
end

%sucrose sessions, DMS
% if ID(1,1)==1;
% ID_1_tot_sessions = sum(ID==1);
% ID_1_sessions = [1:ID_1_tot_sessions]';
% ID_3_tot_sessions = sum(ID==3);
% ID_3_sessions = [1:ID_3_tot_sessions]';
% ID_8_tot_sessions = sum(ID==8);
% ID_8_sessions = [1:ID_8_tot_sessions]';
% ID_10_tot_sessions = sum(ID==10);
% ID_10_sessions = [1:ID_10_tot_sessions]';
% sessions = cat(1,ID_1_sessions,ID_3_sessions,ID_8_sessions,ID_10_sessions);
% 
% 
% %sucrose infusions, total across all days
% ID1_SA_responses(ID_1_sessions,1)=768;
% ID3_SA_responses(ID_3_sessions,1)=732;
% ID8_SA_responses(ID_8_sessions,1)=651;
% ID10_SA_responses(ID_10_sessions,1)=682;
% SA_responses = cat(1,ID1_SA_responses,ID3_SA_responses,ID8_SA_responses,ID10_SA_responses);

if ID(1,1)==14;
ID_14_tot_sessions = sum(ID==14);
ID_14_sessions = [1:ID_14_tot_sessions]';
ID_16_tot_sessions = sum(ID==16);
ID_16_sessions = [1:ID_16_tot_sessions]';
ID_26_tot_sessions = sum(ID==26);
ID_26_sessions = [1:ID_26_tot_sessions]';
ID_28_tot_sessions = sum(ID==28);
ID_28_sessions = [1:ID_28_tot_sessions]';
sessions = cat(1,ID_14_sessions,ID_16_sessions,ID_26_sessions,ID_28_sessions);


%sucrose infusions, total across all days
ID14_SA_responses(ID_14_sessions,1)=670;
ID16_SA_responses(ID_16_sessions,1)=797;
ID26_SA_responses(ID_26_sessions,1)=840;
ID28_SA_responses(ID_28_sessions,1)=840;
SA_responses = cat(1,ID14_SA_responses,ID16_SA_responses,ID26_SA_responses,ID28_SA_responses);


%cocaine sessions
% elseif ID(1,1)==2;%DMS
% ID_2_tot_sessions = sum(ID==2);
% ID_2_sessions = [1:ID_2_tot_sessions]';
% ID_4_tot_sessions = sum(ID==4);
% ID_4_sessions = [1:ID_4_tot_sessions]';
% ID_5_tot_sessions = sum(ID==5);
% ID_5_sessions = [1:ID_5_tot_sessions]';
% ID_6_tot_sessions = sum(ID==6);
% ID_6_sessions = [1:ID_6_tot_sessions]';
% ID_9_tot_sessions = sum(ID==9);
% ID_9_sessions = [1:ID_9_tot_sessions]';
% sessions = cat(1,ID_2_sessions,ID_4_sessions,ID_5_sessions,ID_6_sessions,ID_9_sessions);
% 
% %cocaine infusions, total across all days
% 
% ID2_SA_responses(ID_2_sessions,1)=343;
% ID4_SA_responses(ID_4_sessions,1)=426;
% ID5_SA_responses(ID_5_sessions,1)=400;
% ID6_SA_responses(ID_6_sessions,1)=470;
% ID9_SA_responses(ID_9_sessions,1)=306;  
% SA_responses = cat(1,ID2_SA_responses,ID4_SA_responses,ID5_SA_responses,ID6_SA_responses,ID9_SA_responses);

elseif ID(1,1)==11;
ID_11_tot_sessions = sum(ID==11);
ID_11_sessions = [1:ID_11_tot_sessions]';
ID_12_tot_sessions = sum(ID==12);
ID_12_sessions = [1:ID_12_tot_sessions]';
ID_13_tot_sessions = sum(ID==13);
ID_13_sessions = [1:ID_13_tot_sessions]';
ID_21_tot_sessions = sum(ID==21);
ID_21_sessions = [1:ID_21_tot_sessions]';
sessions = cat(1,ID_11_sessions,ID_12_sessions,ID_13_sessions,ID_21_sessions);

%cocaine infusions, total across all days

ID11_SA_responses(ID_11_sessions,1)=408;
ID12_SA_responses(ID_12_sessions,1)=550;
ID13_SA_responses(ID_13_sessions,1)=395;
ID21_SA_responses(ID_21_sessions,1)=369; 
SA_responses = cat(1,ID11_SA_responses,ID12_SA_responses,ID13_SA_responses,ID21_SA_responses);

end
end

for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
        %Count the number of cells in each session
        temp_nCells = length(sd{iS}.S);
        nCells = cat(1,nCells,temp_nCells);   
    end
end
%package

%     for i = 1:length(nCells);
%     temp_Cell_sessions = nan((nCells(i)),1);
%     temp_Cell_sessions(1:nCells(i),1)=sessions(i);
%     
%     Cell_sessions = cat(1,Cell_sessions, temp_Cell_sessions);
   % end
% for iS = 1:length(sd);%for all sessions
%     if ~isempty(sd{iS});
%         
    for i = 1:length(nCells);
     temp_Cell_sessions = repmat(sessions(i),nCells(i),1);
  
    Cell_sessions = cat(1,Cell_sessions,temp_Cell_sessions);
    end
    

    for i = 1:length(nCells);
        temp_sd_sessions = repmat((i),nCells(i),1);
   
        sd_sessions = cat(1,sd_sessions,temp_sd_sessions);
        
    end
    
        for i = 1:length(nCells);
        temp_ID_Cell = repmat(ID(i),nCells(i),1);
   
        ID_Cell = cat(1,ID_Cell,temp_ID_Cell );
         end
    
% 
% end

% out.sessions = sessions;
% out.ID = ID;
% out.nCells = nCells;
% out.Cell_sessions = Cell_sessions;
% out.SA_responses = SA_responses;
    
end

