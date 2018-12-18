clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board.mat')
tof_cell  = zeros(200,100,20,10);%{Receiver, Transmitter, ERate, Num, }
leng = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;

myfilename = sprintf('NoObject');
cd('\data\kwave\result\2018_08_05_no_object');
cd(myfilename)
load('rfdata.mat')
load('kgrid.mat')
tof_data = threshold_picker(rfdata,kgrid);
cd('\data\kwave\result\2018_08_08_no_object');
save(myfilename,'tof_data');
[Min,ind]= min(tof_data(101:end,:));
ind = ind+100;
for k = 1: t_num/2
    leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
end
aveSOS =sum(leng./Min)/(t_num/2);
steSOS =std(leng./Min,0,2)/sqrt(t_num/2);

cd('\data\kwave\result\2018_08_08_no_object');
myfilename = sprintf('2018_08_08_aveSOS&steSOS');
save(myfilename,'aveSOS','steSOS','tof_cell');