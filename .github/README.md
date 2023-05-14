# Starting from scratch

https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

```sh
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Cloning into new system

**Step 1: Clone dotfiles repository**

*nix:

```sh
git clone --bare git@github.com:weimeng/dotfiles.git $HOME/.dotfiles
```

PowerShell on Windows:

```powershell
git clone --bare git@github.com:weimeng/dotfiles.git $HOME\.dotfiles

# Dot source dotfiles PowerShell config
Add-Content $PROFILE ". $HOME\.config\powershell\Microsoft.PowerShell_profile.ps1"
```

**Step 2: Restart terminal session**

**Step 3: Checkout and configure**

```sh
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
