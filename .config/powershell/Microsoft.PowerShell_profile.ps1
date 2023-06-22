# Starship Prompt
Invoke-Expression (&starship init powershell)

# Dotfiles
function Start-DotfilesGit
{
  param(
    [string[]]
    [Parameter(ValueFromRemainingArguments)]
    $Command = ' ')

  $ArgumentList = @("--git-dir=$HOME\.dotfiles\", "--work-tree=$HOME") + ($Command -join ' ')

  Start-Process -NoNewWindow -Wait -FilePath "C:\Program Files\Git\cmd\git.exe" -ArgumentList $ArgumentList

  <#
    .SYNOPSIS
    Wraps git with --git-dir set to .dotfiles and --work-tree set to $HOME.

    .DESCRIPTION
    Wraps git with --git-dir set to .dotfiles and --work-tree set to $HOME.

    Arguments with quotes must only use double quotes (") and be escaped with a
    backtick (`). See this GitHub issue for more details:
    https://github.com/PowerShell/PowerShell/issues/5576#issuecomment-1127215848

    .EXAMPLE
    Start-DotfilesGit commit -m `"This is a commit message`"
  #>
}
Set-Alias -Name dotfiles -Value Start-DotfilesGit
