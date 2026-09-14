#!/usr/bin/env zsh

#
# Chris ZSH Theme
#
# Standalone: does not require oh-my-zsh or zgen. Only needs zsh itself + git.
#

# Required so the $(...) segments in $PROMPT are re-evaluated on every prompt draw
setopt PROMPT_SUBST

# Colours
YELLOW=003
GREY=008
BLUE=004
RED=001
MAGENTA=005
GREEN=002

NEWLINE=$'\r\n'

# Foreground colour / effect escapes (replaces oh-my-zsh's $FG/$FX arrays)
typeset -gA FG FX
FG[$YELLOW]=$'%{\e[38;5;'$YELLOW'm%}'
FG[$GREY]=$'%{\e[38;5;'$GREY'm%}'
FG[$BLUE]=$'%{\e[38;5;'$BLUE'm%}'
FG[$RED]=$'%{\e[38;5;'$RED'm%}'
FG[$MAGENTA]=$'%{\e[38;5;'$MAGENTA'm%}'
FG[$GREEN]=$'%{\e[38;5;'$GREEN'm%}'
FX=(reset $'%{\e[00m%}')

# User / Dir
function user {
	echo "%{$FG[$BLUE]%}%{$FX[reset]%} %n %{$FG[$YELLOW]%}%{$FX[reset]%} %."
}

# Kubernetes Context / Namespace
function k8s_context() {
	if [[ -n $DISABLE_KUBECTL_PROMPT ]]; then
		return
	fi

	if [[ -n $ZSH_KUBECTL_PROMPT ]] then
		echo "%{$FX[reset]%}%{$FG[$BLUE]%}󰠳%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_KUBECTL_PROMPT%{$FX[reset]%}"
		echo "$NEWLINE"
	fi
}

# Gcloud account / project
function gcloud_context() {
	if [[ -n $DISABLE_GCLOUD_PROMPT ]]; then
		return
	fi

	if [[ -n $ZSH_GCLOUD_PROMPT ]] then
		echo "%{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_GCLOUD_PROMPT%{$FX[reset]%}"
		echo "$NEWLINE"
	fi
}

# Go Version (only shown inside a Go project, to avoid forking `go` on every prompt)
function _in_go_project {
	local dir=$PWD
	while [[ $dir != / ]]; do
		[[ -f $dir/go.mod ]] && return 0
		dir=${dir:h}
	done
	return 1
}

function go_version {
	if (( $+commands[go] )) && _in_go_project; then
		local words=(${(z)$(go version)})
		local ver=${words[3]#go}
		echo " %{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} $ver"
	fi
}

# Return Status Hinting
RET_STATUS="%(?:%{$FG[$GREEN]%}➜:%{$FG[$RED]%}➜)%{$FX[reset]%}"

# Git Prompt (standalone replacement for oh-my-zsh's git plugin)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$YELLOW]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FX[reset]%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$RED]%}%{$FX[reset]%}"

function git_prompt_dirty {
	if [[ -n $(git status --porcelain --ignore-submodules 2>/dev/null) ]]; then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
	fi
}

function git_prompt_info {
	local ref
	ref=$(git symbolic-ref --short HEAD 2>/dev/null) || ref=$(git rev-parse --short HEAD 2>/dev/null) || return
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(git_prompt_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Default Prompt
PROMPT='$(gcloud_context)$(k8s_context)$(user)$(go_version)
$(git_prompt_info)$RET_STATUS '
