function pixivmap
    xmodmap -e "keycode  49 = Prior asciitilde grave asciitilde"\
      && xmodmap -e "keycode 65 = Next NoSymbol space"
end
