function relative_theta_power = compute_relative_theta_power(data,Fs)
    % Welch法によるパワースペクトル密度の推定
    nsc = floor(length(data));
    nov = floor(nsc / 2);
    nff = max(256, 2^nextpow2(nsc));
    [psdx, f] = pwelch(data, hamming(nsc), nov, nff, Fs);

    % α波の周波数帯域を定義
    theta_band = f >= 4 & f <= 8;

    % α波の相対パワーを計算
    theta_power = sum(psdx(theta_band));
    total_power = sum(psdx);
    relative_theta_power = theta_power / total_power;
end