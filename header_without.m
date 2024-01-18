function file1 = header_without(file_path, file)
    % 心拍データから，タイムスタンプとRRIを抜き出すプログラム

    % CSVファイルからデータを読み込む
    data = readtable(file_path, 'VariableNamingRule', 'preserve');

    % ヘッダーを取り除く
    data_without_header = data(5:end, :);

    % ヘッダーを確認
    disp(data_without_header.Properties.VariableNames);

    % 特定の列（Var2, Var1）を取り出す
    column_var2 = data_without_header.RRI;
    column_Time = data_without_header.Time;

    % cell 配列を datetime に変換
    column_Time_datetime = datetime(column_Time, 'InputFormat', 'mm:ss.SSS');

    % datetime を duration に変換し、秒単位に変換
    D = seconds(duration(column_Time_datetime - column_Time_datetime(1)));

    % numeric_durationをcell arrayに変換
    D = num2cell(D);

    % combinedata = [column_Time, num2cell(column_var2)];
    combinedata = [D, num2cell(column_var2)];

    % セル配列をテーブルに変換
    combinedata_table = cell2table(combinedata, 'VariableNames', {'Var1', 'Var2'});

    % CSVファイルに書き込む
    writetable(combinedata_table, file);

    disp(['心拍データ全体のCSVファイルが保存されました: ' file]);

    file1 = file;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function file1 = header_without(file_path,file)
% % 心拍データから，タイムスタンプとRRIを抜き出すプログラム
% 
% % ファイルのパス
% %file_path = '20231202152441_10020912_Data_RRI.csv';
% 
% % CSVファイルからデータを読み込む
% data = readtable(file_path);
% 
% % ヘッダーを取り除く
% data_without_header = data(5:end, :);
% 
% % 特定の列（Var2, Var1）を取り出す
% column_var2 = data_without_header.Var2;
% column_Time = data_without_header.Var1;
% 
% D = duration(column_Time,'InputFormat','mm:ss.SSS');
% 
% % durationを数値形式に変換（秒単位）
% D = seconds(D);
% 
% D = D - D(1);
% 
% % numeric_durationをcell arrayに変換
% D = num2cell(D);
% %disp(D)
% 
%  %combinedata = [column_Time, num2cell(column_var2)];
%  combinedata = [D, num2cell(column_var2)];
%  % セル配列をテーブルに変換
% combinedata_table = cell2table(combinedata, 'VariableNames', {'Var1', 'Var2'});
% 
% 
% %file = 'heart_RRI.csv';
% % CSVファイルに書き込む
% writetable(combinedata_table, file);
% 
% disp(['心拍データ全体のCSVファイルが保存されました: ' file]);
% 
% %disp(file)
% 
% file1 = file;
% end
% 
% 