function entr = FuzEn_MFs(ts, m, mf, rn, local, tau)
    narginchk(3, 6);
    
    if nargin < 6
        tau = 1;
    end
    
    if nargin < 5
        local = 0;
    end
    
    if nargin < 4
        rn = 0.2 * std(ts);
        local = 0;
        tau = 1;
    end

    N = length(ts);

    % Reconstruction
    indm = hankel(1:N-m*tau, N-m*tau:N-tau);
    indm = indm(:, 1:tau:end);
    ym = ts(indm);

    inda = hankel(1:N-m*tau, N-m*tau:N);
    inda = inda(:, 1:tau:end);
    ya = ts(inda);

    if local
        ym = ym - mean(ym, 2) * ones(1, m);
        ya = ya - mean(ya, 2) * ones(1, m+1);
    end
    ym = single(ym);
    ya = single(ya);

    % Chunking
    chunkSize = 10000;  % 適切なサイズに調整
    numChunks = ceil(N / chunkSize);

    entr_sum = 0;
    for i = 1:numChunks
        startIdx = (i - 1) * chunkSize + 1;
        endIdx = min(i * chunkSize, N);

      ym_chunk = ym(startIdx:min(endIdx, size(ym, 1)), :);
      ya_chunk = ya(startIdx:min(endIdx, size(ya, 1)), :);


        cheb_chunk = pdist(ym_chunk, 'chebychev');
        cm_chunk = feval(mf, cheb_chunk, rn);

        cheb_chunk = pdist(ya_chunk, 'chebychev');
        ca_chunk = feval(mf, cheb_chunk, rn);

        entr_sum = entr_sum - log(sum(ca_chunk) / sum(cm_chunk));
    end

    entr = entr_sum / numChunks;
    
    clear ym ya cheb cm ca;
end

% Membership functions
function c = Triangular(dist, rn)
    c = zeros(size(dist));
    c(dist <= rn) = 1 - dist(dist <= rn) ./ rn;
end

% 他のメンバーシップ関数の定義も同様に


function c = Trapezoidal(dist, rn)
    c = zeros(size(dist));
    c(dist <= rn) = 1;
    c(dist <= 2 * rn & dist > rn) = 2 - dist(dist <= 2 * rn & dist > rn) ./ rn;
end

function c = Z_shaped(dist, rn)
    c = zeros(size(dist));
    r1 = dist <= rn;
    r2 = dist > rn & dist <= 1.5 * rn;
    r3 = dist > 1.5 * rn & dist <= 2 * rn;
    c(r1) = 1;
    c(r2) = 1 - 2 * ((dist(r2) - rn) ./ rn).^2;
    c(r3) = 2 * ((dist(r3) - 2 * rn) ./ rn).^2;
end

function c = Bell_shaped(dist, rn)
    c = 1 ./ (1 + abs(dist ./ rn(1)).^(2 * rn(2)));
end

function c = Gaussian(dist, rn)
    c = exp(-(dist./(sqrt(2) * rn)).^2);
end

function c = Constant_Gaussian(dist, rn)
    c = ones(size(dist));
    c(dist > rn) = exp(-log(2) .* ((dist(dist > rn) - rn) ./ rn).^2);
end

function c = Exponential(dist, rn)
    c = exp(-dist.^rn(2) ./ rn(1));
end