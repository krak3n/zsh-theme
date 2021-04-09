#!/usr/bin/env zsh

#
# Chris ZSH Theme
#

# Colours
YELLOW=003
GREY=015
BLUE=004
RED=001
MAGENTA=005
GREEN=002

NEWLINE=$'\n'

# Virtualenv
function virtualenv_info {
    if [[ -n $VIRTUAL_ENV ]] then
        echo "%{$FX[reset]%} `basename $VIRTUAL_ENV`%{$FX[reset]%} %{$FG[$MAGENTA]%}%{$FX[reset]%}"
    fi
}

# Go Version'
function go_version {
	if [[ -n $gvm_go_name ]] then
		echo " %{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} $gvm_go_name"
	fi
}

# Return Status Hinting
RET_STATUS="%(?:%{$FG[$GREEN]%}➜:%{$FG[$RED]%}➜)%{$FX[reset]%}"

# Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$YELLOW]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FX[reset]%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[$RED]%}%{$FX[reset]%}"

# Add GCP context to prompt if enabled
if [[ -n $ZSH_GCLOUD_PROMPT ]] then
	PROMPT_START+="%{$FX[reset]%}%{$FG[$BLUE]%}%{$FX[reset]%} %{$FG[$GREY]%}$ZSH_GCLOUD_PROMPT%{$FX[reset]%}${NEWLINE}"
fi

# Add k8s context to prompt if enabled
if [[ -n $ZSH_KUBECTL_PROMPT ]] then
	PROMPT_START+="%{$FX[reset]%}%{$FG[$BLUE]%}ﴱ%{$FX[reset]%} $ZSH_KUBECTL_PROMPT${NEWLINE}"
fi

PROMPT_USER="%{$FG[$BLUE]%}%{$FX[reset]%} %n %{$FG[$YELLOW]%}%{$FX[reset]%}"
PROMPT_START+="$PROMPT_USER %."

# Default Prompt
PROMPT='$PROMPT_START$(go_version)$(git_prompt_info)
$RET_STATUS '
