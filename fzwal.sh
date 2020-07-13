#!/bin/sh

cp -f ~/.cache/wal/colors.json /tmp/fzwal-backup.json

if [ -n "$1" ]; then
    IS_LIGHT=TRUE
    THEME=$(wal --theme |
            sed '1,/Light Themes/d;/Extra/,$d' |
            sed -E -e '/^\S/d' -e 's/^ - (\S*) ?(.*)$/\1/' |
            fzf --preview='wal -qetl --theme {} && wal --preview')
else
    THEME=$(wal --theme |
            sed '/Light Themes/,$d' |
            sed -E -e '/^\S/d' -e 's/^ - (\S*) ?(.*)$/\1/' |
            fzf --preview='wal -qet --theme {} && wal --preview')
fi


if [ -n "$THEME" ]; then
    if [ -n "$IS_LIGHT" ]; then
        wal -ql --theme $THEME
    else
        wal -q --theme $THEME
    fi
else
    wal -q --theme /tmp/fzwal-backup.json
fi
