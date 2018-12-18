%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))

frq = 5e6;
for kk = 40
    myfilename = sprintf('/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/corrected/case26_IMCL%0.1f_pure.mat',kk/10);
    load(myfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('/data/kwave/result/2018_11_11_case26_variousIMCL/case26_IMCL%0.1f_pure/',kk/10);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
end