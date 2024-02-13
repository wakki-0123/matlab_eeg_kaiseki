function relative_power_analyze()
    % CEDファイルから電極位置を読み取る
    Fs = 125;
    electrode_positions = read_ced_file();
    disp(electrode_positions)
    eeg_file = "ebato_0128_data_2.txt";
    % データの読み込み
    EEG_data = readmatrix(eeg_file); % ファイルのデータ読み込み

    % 解析対象の電極名
    ch_names = ["F3", "F4", "C3", "C4", "P3", "P4", "PO3", "PO4"];

    % 相対αパワーを保持する配列
    relative_alpha_powers = zeros(1, numel(ch_names));

    % 相対αパワーの計算
    for i = 1:numel(ch_names)
        % 特定の電極のデータを抽出し、標準化
        electrode_name = ch_names(i);
        if isfield(electrode_positions, electrode_name)
            Ch_data = EEG_data(:, i);
            Ch_data = zscore(Ch_data);

            % 相対αパワーを計算
            relative_delta_power = compute_relative_delta_power(Ch_data,Fs);
            relative_theta_power = compute_relative_theta_power(Ch_data,Fs);
            relative_alpha_power = compute_relative_alpha_power(Ch_data,Fs);
            relative_beta_power = compute_relative_beta_power(Ch_data,Fs);
            relative_gamma_power = compute_relative_gamma_power(Ch_data,Fs);


            % 相対αパワーを配列に保存
            relative_delta_powers(i) = relative_delta_power;
            relative_theta_powers(i) = relative_theta_power;
            relative_alpha_powers(i) = relative_alpha_power;
            relative_beta_powers(i) = relative_beta_power;
            relative_gamma_powers(i) = relative_gamma_power;

        else
            disp(['Electrode ', char(electrode_name), ' not found in the electrode positions file.']);
        end
    end

    % 電極の座標とラベルを作成
    EEG.locs = struct(); % EEG.locs 構造体の初期化
    for i = 1:numel(ch_names)
        electrode_name = ch_names(i);
        if isfield(electrode_positions, electrode_name)
            % 文字列から座標情報を抽出
            position_str = electrode_positions.(electrode_name);
            position_parts = split(position_str, {': ', ', '});
            x = str2double(position_parts{2});
            y = str2double(position_parts{4});
            z = str2double(position_parts{6});

            % 座標情報を EEG.locs 構造体に保存
            EEG.locs(i).labels = electrode_name;
            EEG.locs(i).X = x;
            EEG.locs(i).Y = y;
            EEG.locs(i).Z = z;
        end
    end

    % トポグラフィカルな表示
    eeglab;
    figure;
    disp(relative_delta_powers);
    disp(EEG.locs);
    
    % EEG.locs 構造体をセル配列に変換
    locs_cell = struct2cell(EEG.locs);
    locs_cell = reshape(locs_cell, [4, numel(ch_names)])';
    
    topoplot(relative_delta_powers, '8ch.ced', 'style', 'both', 'electrodes', 'labelpoint');
    title('Topographical Relative delta Power Mapping');
    colorbar



    figure;
    disp(relative_theta_powers);
    disp(EEG.locs);
    
    % EEG.locs 構造体をセル配列に変換
    locs_cell = struct2cell(EEG.locs);
    locs_cell = reshape(locs_cell, [4, numel(ch_names)])';
    
    topoplot(relative_theta_powers, '8ch.ced', 'style', 'both', 'electrodes', 'labelpoint');
    title('Topographical Relative theta Power Mapping');
    colorbar



    figure;
    disp(relative_alpha_powers);
    disp(EEG.locs);
    
    % EEG.locs 構造体をセル配列に変換
    locs_cell = struct2cell(EEG.locs);
    locs_cell = reshape(locs_cell, [4, numel(ch_names)])';
    
    topoplot(relative_alpha_powers, '8ch.ced', 'style', 'both', 'electrodes', 'labelpoint');
    title('Topographical Relative Alpha Power Mapping');
    colorbar

    figure;
    disp(relative_beta_powers);
    disp(EEG.locs);
    
    % EEG.locs 構造体をセル配列に変換
    locs_cell = struct2cell(EEG.locs);
    locs_cell = reshape(locs_cell, [4, numel(ch_names)])';
    
    topoplot(relative_beta_powers, '8ch.ced', 'style', 'both', 'electrodes', 'labelpoint');
    title('Topographical Relative beta Power Mapping');
    colorbar


    figure;
    disp(relative_gamma_powers);
    disp(EEG.locs);
    
    % EEG.locs 構造体をセル配列に変換
    locs_cell = struct2cell(EEG.locs);
    locs_cell = reshape(locs_cell, [4, numel(ch_names)])';
    
    topoplot(relative_gamma_powers, '8ch.ced', 'style', 'both', 'electrodes', 'labelpoint');
    title('Topographical Relative gamma Power Mapping');
    colorbar
end


