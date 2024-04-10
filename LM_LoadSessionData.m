function [sd] = LM_LoadSessionData(fn,varargin)


process_varargin(varargin);

%load nex file
nexFile = readNexFile(fn);

%save basic info about session to output variable
sd.fn = fn;

%save behavior
sd.beh.timestamps = nexFile.markers{1}.timestamps;

sd.beh.strobes = NaN(length(nexFile.markers{1}.values{1}.strings),1);
for i = 1:length(sd.beh.strobes);
    sd.beh.strobes(i) = str2num( nexFile.markers{1}.values{1}.strings{i} );
end

%save spikes
sd.S = cell(length(nexFile.neurons),1);
sd.cellInfo = cell(length(nexFile.neurons),1);



for i = 1:length(nexFile.neurons);
    %load the actual timestamps into adrlab format
   sd.S{i} = ts(nexFile.neurons{i}.timestamps);
   
   %save some other info about cells
   sd.cellInfo{i}.name = nexFile.neurons{i}.name;
   sd.cellInfo{i}.wire = nexFile.neurons{i}.wireNumber;
   sd.cellInfo{i}.unit = nexFile.neurons{i}.unitNumber;
   sd.cellInfo{i}.waves = nexFile.waves{i}.waveforms;
   

end

%save it