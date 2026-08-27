function emacsRestart --wraps='killall emacs && /usr/bin/emacs --daemon &' --wraps='killall emacs && /usr/bin/emacs --daemon' --description 'alias emacsRestart killall emacs && /usr/bin/emacs --daemon'
  killall emacs && /usr/bin/emacs --daemon $argv
        
end
