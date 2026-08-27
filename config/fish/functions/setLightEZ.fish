function setLightEZ
	if not test $argv -gt 24000
		sudo echo $argv > /sys/class/backlight/intel_backlight/brightness
		echo "Brightness set to $argv/24000"
	else
		sudo echo 24000 > /sys/class/backlight/intel_backlight/brightness
		echo "Brightness cannot exceed 24000, set to max"
	end        
end
