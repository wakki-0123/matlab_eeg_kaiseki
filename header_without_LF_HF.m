function file1 = header_without_LF_HF(file_path, file)
    % 心拍データから，タイムスタンプとRRIを抜き出すプログラム

    % CSVファイルからデータを読み込む
    data = readtable(file_path, 'VariableNamingRule', 'preserve');

    % ヘッダーを取り除く
    data_without_header = data(2:end, :);

    % ヘッダーを確認
    disp(data_without_header.Properties.VariableNames);

    % 特定の列（Var2, Var1）を取り出す
    column_var4 = data_without_header.('LF/HF');
    column_var3 = data_without_header.HF;

    column_var2 = data_without_header.LF;
    column_Time = data_without_header.Time;

    % cell 配列を datetime に変換
    column_Time_datetime = datetime(column_Time, 'InputFormat', 'mm:ss.SSS');

    % datetime を duration に変換し、秒単位に変換
    D = seconds(duration(column_Time_datetime - column_Time_datetime(1)));

    % numeric_durationをcell arrayに変換
    D = num2cell(D);

    % combinedata = [column_Time, num2cell(column_var2)];
    combinedata = [D, num2cell(column_var2),num2cell(column_var3),num2cell(column_var4)];

    % セル配列をテーブルに変換
    combinedata_table = cell2table(combinedata, 'VariableNames', {'Var1', 'Var2','Var3','Var4'});

    % CSVファイルに書き込む
    writetable(combinedata_table, file);

    disp(['心拍データ全体のCSVファイルが保存されました: ' file]);

    file1 = file;
end
