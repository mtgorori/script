%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 5e6;
load("H:\data\kwave\medium\2018_09_28_realisticScatter_variousIMCL\corrected\case26_IMCL4.0_IMAT_deleted_focal_depth_7.9mm.mat")
param.source.point_map = cast(linspace(50,50,1),'int8');
param.source.waveform.freq = frq;
param.t_end = 1e-04;
pathname = sprintf('/data/kwave/result/2018_11_06_IMAT_deleted_in_focal_path/case26_IMCL4.0%%_5MHz_center/');
dst_path = pathname;
simulate_usct(param, medium, dst_path);
