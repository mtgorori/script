%% script for running the function simulate_usct
clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board_plnwv.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
% tof_cell  = zeros(200,25);%{Receiver, Transmitter, ERate, Num, }
aveSOS2 = 0;

steSOS2_0 = zeros(1,100);
leng = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;

cd('\data\kwave\medium\2018_08_23_no_object_large');
myfilename = sprintf('NoObject.mat');
myfilename2 = sprintf('NoObject2');
load(myfilename,'kgrid','medium');
cd('\data\kwave\result\2018_08_22_no_object_plnwv');
dst_path = myfilename2;
simulate_usct(param, medium, dst_path);
cd(myfilename)
load('rfdata.mat')
load('kgrid.mat')
tof_data = threshold_picker_plnwv( rfdata,kgrid );
cd('\result\2018_08_22_picker_validation_plnwv');
save(myfilename,'tof_data');

for k = 1: t_num/2
    leng(1,k) = norm(t_pos(:,k)-t_pos(:,100+k));
end

for jj = 1:t_num/2
    aveSOS2 = aveSOS2 + leng(1,jj)/tof_data(1,jj+100);    %tof_cell(jj+100,iii);
    steSOS2_0(1,jj) = leng(1,jj)/tof_data(1,jj+100);
end

aveSOS2 = aveSOS2/(t_num/2);
steSOS2 = std(steSOS2_0)/sqrt(t_num/2);
cd('\result\2018_08_22_picker_validation_plnwv');
myfilename = sprintf('2018_08_22_aveSOS&steSOS_no_object');
save(myfilename,'aveSOS2','steSOS2');