%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 5e6;
load("H:/data/kwave/medium/2018_10_21_point_medium/pointMedium.mat")
param.source.point_map = cast(linspace(1,100,100),'int8');
param.source.waveform.freq = frq;
param.t_end = 1e-04;
pathname = sprintf('H:/data/kwave/result/2018_10_21_point_medium/point_mudium5MHz');
dst_path = pathname;
simulate_usct(param, medium, dst_path);