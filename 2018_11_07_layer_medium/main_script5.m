%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 5e6;

for ii = 17:20
    loadfilename = sprintf('H:/data/kwave/medium/2018_11_07_layer_medium/Layer_medium_boundary_7.9mm_ IMCL%d%%.mat',ii);
    load(loadfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('/data/kwave/result/2018_11_07_layer_medium/Layer_medium_boundary_7.9mm_ IMCL%d%%/',ii);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
end