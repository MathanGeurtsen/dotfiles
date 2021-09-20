$SCRIPT_FILE =  $MyInvocation.MyCommand.Path

[System.Environment]::SetEnvironmentVariable('HOME', 'C:/Users/mathan', [System.EnvironmentVariableTarget]::User)

# Check for symbolic link
if ((Get-Item $SCRIPT_FILE | Select-Object -ExpandProperty Mode)  -match "l") {
    $SCRIPT_FILE = (Get-Item $SCRIPT_FILE | Select-Object -ExpandProperty Target)
}
$DOTFILES_DIR = $(get-item $SCRIPT_FILE).Directory.FullName

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
Install-Module PowershellGet -Force
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

new-item -itemtype symboliclink -path $HOME -name ".bashrc" -value $DOTFILES_DIR\.bashrc
new-item -itemtype symboliclink -path $HOME -name ".zshrc" -value $DOTFILES_DIR\.zshrc
new-item -itemtype symboliclink -path $HOME -name ".vimrc" -value $DOTFILES_DIR\.vimrc
new-item -itemtype symboliclink -path $HOME -name ".wslconfig" -value $DOTFILES_DIR\.wslconfig
new-item -itemtype symboliclink -path $HOME -name ".tmux.conf" -value $DOTFILES_DIR\.tmux.conf
new-item -itemtype symboliclink -path $env:APPDATA -name ".emacs.d" -value $DOTFILES_DIR\.emacs.d

new-item -itemtype symboliclink -path $env:APPDATA/ -name "Microsoft.PowerShell_profile.ps1" -value $DOTFILES_DIR\Microsoft.PowerShell_profile.ps1
