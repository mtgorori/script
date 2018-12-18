%% script for running the function simulate_usct
clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
tof_cell  = zeros(200,100,25);%{Receiver, Transmitter, ERate, Num, }
aveSOS = zeros(1,25);%{ERate, Num}
steSOS = zeros(1,25);
leng = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;

for ii = 1:25
    cd('\data\kwave\medium\2018_08_10_realisticScatter');
    myfilename = sprintf('case%d',ii);
    load(myfilename);
    param.source.point_map = cast(linspace(1,100,100),'int8');
    cd('\data\kwave\result\2018_08_12_realisticScatter');
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
    cd(myfilename)
    load('rfdata.mat')
    load('kgrid.mat')
    tof_data = threshold_picker( rfdata,kgrid );
    cd('\result\2018_08_12_analyzeRealisticModel');
    save(myfilename,'tof_data');
    tof_cell(:,:,ii) = tof_data;
    [Min,ind]= min(tof_cell(101:end,:,ii));
    ind = ind+100;
    for k = 1: t_num/2
        leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
    end
    aveSOS(1,ii) =sum(leng./Min)/(t_num/2);
    steSOS(1,ii) =std(leng./Min,0,2)/sqrt(t_num/2);
end

cd('\result\2018_08_12_analyzeRealisticModel');
myfilename = sprintf('2018_08_05_aveSOS&steSOS_1-25');
save(myfilename,'aveSOS','steSOS','tof_cell');