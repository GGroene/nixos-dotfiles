function basicmap
    xmodmap -e "keycode  49 = grave asciitilde grave asciitilde"\
      && xmodmap -e "keycode 65 = space NoSymbol space"
end
