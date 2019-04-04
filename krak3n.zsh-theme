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

# Virtualenv
function virtualenv_info {
    if [[ -n $VIRTUAL_ENV ]] then
        echo "%{$FX[reset]%} %{$FG[$GREY]%}`basename $VIRTUAL_ENV`%{$FX[reset]%} %{$FG[$MAGENTA]%}%{$FX[reset]%}"
    fi
}

# Go Version'
function go_version {
	if [[ -n $gvm_go_name ]] then
		echo " %{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}$gvm_go_name%{$FX[reset]%}"
	fi
}

# GCloud Account / Project
function gcloud_context {
	if (( $+commands[gcloud] )) then
		ACCOUNT=`gcloud config list --format 'value(core.account)' 2>/dev/null`
		PROJECT=`gcloud config list --format 'value(core.project)' 2>/dev/null`
		echo "%{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}$ACCOUNT/$PROJECT%{$FX[reset]%}"
	fi
}

# Kubernetes Context
function k8s_context {
    if [[ -n $ZSH_KUBECTL_PROMPT ]] then
        echo "%{$FX[reset]%}%{$FG[$BLUE]%}ﴱ%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_KUBECTL_PROMPT%{$FX[reset]%}"
    fi
}

# Return Status Hinting
RET_STATUS="%(?:%{$FG[$GREEN]%}➜:%{$FG[$RED]%}➜)%{$FX[reset]%}"

# Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$YELLOW]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FX[reset]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$RED]%}%{$FX[reset]%}"

# Prompts
PROMPT_USER="%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}%n%{$FX[reset]%} %{$FG[$YELLOW]%}%{$FX[reset]%}"
PROMPT_START="$PROMPT_USER %{$FG[$GREY]%}%.%{$FX[reset]%}"

# Default Prompt
PROMPT='$PROMPT_START$(go_version)$(git_prompt_info)
$RET_STATUS '

# Add k8s context to prompt if enabled
if [[ -v THEME_K8S_CONTEXT_PROMPT ]]; then
PROMPT='$(k8s_context)
$PROMPT_START$(go_version)$(git_prompt_info)
$RET_STATUS '
fi
