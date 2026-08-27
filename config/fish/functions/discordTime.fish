function discordTime
    echo "<t:"$(date +%s%N | cut -b1-10)":f>"
end
