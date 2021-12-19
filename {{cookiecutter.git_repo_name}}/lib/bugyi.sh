#!/bin/bash

################################################
#  Global Utility Functions for Shell Scripts  #
################################################

if [[ "${BUGYI_HAS_BEEN_SOURCED}" != true ]]; then
    readonly BUGYI_HAS_BEEN_SOURCED=true

    # ---------- Global Variables ----------
    readonly SCRIPTNAME="$(basename "$0")"

    if [[ -n "${BASH}" ]]; then
        MY_SHELL=bash
    elif [[ -n "${ZSH_NAME}" ]]; then
        MY_SHELL=zsh
    else
        MY_SHELL=unknown
    fi
    readonly MY_SHELL

    # ---------- XDG User Directories ----------
    # shellcheck disable=SC2034
    if [[ -n "${XDG_RUNTIME_DIR}" ]]; then
        XDG_RUNTIME="${XDG_RUNTIME_DIR}"
    else
        XDG_RUNTIME=/tmp
    fi
    readonly XDG_RUNTIME

    # shellcheck disable=SC2034
    if [[ -n "${XDG_CONFIG_HOME}" ]]; then
        XDG_CONFIG="${XDG_CONFIG_HOME}"
    else
        XDG_CONFIG="${HOME}"/.config
    fi
    readonly XDG_CONFIG

    # shellcheck disable=SC2034
    if [[ -n "${XDG_DATA_HOME}" ]]; then
        XDG_DATA="${XDG_DATA_HOME}"
    else
        XDG_DATA="${HOME}"/.local/share
    fi
    readonly XDG_DATA

    # shellcheck disable=SC2034
    readonly MY_XDG_RUNTIME="${XDG_RUNTIME}"/"${SCRIPTNAME}"
    # shellcheck disable=SC2034
    readonly MY_XDG_CONFIG="${XDG_CONFIG}"/"${SCRIPTNAME}"
    # shellcheck disable=SC2034
    readonly MY_XDG_DATA="${XDG_DATA}"/"${SCRIPTNAME}"
fi

# ---------- Function Definitions ----------
function die() {
    local exit_code
    if [[ "${!#}" =~ ^[1-9][0-9]*$ && "${!#}" -le 256 ]]; then
        exit_code="${!#}"

        # Remove the last argument from $@.
        set -- "${@:1:$(($# - 1))}"
    else
        exit_code=1
    fi

    local message
    if [[ "$#" -eq 1 ]]; then
        message="$1"
        shift
    else
        message="$(printf "$@")"
    fi

    if [[ "${exit_code}" -eq 2 ]]; then
        message="Failed while parsing command-line arguments. Try '${SCRIPTNAME} --help' for more information.\n\n${message}"
    fi

    emsg --up 1 "${message}"
    exit "${exit_code}"
}

# Color palette
readonly COLOR_GREEN='\033[38;5;2m'
readonly COLOR_PURPLE='\033[38;5;5m'
readonly COLOR_RED='\033[38;5;1m'
readonly COLOR_RESET='\033[0m'
readonly COLOR_YELLOW='\033[38;5;3m'

function log::debug() { dmsg "$@"; }
function log::error() { emsg "$@"; }
function log::info() { imsg "$@"; }
function log::warn() { wmsg "$@"; }

function dmsg() { if [[ "${DEBUG}" = true || "${VERBOSE}" -gt 0 ]]; then _msg "debug" "${COLOR_PURPLE}" "$@"; fi; }
function emsg() { _msg "error" "${COLOR_RED}" "$@"; }
function imsg() { _msg "info" "${COLOR_GREEN}" "$@"; }
function wmsg() { _msg "warning" "${COLOR_YELLOW}" "$@"; }
function _msg() {
    local level="$1"
    shift

    local color="$1"
    shift

    if [[ "${DISABLE_LOG_COLOR}" == true ]]; then
        color="${COLOR_RESET}"
    fi

    local up
    if [[ "$1" == "--up" || "$1" == "-u" ]]; then
        shift

        up=$(($1 + 1))
        shift
    elif [[ "$1" == "-u"* ]]; then
        up=$((${1:2} + 1))
        shift
    else
        up=1
    fi

    local message
    if [[ "$#" -eq 1 ]]; then
        message="$1"
        shift
    else
        message="$(printf "$@")"
    fi

    if [[ "${MY_SHELL}" == "bash" ]]; then
        # shellcheck disable=SC2207
        local caller_info=($(caller "${up}"))

        local this_lineno="${caller_info[0]}"
        local this_funcname="${caller_info[1]}"
        local this_filename="${caller_info[2]}"

        # This happens when called from global scope.
        if [[ "${this_funcname}" == "main" ]]; then
            this_funcname="<main>"
        fi
    fi

    local pretty_level="${color}$(echo "${level}" | tr '[:lower:]' '[:upper:]')${COLOR_RESET}"
    local scriptname="$(basename "${this_filename:-"${MY_SHELL}"}")"
    local date_string="$(date +"%Y-%m-%d %H:%M:%S")"
    if [[ -n "${this_funcname}" ]]; then
        local log_msg="$(printf "%s | PID:%s | %s | %s:%d | %s | %s" \
            "${date_string}" \
            "$$" \
            "${scriptname}" \
            "${this_funcname}" \
            "${this_lineno}" \
            "${pretty_level}" \
            "${message}")"
    else
        local log_msg="$(printf "%s | %s | %s | %s" \
            "${date_string}" \
            "${scriptname}" \
            "${pretty_level}" \
            "${message}")"
    fi

    echo -e "${log_msg}" |
        # Print to STDERR...
        tee /dev/stderr |
        # Get rid of first two log message sections...
        perl -nE 'print s/^[^|]+\|[ ]*[^|]+\|[ ]*(.*)/\1/gr' |
        # And then log to syslog...
        logger -t "${scriptname}"
}

function pyprintf() {
    pycmd="import sys; args = ['\\n'.join(a.split(r'\\n')) for a in sys.argv[1:]]; print(args[0].format(*args[1:]), end='')"
    python -c "${pycmd}" "$@"
}

function notify() {
    notify-send "${SCRIPTNAME}" "$@"
}

function usage() {
    printf "usage: "

    local hspace=false
    for P in "${USAGE_GRAMMAR[@]}"; do
        if [[ "${hspace}" = true ]]; then
            printf "       "
        else
            hspace=true
        fi

        printf "${SCRIPTNAME} %s\n" "${P}"
    done
}

function truncate() {
    rm "${1}" &>/dev/null
    touch "${1}"
}

function setup_traps() { _trap_with_arg _trap_handler "$@"; }
function _trap_with_arg() {
    func="$1"
    shift

    for sig in "$@"; do
        # shellcheck disable=SC2064
        trap "$func $sig" "$sig"
    done
}
function _trap_handler() {
    local signal="$1"
    shift

    local exit_code
    if [[ "${signal}" == "INT" ]]; then
        exit_code=$((128 + 2))
    elif [[ "${signal}" == "TERM" ]]; then
        exit_code=$((128 + 15))
    else
        exit_code=1
    fi

    wmsg --up 1 "Received %s signal. Terminating script (ec=%d)..." "${signal}" "${exit_code}"
    exit "${exit_code}"
}
