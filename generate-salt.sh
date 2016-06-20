#!/usr/bin/env bash
#
# generate-salt.sh : generates random salt strings or passwords
#
# Sources at <http://github.com/e-picas/generate-salt.git>
# Copyright (c) 2014-2016 Pierre Cassat
# This project is released under the terms of the MIT license;
# see `LICENSE` for details.
#
set -e

# current version
declare SCRIPT_VERSION='0.1.0'
declare DEV_DEBUG=false

# presets
declare -a presets
declare -a presets_mask
declare -a presets_length
# simple num
presets+=( num )
presets_mask+=( '0-9' )
presets_length+=( 8 )
# upper alpha
presets+=( upperalpha )
presets_mask+=( 'A-Z' )
presets_length+=( 10 )
# lower alpha
presets+=( loweralpha )
presets_mask+=( 'a-z' )
presets_length+=( 10 )
# alpha
presets+=( alpha )
presets_mask+=( 'A-Za-z' )
presets_length+=( 12 )
# alphanum
presets+=( alphanum )
presets_mask+=( 'A-Za-z0-9' )
presets_length+=( 12 )
# basic
presets+=( basic )
presets_mask+=( 'A-Za-z0-9#!$*@&%' )
presets_length+=( 16 )
# hard
presets+=( hard )
presets_mask+=( 'A-Za-z0-9#!$*@&%\-+=\/.,:;?()[]^`' )
presets_length+=( 64 )

# throw an error
error() {
    {   echo "> $*"
        echo '---'
        usage
    } >&2
    exit 1
}

# usage string
usage() {
    echo "usage: $0 <preset> [length=default]"
    echo "available presets:"
    printf "\t%13s\t%s\t%-30s" 'name' 'length' 'mask'
    printf "\n\t%13s\t%s\t%-30s" '----------' '------' '----'
    for pre in "${!presets[@]}"; do
        printf "\n\t%13s\t%-6d\t%-30s" \
            "${presets[$pre]} :" "${presets_length[$pre]}" "${presets_mask[$pre]}";
    done
    echo
    echo '---'
    echo "e.g. $0 alpha      : dlNMPuMhfXCG"
    echo "     $0 basic 18   : VjO23Jv4K@2&sLwUF4"
    echo "     $0 hard 64    : vDm@UMG%5+CKsgY5xJX]jA(WtsN^8Ik;/,k6mFW.qNRvq(bf(WM+E2tGaR\`R(m@]"
}

# version string
version() {
    echo "Generate-salt $SCRIPT_VERSION"
}

# help string
help() {
    version
    echo
    usage
    echo
    echo "This is free software under the terms of the MIT license."
    echo "See <http://github.com/e-picas/generate-salt> for sources & updates."
}

# arg required
if [ -z "$1" ]; then
    usage >&2
    exit 1
fi

# -h / --help
if [[ "$1" =~ ^--?h(elp)?$ ]]; then
    help
    exit 0
fi

# -V / --version
if [ "$1" = '-V' ]||[ "$1" = '--version' ]; then
    version
    exit 0
fi

# generation
preset="${1}"
index=''
for key in "${!presets[@]}"; do
    if [ "${presets[$key]}" = "$preset" ]; then
        index="$key"
    fi
done

if [ -z "$index" ]; then
    error "preset '$preset' not found!"
fi

mask="${presets_mask[$index]}"
length="${2:-${presets_length[$index]}}"

if [ -n "$DEV_DEBUG" ] && $DEV_DEBUG; then
    echo "> preset: ${preset}"
    echo "> index:  ${index}"
    echo "> mask:   ${mask}"
    echo "> length: ${length}"
fi

tr -dc "$mask" < /dev/urandom | head -c "$length" | xargs

exit 0

# vim: autoindent expandtab tabstop=4 shiftwidth=4 softtabstop=4 filetype=sh
