function adbtemp
    adb shell dumpsys thermalservice | grep "Current temp" -A 28 | tail -n+2 | cut -b 14- | rev | cut -b 2- | sort -t, -nk2 | rev | sort -t= -k3 | awk -F '[(, |=)]' 'BEGIN {ORS=""} {if ($11=="0") {print "  "} else {print "! "} print substr($2,1,4)"\t| "$8"\n"}'
end
