%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 5e6;
for kk = 20
    for ii = 26
        myfilename = sprintf('/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/corrected/case%d_IMCL%0.1f.mat',ii,kk/10);
        load(myfilename)
        param.source.point_map = cast(linspace(1,100,100),'int8');
        param.source.waveform.freq = frq;
        param.t_end = 1e-04;
        pathname = sprintf('/data/kwave/result/2018_10_21_highFrequency_variousIMCL/case%d_IMCL%0.1f_%dMHz/',ii,kk/10,frq/1e6);
        dst_path = pathname;
        simulate_usct(param, medium, dst_path);
    end
end