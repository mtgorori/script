%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 5e6;
addpath(genpath('H:\codes'))
cd('H:\data\kwave\param')
load('param_2board.mat')
load("H:/data/configration/transducer_2board.mat");
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
% ëÄçÏA
load("H:\result\2018_12_03_DAS_correct\2018_12_04_case26\total_result.mat",'focal_point');
medium_focal_point = linspace(18,1,18)*1e-3;
medium_focal_depth = 20*1e-3 - medium_focal_point;
num_medium_focal_depth = length(medium_focal_depth);
ind_focal_point = zeros(num_medium_focal_depth,1);
for i = 1:num_medium_focal_depth
    ind_focal_point(i) = find(single(kgrid.x_vec) == single(medium_focal_point(i)));
end

for i = 4:6
    loadfilename = sprintf('H:/data/kwave/medium/2018_11_07_layer_medium/Layer_medium_boundary_%0.1fmm_ IMCL0%%.mat',medium_focal_depth(i)*1e3);
    load(loadfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('/data/kwave/result/2018_11_07_layer_medium/Layer_medium_boundary_%0.1fmm_ IMCL0%%/',medium_focal_depth(i)*1e3);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
end