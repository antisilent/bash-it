#!/usr/bin/env bash

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxfggxgxefhchx

export GREP_OPTIONS='--color=auto'

safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
    # we have colors :-)
    # Enable colors for ls, etc. Prefer ~/.dir_colors
    if type -P dircolors >/dev/null ; then
        if [[ -f $BASH_IT/themes/antisilent/DIR_COLORS ]] ; then
            eval $(dircolors -b $BASH_IT/themes/antisilent/DIR_COLORS)
        elif [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi
fi

_UTOPLEFT="\342\224\214"              # ┌
_UBAR="\342\224\200"                  # ─
_URIGHTT="\342\224\234"               # ├
_UBOTTOMLEFT="\342\224\224"           # └
_ULBRACK="\133"                       # [
_URBRACK="\135"                       # ]

_PROMPT_CMD="[$]"

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${green}✓"
SCM_THEME_PROMPT_PREFIX="${_UBAR}[${blue}"
SCM_THEME_PROMPT_SUFFIX="${white}]"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${green}✓"
GIT_THEME_PROMPT_PREFIX="${_UBAR}[${blue}"
GIT_THEME_PROMPT_SUFFIX="${white}]"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"



function prompt_command() {
    PS1="\n${white}${_UTOPLEFT}${_ULBRACK}$(if [[ ${EUID} == 0 ]]; then echo ${red}; else echo ${blue}; fi)\u@\h${white}${_URBRACK}$(scm_prompt_info)\n${_URIGHTT}${_ULBRACK}${green}\@ \d${white}${_URBRACK}${_UBAR}${_ULBRACK}${green}\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -lah | grep -m 1 total | sed 's/total //')b${white}${_URBRACK}\n${_UBOTTOMLEFT}${_ULBRACK}${yellow}\w${white}${_URBRACK}\n[$]${reset_color} "
    PS2="> "
    PS3="+ "
    PS4="- "
}

safe_append_prompt_command prompt_command
