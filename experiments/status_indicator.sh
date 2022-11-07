#!/usr/bin/env bash

# https://github.com/ralish/bash-script-template/blob/main/template.sh
# shellcheck disable=SC2034,SC2155
function colour_init() {
    readonly ta_none="$(tput sgr0 2> /dev/null || true)"
    
    # TODO: handle no-color etc.
    # Text attributes
    readonly ta_bold="$(tput bold 2> /dev/null || true)"
    readonly ta_uscore="$(tput smul 2> /dev/null || true)"
    readonly ta_blink="$(tput blink 2> /dev/null || true)"
    readonly ta_reverse="$(tput rev 2> /dev/null || true)"
    readonly ta_conceal="$(tput invis 2> /dev/null || true)"

    # Foreground codes
    readonly fg_black="$(tput setaf 0 2> /dev/null || true)"
    readonly fg_blue="$(tput setaf 4 2> /dev/null || true)"
    readonly fg_cyan="$(tput setaf 6 2> /dev/null || true)"
    readonly fg_green="$(tput setaf 2 2> /dev/null || true)"
    readonly fg_magenta="$(tput setaf 5 2> /dev/null || true)"
    readonly fg_red="$(tput setaf 1 2> /dev/null || true)"
    readonly fg_white="$(tput setaf 7 2> /dev/null || true)"
    readonly fg_yellow="$(tput setaf 3 2> /dev/null || true)"

    # Background codes
    readonly bg_black="$(tput setab 0 2> /dev/null || true)"
    readonly bg_blue="$(tput setab 4 2> /dev/null || true)"
    readonly bg_cyan="$(tput setab 6 2> /dev/null || true)"
    readonly bg_green="$(tput setab 2 2> /dev/null || true)"
    readonly bg_magenta="$(tput setab 5 2> /dev/null || true)"
    readonly bg_red="$(tput setab 1 2> /dev/null || true)"
    readonly bg_white="$(tput setab 7 2> /dev/null || true)"
    readonly bg_yellow="$(tput setab 3 2> /dev/null || true)"
}

function status_badge() {
    local status="${1}"
    local message="${2}"

    if [[ ${status} == 0 ]]; then
        echo "${bg_green}${fg_black}  OK  ${ta_none} ${message}"
    else
        echo "${bg_red}${fg_black} FAIL ${ta_none} ${message}"
    fi
}

colour_init

#status_badge 0 "hello there!"
#status_badge 1 "Alas..."

echo "Testing dependencies..."

function check_dependency() {
    local dependency="${1}"
    exists=$(command -v "${dependency}" &> /dev/null; echo "$?")
    status_badge "${exists}" "Dependency: ${dependency}"
}

#status_badge $(command -v vim &> /dev/null) "what"


#value=$(command -v whaaa &> /dev/null; echo "$?")
#echo "$value"

check_dependency "vim"
check_dependency "tmux"
check_dependency "pandoc"
check_dependency "whaa"
