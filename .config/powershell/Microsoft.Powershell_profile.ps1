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
}
Set-Alias -Name dotfiles -Value Start-DotfilesGit
