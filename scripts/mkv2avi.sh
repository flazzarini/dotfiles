for f in *.mkv; do 
    ffmpeg -i "$f" -vcodec libxvid -qscale 5 -s 640x272 -aspect 40:17 -r 23.976 -g 240 -bf 2 -acodec libmp3lame -ab 160k -ar 48000 -async 48000 -ac 2 -pass 1 -an -f rawvideo -y /dev/null
    ffmpeg -i "$f" -vcodec libxvid -qscale 5 -s 640x272 -aspect 40:17 -r 23.976 -g 240 -bf 2 -acodec libmp3lame -ab 160k -ar 48000 -async 48000 -ac 2 -pass 2 -f avi "${f%.mkv}.avi"
done
