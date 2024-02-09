function relative_alpha_power = compute_relative_alpha_power(data,Fs)
    % Welch法によるパワースペクトル密度の推定
    nsc = floor(length(data));
    nov = floor(nsc / 2);
    nff = max(256, 2^nextpow2(nsc));
    [psdx, f] = pwelch(data, hamming(nsc), nov, nff, Fs);

    % α波の周波数帯域を定義
    alpha_band = f >= 8 & f <= 13;

    % α波の相対パワーを計算
    alpha_power = sum(psdx(alpha_band));
    total_power = sum(psdx);
    relative_alpha_power = alpha_power / total_power;
end
