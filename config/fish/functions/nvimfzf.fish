function nvimfzf --wraps='nvim ' --wraps='nvim $(fzf)' --description 'alias nvimfzf nvim $(fzf)'
  nvim $(fzf) $argv
        
end
