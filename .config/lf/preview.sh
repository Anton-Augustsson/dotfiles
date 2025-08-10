#!/bin/bash

case "$(file --mime-type -Lb "$1")" in
  text/*)
    bat --style=plain --color=always "$1"
    ;;
  *)
    file --brief "$1"
    ;;
esac

