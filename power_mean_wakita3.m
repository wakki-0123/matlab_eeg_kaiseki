function power_mean_wakita3
%元のEEG信号にスムージングをかけたもの

% s_day = importdata("day.txt");
% s_name = importdata("subject_name.txt");
% s_epoch = importdata("epoch.txt");
Fs = 125; %サンプリング周波数
% number = 1;
% epoch = 1;
ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];
% p = zeros(1,29);
% ave_psdx = zeros(epoch,29);
% ave_f = zeros(epoch,29);
% psdx_matrix = zeros(number,number,epoch,29);
% freq_matrix = zeros(number,number,epoch,29);
%
% freq = zeros(1,29);


for i = 2:1:9



% 最初の信号
    %file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
    file_name = "ebato0-120_cut20_data.txt"; % 任意の名前

    %file_name = strcat(pwd,"\807\C\m0\open\",char(s_epoch(j)),"_data.txt");
    EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
    


    Nx = length(EEG_data); %データの行数
    Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
    Ch_data = lowpass(Ch_data,20,Fs);
    %Ch_data = zscore(Ch_data);
    % nsc = floor(Nx);
    % nov = floor(nsc/2);
    % nff = max(256,2^nextpow2(nsc));
    % [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[1.5:0.1:60],Fs);

    %もう一つの信号
    file_name1 = "ebato180-_cut15_data.txt";
    EEG_data1 = readmatrix(file_name1);
    
    Nx1 = length(EEG_data1); %データの行数
    Ch_data1 = EEG_data1(:,i); %電極ごとのデータを抽出
    Ch_data1 =lowpass(Ch_data1,20,Fs);
    % Ch_data1 = zscore(Ch_data1);
    % nsc1 = floor(Nx1);
    % nov1 = floor(nsc1/2);
    % nff1 = max(256,2^nextpow2(nsc1));
    % [psdx1,f1] = pwelch(Ch_data1,hamming(nsc1),nov1,[1.5:0.1:60],Fs);

    % freq1 = f1;
    % p1 = psdx1;
    % freq = f;
    % p = psdx;


% plot start
    subplot(4,2,i-1)

    plot(Ch_data,'r')
    hold on
    plot(Ch_data1,'g')
    xlim([0 1300]) %範囲指定
    legend({'eyetracker and EEG','EEG only'},'Location','southwestoutside')

    title(char(ch(i-1)))
    xlabel('sample')
    ylabel('EEG')

end