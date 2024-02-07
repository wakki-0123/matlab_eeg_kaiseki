function power_heartrate(data)
Fs = 0.2;
% 最初の信号
% k=0の時左目
% k=1の時右目 
    
    %Nx = length(eye_left_diameter); %データの行数

    Ch_data = data(:,1); 
    % Ch_data = zscore(Ch_data); 
    % nsc = floor(Nx);
    % nov = floor(nsc/2);
    % nff = max(256,2^nextpow2(nsc));
    [psdx,f] = pwelch(Ch_data,[],[],[0.00001:0.00001:0.0033],Fs);
    psdx = smoothdata(psdx);%smoothing

    %もう一つの信号
    
    
    % %Nx1 = length(eye_right_diameter); %データの行数
    % Ch_data1 = yal(:,1);
    % % Ch_data1 = zscore(Ch_data1);
    % % nsc1 = floor(Nx1);
    % % nov1 = floor(nsc1/2);
    % % nff1 = max(256,2^nextpow2(nsc1));
    % [psdx1,f1] = pwelch(Ch_data1,[],[],[0.0001:0.0001:0.04],Fs);
    % psdx1 = smoothdata(psdx1);%smoothing

    % freq1 = f1;
    % p1 = psdx1;
    freq = f;
    p = psdx;


% plot start

  

    figure(5)
    plot(freq,10*log10(p),'r')
    legend({'before','after'},'Location','southwestoutside')

    title('left powerspectol')
    xlabel('Frequency[Hz]')
    ylabel('Power[dB]')
   

   
    
    
end


