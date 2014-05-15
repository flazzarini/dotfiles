#!/bin/bash
for a in *.flac; do
    # give output correct extension
    OUTF="${a[@]/%flac/mp3}"

    # get the tags
    ARTIST=$(metaflac "$a" --show-tag=ARTIST | sed s/.*=//g)
    TITLE=$(metaflac "$a" --show-tag=TITLE | sed s/.*=//g)
    ALBUM=$(metaflac "$a" --show-tag=ALBUM | sed s/.*=//g)
    GENRE=$(metaflac "$a" --show-tag=GENRE | sed s/.*=//g)
    TRACKNUMBER=$(metaflac "$a" --show-tag=TRACKNUMBER | sed s/.*=//g)
    DATE=$(metaflac "$a" --show-tag=DATE | sed s/.*=//g)

    # stream flac into the lame encoder
    flac -c -d "$a" | lame --alt-preset insane --add-id3v2 --pad-id3v2 --ignore-tag-errors \
        --ta "$ARTIST" --tt "$TITLE" --tl "$ALBUM"  --tg "${GENRE:-12}" \
        --tn "${TRACKNUMBER:-0}" --ty "$DATE" - "$OUTF"
done
