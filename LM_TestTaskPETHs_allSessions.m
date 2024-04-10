function [peth,x] = LM_TestTaskPETHs_allSessions(fn,varargin);

dt = 0.05;

process_varargin(varargin);

peth = [];

if isstruct(fn{1}); %it's a list of sd structs, not file names
    for iS = 1:length(fn);
        disp(iS);
        clear tempOut
        if ~isempty(fn{iS});
            [temppeth,x] = LM_TestTaskPETHs(fn{iS},'dt',dt);
            peth = cat(1,peth,temppeth);
        end
    end
    
    
else %it's a list of file names to work everything from scratch
    
    for iS = 1:length(fn);
        disp(iS);
        clear tempOut
        sd = LM_LoadSessionData(fn{iS});
        sd = LM_ParseStrobes(sd);
        if isempty(sd.beh.sessionStartTime);
            disp('Behavior error')
        else
            [temppeth,x] = LM_TestTaskPETHs(fn{iS},'dt',dt);
            peth = cat(1,peth,temppeth);
        end
    end
end
