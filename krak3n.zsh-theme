#!/usr/bin/env zsh

#
# Chris ZSH Theme
#

# Colours
YELLOW=003
GREY=008
BLUE=004
RED=001
MAGENTA=005
GREEN=002

NEWLINE=$'\n'

# User / Dir
function user {
	echo "%{$FG[$BLUE]%}%{$FX[reset]%} %n %{$FG[$YELLOW]%}%{$FX[reset]%} %."
}

# Kubernetes Conctext / Namespace
function k8s_context() {
	if [[ -v $DISABLE_KUBECTL_PROMPT ]]; then
		return
	fi

	if [[ -n $ZSH_KUBECTL_PROMPT ]] then
		echo "%{$FX[reset]%}%{$FG[$BLUE]%}󰠳%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_KUBECTL_PROMPT%{$FX[reset]%}"
		echo "\r\n"
	fi
}

# Gcloud account / project
function gcloud_context() {
	if [[ -v $DISABLE_GCLOUD_PROMPT ]]; then
		return
	fi

	if [[ -n $ZSH_GCLOUD_PROMPT ]] then
		echo "%{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_GCLOUD_PROMPT%{$FX[reset]%}"
		echo "\r\n"
	fi
}

# Virtualenv
function virtualenv_info {
    if [[ -n $VIRTUAL_ENV ]] then
        echo "%{$FX[reset]%} `basename $VIRTUAL_ENV`%{$FX[reset]%} %{$FG[$MAGENTA]%}%{$FX[reset]%}"
    fi
}

# Go Version
function go_version {
	if (( $+commands[go] )); then
		VER=$(go version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/')
		echo " %{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} $VER"
	fi
}

# Return Status Hinting
RET_STATUS="%(?:%{$FG[$GREEN]%}➜:%{$FG[$RED]%}➜)%{$FX[reset]%}"

# Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$YELLOW]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FX[reset]%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$RED]%}%{$FX[reset]%}"

# Default Prompt
PROMPT='$(gcloud_context)$(k8s_context)$(user)$(go_version)
$(git_prompt_info)$RET_STATUS '
