for f in *.mp4; do
    mencoder "$f" -channels 6 -ovc xvid -xvidencopts fixed_quant=4 -vf harddup -oac pcm -o "${f%.mp4}.avi"
done
