function vimfzf --wraps='vim ' --wraps='vim $(fzf)' --description 'alias vimfzf vim $(fzf)'
  vim $(fzf) $argv
        
end
