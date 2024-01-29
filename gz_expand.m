function gz_expand(gzFilePath)
% 展開したいファイルのパス
%gzFilePath = 'path/to/your/file.gz';

% 展開先のディレクトリ
%outputDirectory = 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1\';
outputDirectory = 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1';

% gunzip関数を使用してファイルを展開
gunzip(gzFilePath, outputDirectory);

 disp(['gzファイル化されていた瞳孔データ全体を展開しました: ' gzFilePath]);