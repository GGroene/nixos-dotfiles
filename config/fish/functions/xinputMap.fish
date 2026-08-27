function xinputMap --wraps='xinput map-to-output 19 eDP-1' --description 'alias xinputMap xinput map-to-output 19 eDP-1'
  xinput map-to-output $(xinput | grep pointer | grep ELAN | cut -d "=" -f2 | cut -f1) eDP-1 $argv
        
end
