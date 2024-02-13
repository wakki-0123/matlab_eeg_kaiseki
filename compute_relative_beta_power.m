function relative_beta_power = compute_relative_beta_power(data,Fs)
    % Welch法によるパワースペクトル密度の推定
    nsc = floor(length(data));
    nov = floor(nsc / 2);
    nff = max(256, 2^nextpow2(nsc));
    [psdx, f] = pwelch(data, hamming(nsc), nov, nff, Fs);

    % α波の周波数帯域を定義
    beta_band = f >= 13 & f <= 30;

    % α波の相対パワーを計算
    beta_power = sum(psdx(beta_band));
    total_power = sum(psdx);
    relative_beta_power = beta_power / total_power;
end