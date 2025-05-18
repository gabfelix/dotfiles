function yt
    yt-dlp --embed-metadata -i $argv
end

function ytv
    yt-dlp --embed-metadata -i -S res,ext:mp4:m4a --recode mp4 $argv
end

function yta
    yt-dlp --embed-metadata -i -x -f bestaudio/best --audio-format mp3 $argv
end

function ytt
    yt-dlp --embed-metadata -i --skip-download --write-thumbnail $argv --convert-thumbnails jpg
end
