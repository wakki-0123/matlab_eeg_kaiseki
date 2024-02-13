function relative_gamma_power = compute_relative_gamma_power(data,Fs)
    % Welch法によるパワースペクトル密度の推定
    nsc = floor(length(data));
    nov = floor(nsc / 2);
    nff = max(256, 2^nextpow2(nsc));
    [psdx, f] = pwelch(data, hamming(nsc), nov, nff, Fs);

    % α波の周波数帯域を定義
    gamma_band = f >= 30 & f <= 100;

    % α波の相対パワーを計算
    gamma_power = sum(psdx(gamma_band));
    total_power = sum(psdx);
    relative_gamma_power = gamma_power / total_power;
end