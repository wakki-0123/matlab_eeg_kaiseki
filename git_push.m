function git_push()
%ローカルリポジトリの初期化
!git init
!git config --global core.autocrlf input
!git add *
!git commit -m commit_0125 
% 0125は日付にしてある　逐次変更すること
!git remote add origin https://github.com/wakki-0123/matlab_eeg_kaiseki.git
!git branch eeglab
% branch 名も逐次変更すること

!git push origin eeglab
