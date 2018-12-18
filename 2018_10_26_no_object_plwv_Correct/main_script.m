%% script for running the function simulate_usct
% clear; close all;
frq = [500e3];
for jj = 1
    myfilename = sprintf('/data/kwave/medium/2018_08_05_no_object/NoObject.mat');
    load(myfilename)
    param.source.point_map = cast(linspace(1,100),'int8');
    param.source.waveform.freq = frq(jj);
    param.t_end = 1.0e-04;
    pathname = sprintf('/data/kwave/result/2018_10_26_no_object_plwv_Correct/freq%dkHz',frq(jj)/1e3);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
end