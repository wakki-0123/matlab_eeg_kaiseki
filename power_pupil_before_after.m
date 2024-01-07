function power_pupil_before_after(ybl,yal,k)
Fs = 100;
% 最初の信号
% k=0の時左目
% k=1の時右目 
    
    %Nx = length(eye_left_diameter); %データの行数

    Ch_data = ybl(:,1); 
    % Ch_data = zscore(Ch_data); 
    % nsc = floor(Nx);
    % nov = floor(nsc/2);
    % nff = max(256,2^nextpow2(nsc));
    [psdx,f] = pwelch(Ch_data,[],[],[0.0001:0.0001:0.04],Fs);
    psdx = smoothdata(psdx);%smoothing

    %もう一つの信号
    
    
    %Nx1 = length(eye_right_diameter); %データの行数
    Ch_data1 = yal(:,1);
    % Ch_data1 = zscore(Ch_data1);
    % nsc1 = floor(Nx1);
    % nov1 = floor(nsc1/2);
    % nff1 = max(256,2^nextpow2(nsc1));
    [psdx1,f1] = pwelch(Ch_data1,[],[],[0.0001:0.0001:0.04],Fs);
    psdx1 = smoothdata(psdx1);%smoothing

    freq1 = f1;
    p1 = psdx1;
    freq = f;
    p = psdx;


% plot start

   if(k == 0)

    figure(5)
    plot(freq,10*log10(p),'r')
    hold on
    plot(freq1,10*log10(p1),'g')


    legend({'before','after'},'Location','southwestoutside')

    title('left powerspectol')
    xlabel('Frequency[Hz]')
    ylabel('Power[dB]')
   
else
    figure(6)
    plot(freq,10*log10(p),'r')
    hold on
    plot(freq1,10*log10(p1),'g')


    legend({'before','after'},'Location','southwestoutside')

    title('right powerspectol')
    xlabel('Frequency[Hz]')
    ylabel('Power[dB]')
   end
   savedir = 'C:\Users\iw200\Documents\MATLAB\eeg\eeg_kaiseki';
    fig_handle = figure(5);
    saveas(fig_handle,fullfile(savedir,['figure_' num2str(5) '.png']));
    
    fig_handle = figure(6);
    saveas(fig_handle,fullfile(savedir,['figure_' num2str(6) '.png']));
end


