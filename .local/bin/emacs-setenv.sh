#!/bin/sh

# from https://emacs.stackexchange.com/questions/6104/reload-environment-variables


if [ "$(emacsclient -e t)" != 't' ]; then
    return 1
fi

for name in "${@}"; do
    value=$(eval echo \"\$${name}\")
    emacsclient -e "(setenv \"${name}\" \"${value}\")" >/dev/null
done
