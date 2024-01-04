function csv_pupil_to_heart(heart_start,heart_end,file1,output_file)

%addpath('C:\Users\iw200\OneDrive\ドキュメント\MATLAB\Examples\R2023b\matlab\EEG\eeglab2023.1')



% 心拍データの経過秒数からアイトラッカーの秒数と照らし合わせる

% disp(heart_start);
% disp(heart_end);




%一応この関数で，アイトラッカーの取り出すべき時間の範囲が分かった．

%アイトラッカーのデータの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file1 = 'C:\Users\iw200\.vscode\glass3\pupil_data\output.csv'; %アイトラッカーのデータのパスを入れる．ただし，gzファイル化しているので，必ず展開しておくこと！

b = readmatrix(file1);

l1 = length(b);

% アイトラッカーのstart位置の特定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:1:l1
 if(heart_start -0.009  < b(i,1) && heart_start + 0.009 > b(i,1))
    eye_start = b(i,1); 
    start_index = i;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% アイトラッカーのend位置の特定
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:1:l1
 if(heart_end -0.009 < b(i,1) && heart_end + 0.009 > b(i,1))
     eye_end = b(i,1);
     end_index= i;
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%アイトラッカーの取るべき時間
% disp(eye_start);
% disp(eye_end);



 %アイトラッカーのデータの抽出
time = b(start_index:1:end_index,1);
left_diameter = b(start_index:1:end_index,2);
right_diameter = b(start_index:1:end_index,3);
 

%output_file = 'pupil_data_1206.csv';
  %csvに書き出し
 combinedata = [time,left_diameter,right_diameter];

 writematrix(combinedata,output_file); %ファイル名は任意

 disp(['瞳孔データのCSVファイルが保存されました: ' output_file]);
 %disp(file)





