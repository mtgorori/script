%% script for running the function simulate_usct
clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board.mat')
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
tof_cell  = zeros(200,100,20,10);%{Receiver, Transmitter, ERate, Num, }
aveSOS = zeros(20,10);%{ERate, Num}
steSOS = zeros(20,10);
leng = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
for i = 1:7
    for j = 2:2:20
        cd('\data\kwave\medium\2018_08_05_patternScatter2');
        myfilename = sprintf('rEMCL%d & nEMCL%d',j,i);
        load(myfilename);
        param.source.point_map = cast(linspace(1,100,100),'int8');
        cd('\data\kwave\result\2018_08_05_patternScatter2');
        dst_path = myfilename;
        simulate_usct(param, medium, dst_path);
        cd(myfilename)
        load('rfdata.mat')
        load('kgrid.mat')
        tof_data = get_tof_AIC_from_singleRFData(rfdata,kgrid,75);
        cd('\result\2018_08_05_analyzePatternModel2');
        save(myfilename,'tof_data');
        tof_cell(:,:,j,i) = tof_data;
        [Min,ind]= min(tof_cell(101:end,:,j,i));
        ind = ind+100;
        for k = 1: t_num/2
            leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
        end
        aveSOS(j,i) =sum(leng./Min)/(t_num/2);
        steSOS(j,i) =std(leng./Min,0,2)/sqrt(t_num/2);
    end
end

cd('\result\2018_08_05_analyzePatternModel2');
myfilename = sprintf('2018_08_05_aveSOS&steSOS_1-7');
save(myfilename,'aveSOS','steSOS','tof_cell');