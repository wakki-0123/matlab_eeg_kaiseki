function path = pupil_data_load(inputFilePath)
    % ファイルパス
    %addpath 'C:\Users\iw200\Documents\MATLAB\eeg\eeg'
    %addpath 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1'
    %addpath 'C:\Users\iw200\Documents\MATLAB\eeg\pupil';
    %inputFilePath = 'after_gazedata.csv';

    % ファイルを読み込み、各行ごとにJSONを読み込む
    fid = fopen(inputFilePath, 'r');
    jsonStr = textscan(fid, '%s', 'delimiter', '\n');
    fclose(fid);

    jsonCellArray = jsonStr{1};
    json_data_list = cellfun(@jsondecode, jsonCellArray, 'UniformOutput', false);

    % 必要なデータを取得
    output_data_list = cell(length(json_data_list), 1);
    for i = 1:length(json_data_list)
        json_data = json_data_list{i};

        % data フィールドが存在するか確認
        if isfield(json_data, 'data')
            data = json_data.data;

            % eyeleft フィールドが存在するか確認
            if isfield(data, 'eyeleft')
                eyeleft = data.eyeleft;

                % pupildiameter フィールドが存在するか確認
                if isfield(eyeleft, 'pupildiameter')
                    eyeleft_pupildiameter = eyeleft.pupildiameter;
                else
                    eyeleft_pupildiameter = NaN;
                end
            else
                eyeleft_pupildiameter = NaN;
            end
        else
            eyeleft_pupildiameter = NaN;
        end


   % 右目のデータを確認
        if isfield(data, 'eyeright')
            eyeright = data.eyeright;

            % pupildiameter フィールドが存在するか確認
            if isfield(eyeright, 'pupildiameter')
                eyeright_pupildiameter = eyeright.pupildiameter;
            else
                eyeright_pupildiameter = NaN;
            end
        else
            eyeright_pupildiameter = NaN;
        end


        %eyeright_pupildiameter = NaN; % 同様に eyeright も同様の手順で取得

        output_data_list{i} = struct(...
            'timestamp', json_data.timestamp, ...
            'eyeleft_pupildiameter', eyeleft_pupildiameter, ...
            'eyeright_pupildiameter', eyeright_pupildiameter ...
        );
    end

    % データセットを表形式に変換
    outputDataStructArray = [output_data_list{:}];
    outputTable = struct2table(outputDataStructArray);

    % CSVファイルに書き込み
    csvFilePath = 'after_pupil_diameter.csv';
    writetable(outputTable, csvFilePath);

    % 生成されたCSVファイルが保存されたパスを確認
    disp(['瞳孔データ全体のCSVファイルが保存されました: ' csvFilePath]);

    path = csvFilePath;
end
