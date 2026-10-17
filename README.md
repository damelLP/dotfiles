# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level folder is a
package that mirrors `$HOME`; `stow <pkg>` symlinks it into place.

| Package  | Links                                                        |
|----------|--------------------------------------------------------------|
| `zsh`    | `.zshrc` `.zshenv` `.zprofile` `.profile` `.p10k.zsh`        |
| `nvim`   | `~/.config/nvim`                                             |
| `tmux`   | `.tmux.conf`                                                 |
| `git`    | `.gitconfig` `.gitconfig-public` `~/.config/git`             |
| `i3`     | `~/.config/i3`                                               |
| `kitty`  | `~/.config/kitty`                                            |
| `x11`    | `.xinitrc`                                                   |

Legacy, not stowed by default: `xmonad` (xmonad + xmobar + Xresources), `bash`, `vim`.

## New machine

```sh
sudo pacman -S stow git zsh neovim tmux i3-wm kitty github-cli python-nbdime
git clone git@github.com:damelLP/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles && stow zsh nvim tmux git i3 kitty x11   # .stowrc targets ~
```

Then:

- **oh-my-zsh**: install it, then clone `powerlevel10k` into
  `~/.oh-my-zsh/custom/themes/` and `zsh-syntax-highlighting` into `~/.oh-my-zsh/custom/plugins/`.
- **nvim plugins**: open nvim and run `:PlugInstall`.
- **Not in this repo** (restore from backup): `~/.zsh_secrets` (API keys, sourced by
  `.zshrc`) and `~/.gitconfig-private` (identity and `core.sshCommand` for repos under `~/code/`).
- **GitHub SSH keys** (not in this repo): one per account, chosen by directory through
  `core.sshCommand` in the include files: `~/.ssh/damelLP/id_ed25519` for `~/git/`,
  `~/.ssh/digital-immigrant/id_ed25519` for `~/code/`. Create each with
  `ssh-keygen -t ed25519 -f <path>`, then log in to that account with
  `gh auth login --skip-ssh-key -s admin:public_key` and run `gh ssh-key add <path>.pub`.
  Some remotes use the `github.com-damelLP` alias, which needs a `Host` block in `~/.ssh/config`.

Keep the repo at `~/git/dotfiles`: `.gitconfig` applies the public identity via
`includeIf "gitdir:~/git/"`, so commits made here use it. Outside `~/git/` and `~/code/` there
is no identity (`user.useConfigOnly`), so git refuses to commit.
