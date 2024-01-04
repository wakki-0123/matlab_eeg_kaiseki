% function resample_kai
%     file = 'C:\Users\iw200\.vscode\glass3\pupil_data\output1204.csv'; % 任意のファイルのパス
%     data0 = readmatrix(file); % ファイルの読み込み
% 
%     time = data0(:, 1);
%     dataL = data0(:, 2); % left diameter
%     dataR = data0(:, 3); % right diameter
% 
%     % 新しいサンプル数
%     newSampleCount = 1520;
% 
%     % リサンプル
%     timeResampled = linspace(0,newSampleCount*0.01,numel(time));
%      dataLResampled = interp1(time, dataL, timeResampled, 'linear');
%      dataRResampled = interp1(time, dataR, timeResampled, 'linear');
% 
% 
% 
% 
%     % 新しいテーブルの作成
%     resampledTable = table(timeResampled', dataLResampled', dataRResampled', 'VariableNames', {'Time', 'Left', 'Right'});
% 
%     % 結果の表示
%     disp('リサンプル後のテーブル:');
%     disp(resampledTable);
% 
%     % CSVに書き出し
%     writetable(resampledTable, 'pupil_data4.csv');
% end

function resample_kai
    file = 'pupil_data3.csv'; % 任意のファイルのパス
    data0 = readmatrix(file); % ファイルの読み込み

    time = data0(:, 1);
    dataL = data0(:, 2); % left diameter
    dataR = data0(:, 3); % right diameter

    % 新しいサンプル数
    newSampleCount = 1141;

    % リサンプル
    timeResampled = linspace(0, newSampleCount * 0.01, newSampleCount);
    dataLResampled = interp1(time, dataL, timeResampled);
    dataRResampled = interp1(time, dataR, timeResampled);

    % 新しいテーブルの作成
    resampledTable = table(timeResampled', dataLResampled', dataRResampled', 'VariableNames', {'Time', 'Left', 'Right'});

    % 結果の表示
    disp('リサンプル後のテーブル:');
    disp(resampledTable);

    % CSVに書き出し
    writetable(resampledTable, 'pupil_data4.csv');
end
