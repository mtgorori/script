%% script for running the function simulate_usct
clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
leng = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;

cd('\data\kwave\medium\2018_08_05_no_object');
myfilename = sprintf('NoObject');
load(myfilename);
param.source.point_map = cast(linspace(1,100,100),'int8');
cd('\data\kwave\result\2018_08_05_no_object');
dst_path = myfilename;
simulate_usct(param, medium, dst_path);
cd(myfilename)
load('rfdata.mat')
load('kgrid.mat')
tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
cd('\data\kwave\result\2018_08_05_no_object');
save(myfilename,'tof_data');
[Min,ind]= min(tof_data(101:end,:));
ind = ind+100;
for k = 1: t_num/2
    leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
end
aveSOS =sum(leng./Min)/(t_num/2);
steSOS =std(leng./Min,0,2)/sqrt(t_num/2);

cd('\data\kwave\result\2018_08_05_no_object');
myfilename = sprintf('2018_08_02_aveSOS&steSOS');
save(myfilename,'aveSOS','steSOS','tof_cell');