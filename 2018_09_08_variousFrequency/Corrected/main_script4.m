%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes'))
frq = [2000e3, 1000e3, 500e3, 200e3, 100e3, 50e3];
for jj = 4
    for ii = 1:25
    myfilename = sprintf('/data/kwave/medium/2018_08_10_realisticScatter/corrected/case%d.mat',ii);
    load(myfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq(jj);
    param.t_end = 1e-04;
    pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency/Corrected/case%d_Freq%d/',ii,frq(jj)/(1e3));
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
    end
end