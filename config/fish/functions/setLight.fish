function setLight --wraps='sudo vim /sys/class/backlight/intel_backlight/brightness' --description 'alias setLight sudo vim /sys/class/backlight/intel_backlight/brightness'
  sudo vim /sys/class/backlight/intel_backlight/brightness $argv
        
end
