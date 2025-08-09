#!/bin/bash

case "$(file --mime-type -Lb "$1")" in
    image/*)
        # Directly call kitty icat to the terminal (not through lf's stdout)
        kitty +kitten icat --clear --stdin=no --transfer-mode=stream \
            --place="${2}x${3}@${4}x${5}" "$1" < /dev/null > /dev/tty
        exit 1
        ;;
    text/*)
        bat --style=plain --color=always "$1"
        ;;
    *)
        file --brief "$1"
        ;;
esac

