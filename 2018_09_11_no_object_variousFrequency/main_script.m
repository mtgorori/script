%% script for running the function simulate_usct
clear; close all;
frq = [1000e3, 500e3, 200e3, 100e3, 50e3];
for jj = 1:5
    myfilename = sprintf('/data/kwave/medium/2018_08_05_no_object/NoObject.mat');
    load(myfilename)
    param.source.point_map = cast(ones(1,1),'int8');
    param.source.waveform.freq = frq(jj);
    param.t_end = 1.5e-04;
    pathname = sprintf('/data/kwave/result/2018_09_11_no_object_variousFrequency/freq%d_valid',frq(jj)/1e3);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
end