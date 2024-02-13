function output_filename = new_pupil_cut(filename)


% CSVファイルの読み込み
    data_table = readtable(filename, 'VariableNamingRule', 'preserve');
    

    

% Pupil diameter列のデータを抽出
% pupil_diameter_data_utc = data_table.('Recording start time UTC');
% Recording timestamp 列のデータを取得
recording_timestamp_data = data_table.('Recording timestamp');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 最初のRecording timestamp
first_recording_timestamp = recording_timestamp_data(1);

% Recording timestampをナノ秒に変換
recording_timestamp_milliseconds = recording_timestamp_data - first_recording_timestamp;

% % 新しいRecording timestamp列をデータテーブルに追加
% data_table.Recording_timestamp_milliseconds = recording_timestamp_milliseconds;

% Recording timestampをナノ秒から秒に戻す
recording_timestamp_seconds = recording_timestamp_milliseconds / 1000000;

% 新しいRecording timestamp秒列をデータテーブルに追加
data_table.Recording_timestamp_seconds = recording_timestamp_seconds;

pupil_diameter_data = data_table.('Pupil diameter left');
pupil_diameter_data1 = data_table.('Pupil diameter right');

pupil_diameter_data = str2double(pupil_diameter_data);
pupil_diameter_data1 = str2double(pupil_diameter_data1);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% % セル配列の内容を文字列配列に変換
% pupil_diameter_data_utc_str = string(pupil_diameter_data_utc);

% % 'Recording start time UTC' を datetime に変換
% recordingStartTimeUTC = arrayfun(@convertToDatetime, pupil_diameter_data_utc_str);

% 'Computer timestamp' を秒単位に変換

% 経過時間の計算（秒単位）
% elapsedTimeInSeconds = seconds(recordingStartTimeUTC - recordingStartTimeLocal); % 修正

% "Event"列が"ImageStimulusStart"から"ImageStimulusEnd"までの範囲の行を抽出する
start_idx = find(strcmp(data_table.('Event'), 'ImageStimulusStart')); % "ImageStimulusStart"のインデックスを取得
end_idx = find(strcmp(data_table.('Event'), 'ImageStimulusEnd')); % "ImageStimulusEnd"のインデックスを取得










% 新しいテーブルを作成
new_table = table(data_table.Recording_timestamp_seconds(start_idx:end_idx), pupil_diameter_data(start_idx:end_idx), pupil_diameter_data1(start_idx:end_idx));


% 欠損値をNaNで補間
new_table = fillmissing(new_table, 'constant', NaN);
% 新しいCSVファイルに出力
output_filename = 'output0130_file.csv';  % 出力するファイル名を指定
writetable(new_table, output_filename);

end
