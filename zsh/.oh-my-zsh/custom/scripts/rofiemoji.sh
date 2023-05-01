#!/bin/bash

URL="https://www.unicode.org/Public/emoji/14.0/emoji-test.txt"
DIR="$HOME/.cache"
FILE="$DIR/emojis.txt"

mkdir -p $DIR

if [ ! -r $FILE ]; then
	curl --compressed "$URL" | sed -nE 's/^.+fully-qualified\s+#\s(\S+) E[0-9.]+ / \1 /p' >"$FILE"
fi

if [ "$@" ]; then
	smiley=$(echo $@ | cut -d' ' -f1)
	echo -n "$smiley" | xsel -bi
	exit 0
fi

cat $FILE
