function dqc --wraps='cd $HOME/Documents/SQLiteLib/ && eval $(poetry env activate) && tmux' --description 'alias dqc cd $HOME/Documents/SQLiteLib/ && eval $(poetry env activate) && tmux'
    cd /home/gg/Documents/SQLiteLib/ && eval $(poetry env activate) && cd sqlite_parquet && tmux $argv
end
