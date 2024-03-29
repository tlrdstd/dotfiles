# Setup
* **Run this:** [install.sh](install.sh)
* Installs from `$HOME/dotfiles/` by default. Run as `DOTFILES=/path/to/this/repo install.sh` to change.
  * Note that several included conf files use this `$DOTFILES` value as well.

# Post-install
* Any local user shell customizations live in your own `~/.dotfilesrc-pre-hook` and `~/.dotfilesrc-post-hook`.
* Git committer values should be added in the post-hook like this:
```
    export GIT_COMMITTER_NAME='Your Name'
    export GIT_AUTHOR_NAME=${GIT_COMMITTER_NAME}
    export GIT_AUTHOR_EMAIL=email@example.com
    export GIT_COMMITTER_EMAIL=${GIT_AUTHOR_EMAIL}
```

# Other options
* `etc/dircolors` contains optional `dircolors` configs from `gnome-terminal-colors-solarized`.
Default in `conf/dircolors` is `ansi-dark`.

# Bundled plugins (vim, tmux, zsh)

Bundled plugins are managed via [`git submodule`](https://git-scm.com/book/en/v2/Git-Tools-Submodules)

## Updating bundled plugins

`dotfiles_update` will handle it.

Or targeted: `git submodule update --remote --recursive`

## Installing new bundled plugins

```
cd to/dotfiles/dir/where/plugin/should/live

git submodule add https://github.com/pluginAuthor/pluginName
```

## Removing bundled plugins

Submodules can be removed like any other `git`-managed file:

```
git rm -rf path/to/submodule
```
