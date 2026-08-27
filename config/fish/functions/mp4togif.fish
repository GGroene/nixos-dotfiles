function mp4togif --wraps='ffmpeg -i sourcefile.mp4 -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis outfile.webm' --description 'alias mp4togif ffmpeg -i sourcefile.mp4 -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis outfile.webm'
  ffmpeg -i sourcefile.mp4 -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis outfile.webm $argv
        
end
