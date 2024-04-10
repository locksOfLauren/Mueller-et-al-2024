function wv = LM_InterpWaveforms(wv,varargin)

r = 10;

process_varargin(varargin);

wv = interp(wv,r);