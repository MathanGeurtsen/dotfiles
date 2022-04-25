
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\mathan\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function TabCompleteNext

function balloon {
    Param(
        $title,
        $text
    )
    Add-Type -AssemblyName System.Windows.Forms 
    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
    $balloon.BalloonTipText = $text
    $balloon.BalloonTipTitle = $title
    $balloon.Visible = $true 
    $balloon.ShowBalloonTip(1)
}

