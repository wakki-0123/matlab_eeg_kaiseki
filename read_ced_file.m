function electrode_positions = read_ced_file()
ced_file = '8ch.ced';
    % ファイルを開く
    fid = fopen(ced_file, 'r');
    if fid == -1
        error('Cannot open file.');
    end

    % ヘッダー行を無視
    fgetl(fid);

    % 電極位置の情報を格納する構造体を初期化
    electrode_positions = struct();

    % ファイルからデータを読み取り、構造体に格納
    tline = fgetl(fid);
    while ischar(tline)
        % 行をタブで分割
        parts = strsplit(tline, '\t');
        % 電極名
        electrode_name = parts{2};
        % X, Y, Z 座標
        X = str2double(parts{5});
        Y = str2double(parts{6});
        Z = str2double(parts{7});
        % 電極の3次元座標を文字列として格納
        electrode_position = sprintf('X: %.3f, Y: %.3f, Z: %.3f', X, Y, Z);

        % 構造体に追加
        electrode_positions.(electrode_name) = electrode_position;

        % 次の行を読み取る
        tline = fgetl(fid);
    end

    % ファイルを閉じる
    fclose(fid);
end
