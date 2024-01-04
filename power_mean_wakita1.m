function power_mean_wakita1

%パワースペクトル解析とスムージングに関してのプログラム

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


%for i = 2:1:9
 for i = 1:1:8



% 最初の信号
    %file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
    file_name = "eeg_eye_open_data_kai.txt"; % アイトラッカーと脳波計をつけた状態

    %file_name = strcat(pwd,"\807\C\m0\open\",char(s_epoch(j)),"_data.txt");
    EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
    


    Nx = length(EEG_data); %データの行数
    Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
    Ch_data = zscore(Ch_data); 
    nsc = floor(Nx);
    nov = floor(nsc/2);
    nff = max(256,2^nextpow2(nsc));
    [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[1:1:60],Fs);
    psdx = smoothdata(psdx);%smoothing

    %もう一つの信号
    file_name1 = "eeg_eye_close_data_kai.txt"; %脳波計のみを付けた状態
    EEG_data1 = readmatrix(file_name1);
    
    Nx1 = length(EEG_data1); %データの行数
    Ch_data1 = EEG_data1(:,i); %電極ごとのデータを抽出
    Ch_data1 = zscore(Ch_data1);
    nsc1 = floor(Nx1);
    nov1 = floor(nsc1/2);
    nff1 = max(256,2^nextpow2(nsc1));
    [psdx1,f1] = pwelch(Ch_data1,hamming(nsc1),nov1,[1:1:60],Fs);
    psdx1 = smoothdata(psdx1);%smoothing

    freq1 = f1;
    p1 = psdx1;
    freq = f;
    p = psdx;


% plot start
    subplot(4,2,i)

    plot(freq,10*log10(p),'r')
    hold on
    plot(freq1,10*log10(p1),'g')
    legend({'eyeopen','eyeclose'},'Location','southwestoutside')

    title(char(ch(i)))
    xlabel('Frequency[Hz]')
    ylabel('Power[dB]')

end