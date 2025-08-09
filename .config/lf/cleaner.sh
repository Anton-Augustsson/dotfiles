#!/bin/bash
kitty +kitten icat --clear --stdin=no --transfer-mode=memory </dev/null >/dev/tty 2>/dev/null
