function getLightMax --wraps='cat /sys/class/backlight/intel_backlight/max_brightness' --description 'alias getLightMax cat /sys/class/backlight/intel_backlight/max_brightness'
  cat /sys/class/backlight/intel_backlight/max_brightness $argv
        
end
