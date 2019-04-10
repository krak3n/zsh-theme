# ZSH Theme

This is my ZSH theme.

## Dependencies

* A Font with Nerd Fonts embedded, for example Nerd Hack Font: https://github.com/ryanoasis/nerd-fonts

## Install

### ZGen

Use `zgen` to install this as a plugin, for example:

```zsh
if ! zgen saved; then
    zgen load krak3n/zsh-theme krak3n.zsh-theme
fi
```

### oh-my-zsh

You can of course also clone the repository and symlink into the theme directory like `~/.oh-my-zsh/themes/`.

```bash
ln -s krak3n.zsh-theme ~/.oh-my-zsh/themes/
```

Then set your theme in your `~/.zshrc`:

```zsh
ZSH_THEME=krak3n
```

## Screenshots

### Terminal with Golang Version and Git Branch

![Golang Version with Git Branch][screen1]

[screen1]: images/screen1.png "Golang Version with Git Branch"
