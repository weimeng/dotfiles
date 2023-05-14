# Starting from scratch

https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

```sh
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

# Cloning into new system

## *nix

```sh
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare git@github.com:weimeng/dotfiles.git $HOME/.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## Powershell

```powershell
function Start-DotfilesGit
{
  param(
    [string[]]
    [Parameter(ValueFromRemainingArguments)]
    $Command = ' ')

  $ArgumentList = @("--git-dir=$HOME\.dotfiles\", "--work-tree=$HOME") + $Command

  Start-Process -NoNewWindow -FilePath "C:\Program Files\Git\cmd\git.exe" -ArgumentList $ArgumentList
}
Set-Alias -Name dotfiles -Value Start-DotfilesGit
git clone --bare git@github.com:weimeng/dotfiles.git $HOME\.dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

Add Powershell functions and aliases for Windows:

```powershell
Add-Content $PROFILE ". $HOME\.config\powershell\Microsoft.Powershell_profile.ps1"
```
