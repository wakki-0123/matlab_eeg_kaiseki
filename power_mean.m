function power_mean

% s_day = importdata("day.txt");
% s_name = importdata("subject_name.txt");
% s_epoch = importdata("epoch.txt");
Fs = 125; %サンプリング周波数
number = 1;
epoch = 1;
ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];
p = zeros(1,29);
freq = zeros(2,30);
ave_psdx = zeros(epoch,29);
ave_f = zeros(epoch,29);
psdx_matrix = zeros(number,number,epoch,29);
freq_matrix = zeros(number,number,epoch,29);

    for i = 2:1:9
        
        for subject_i = 1:1:number %被験者+日付の制御
            
            for j = 1:1:epoch
                %file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
                file_name = "b_10_data.txt";
                %file_name = strcat(pwd,"\807\C\m0\open\",char(s_epoch(j)),"_data.txt");
                EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
                Nx = length(EEG_data); %データの行数
                Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
                Ch_data = zscore(Ch_data);
                nsc = floor(Nx);
                nov = floor(nsc/2);
                nff = max(256,2^nextpow2(nsc));
                [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[2:1:30],Fs);

                % ave_psdx(j,:) = psdx;
                % ave_f(j,:) = f;
            
            end
        end
        

            % p = mean(ave_psdx);
            % freq = mean(ave_f);

        
        
        % ave_psdx = reshape(psdx_matrix,j,29);
        % p = mean(ave_psdx);
        % ave_f = reshape(freq_matrix,j,29);
        % freq = mean(ave_f);
        

        subplot(4,2,i-1)
        plot(freq,10*log10(p))
        title(char(ch(i-1)))
        xlabel('Frequency[Hz]')
        ylabel('Power')

    end

%{
for i = 2:1:9
     
    for subject_i = 1:1:number %被験者+日付の制御

        for j = 1:1:epoch
            file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
            %file_name = strcat(pwd,"\807\C\m1\open\",char(s_epoch(j)),"_data.txt");
            EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
            Nx = length(EEG_data); %データの行数
            Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
            Ch_data = zscore(Ch_data);
            nsc = floor(Nx);
            nov = floor(nsc/2);
            nff = max(256,2^nextpow2(nsc));
            [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[2:1:30],Fs);

            psdx_matrix(subject_i,subject_i,j,:) = psdx;
            freq_matrix(subject_i,subject_i,j,:) = f;

        end

        end
        
        
        p = mean(psdx_matrix);
        freq = mean(freq_matrix);
       
        subplot(4,2,i-1)
        hold on
        plot(freq,10*log10(p))
        title(char(ch(i-1)))
        xlabel('Frequency[Hz]')
        ylabel('Power')
        hold off

end

for i = 2:1:9
    for subject_i = 1:1:number %被験者+日付の制御

        for j = 1:1:epoch
            file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
            %file_name = strcat(pwd,"\807\C\m2\open\",char(s_epoch(j)),"_data.txt");
            EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
            Nx = length(EEG_data); %データの行数
            Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
            Ch_data = zscore(Ch_data);
            nsc = floor(Nx);
            nov = floor(nsc/2);
            nff = max(256,2^nextpow2(nsc));
            [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[2:1:30],Fs);

            psdx_matrix(subject_i,subject_i,j,:) = psdx;
            freq_matrix(subject_i,subject_i,j,:) = f;

        end
    end

        
        
        p = mean(psdx_matrix);
        freq = mean(freq_matrix);

        subplot(4,2,i-1)
        hold on
        plot(freq,10*log10(p))
        title(char(ch(i-1)))
        xlabel('Frequency[Hz]')
        ylabel('Power')
        hold off

end

for i = 2:1:9
    for subject_i = 1:1:number %被験者+日付の制御

        for j = 1:1:epoch
            file_name = strcat(pwd,"\",string(s_day(subject_i)),"\",char(s_name(subject_i)),"\m0\close\",char(s_epoch(j)),"_data.txt");
            %file_name = strcat(pwd,"\807\C\m3\open\",char(s_epoch(j)),"_data.txt");
            EEG_data = readmatrix(file_name); %ファイルのデータ読み込み
            Nx = length(EEG_data); %データの行数
            Ch_data = EEG_data(:,i); %電極ごとのデータを抽出
            Ch_data = zscore(Ch_data);
            nsc = floor(Nx);
            nov = floor(nsc/2);
            nff = max(256,2^nextpow2(nsc));
            [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[2:1:30],Fs);

            psdx_matrix(subject_i,subject_i,j,:) = psdx;
            freq_matrix(subject_i,subject_i,j,:) = f;

        end
        
    end
        
        p = mean(psdx_matrix);
        freq = mean(freq_matrix);

        subplot(4,2,i-1)
        hold on
        plot(freq,10*log10(p))
        title(char(ch(i-1)))
        xlabel('Frequency[Hz]')
        ylabel('Power')
        hold off

end

%p = mean(psdx);   %平均を求める
%s = std(psdx);  %標準偏差
%}