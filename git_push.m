function git_push()
%ローカルリポジトリの初期化
!git init
!git config --global core.autocrlf input
!git add *
!git commit -m commit_0125 
% 0125は日付にしてある　逐次変更すること


!git push origin eeglab
