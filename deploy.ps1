$SCRIPT_FILE =  $MyInvocation.MyCommand.Path

# Check for symbolic link
if ((Get-Item $SCRIPT_FILE | Select-Object -ExpandProperty Mode)  -match "l") {
    $SCRIPT_FILE = (Get-Item $SCRIPT_FILE | Select-Object -ExpandProperty Target)
}
$DOTFILES_DIR = $(get-item $SCRIPT_FILE).Directory.FullName

new-item -itemtype symboliclink -path $env:HOME -name ".bashrc" -value $DOTFILES_DIR\.bashrc
new-item -itemtype symboliclink -path $env:HOME -name ".zshrc" -value $DOTFILES_DIR\.zshrc
new-item -itemtype symboliclink -path $env:HOME -name ".tmux.conf" -value $DOTFILES_DIR\.tmux.conf
new-item -itemtype symboliclink -path $env:HOME -name ".emacs.d" -value $DOTFILES_DIR\.emacs.d
new-item -itemtype symboliclink -path $env:HOME/Documents/WindowsPowerShell/ -name "Microsoft.PowerShell_profile.ps1" -value $DOTFILES_DIR\Microsoft.PowerShell_profile.ps1
