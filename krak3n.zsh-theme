#
# Oh My ZSH
#

fpath=("$HOME/.completions" $fpath)

export PATH="/usr/local/sbin:$PATH"
export EDITOR='nvim'
export FZF_BASE=$HOME/.fzf
export CLOUDSDK_HOME=$HOME/.google-cloud-sdk

###################
# Pre run scripts
###################

if [ -d $HOME/.zsh.pre.d ]; then
	for file in $HOME/.zsh.pre.d/**/*(.); do source $file; done
fi

###################
# Plugins
###################

# Zgen Plugin Manager
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    zgen oh-my-zsh

	# SSH
    zgen oh-my-zsh plugins/ssh
    zgen oh-my-zsh plugins/ssh-agent

	# UX
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/direnv
    zgen oh-my-zsh plugins/httpie
    zgen oh-my-zsh plugins/fzf

	# Platforms / Utils
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/gcloud
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/docker-compose
    zgen oh-my-zsh plugins/kubectl
    zgen oh-my-zsh plugins/helm
    zgen load superbrothers/zsh-kubectl-prompt

	# Languages
    zgen oh-my-zsh plugins/golang

	# Theme
    zgen load krak3n/zsh-theme krak3n.zsh-theme

    zgen save
fi

#
# Plugin Agnostic Settings
#

autoload -U colors; colors
autoload -Uz url-quote-magic

zle -N self-insert url-quote-magic

autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit

#
# Go Version Manager
#

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# # Copy / Paste integration aliases
if (( $+commands[xclip] )); then
	alias cc='xclip -selection clipboard'
	alias cv='xclip -selection clipboard -o'
fi

# Copy / Paste integration aliases
if (( $+commands[pbcopy] )); then
	alias cc='pbcopy'
fi

if (( $+commands[pbpaste] )); then
	alias cv='pbpaste'
fi

###################
# Post run scripts
###################

if [ -d $HOME/.zsh.post.d ]; then
	for file in $HOME/.zsh.post.d/**/*(.); do source $file; done
fi
