function relative_delta_power = compute_relative_delta_power(data,Fs)
    % Welch法によるパワースペクトル密度の推定
    nsc = floor(length(data));
    nov = floor(nsc / 2);
    nff = max(256, 2^nextpow2(nsc));
    [psdx, f] = pwelch(data, hamming(nsc), nov, nff, Fs);

    % α波の周波数帯域を定義
    delta_band = f >= 0.5 & f <= 4;

    % α波の相対パワーを計算
    delta_power = sum(psdx(delta_band));
    total_power = sum(psdx);
    relative_delta_power = delta_power / total_power;
end