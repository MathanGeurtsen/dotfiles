# configuration
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function TabCompleteNext


# convenience functions
function emc($a) {

& emacsclientw.exe -a emacs $a

}

function tmux() {
bash -c "tmux attach || tmux"
}

function zsh() {
bash -c "zsh"
}

function gst(){
    git status -uno
}

function History-Search {
    Param(
        [Alias('p')]
        $Pattern,
        [Alias('c')]
        $Context=1,
        [Alias('m')]
        $Max=10
    )
    $histFile = "$env:userprofile\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
    Get-Content $histFile  | Select-String -Pattern $Pattern -Context $Context | select -Last $max
}

function rmcd {
    Param(
        [Alias('d')]
        $directory
    )
    rm -Force -Recurse -Confirm:$false $directory
    mkdir $directory
    cd $directory
}

function hs {
    Param(
        [Alias('p')]
        $Pattern,
        [Alias('c')]
        $Context=1,
        [Alias('m')]
        $Max=10
    )
    History-Search -Pattern $Pattern -Context $Context -max $Max
}

function testbox {
    
}

function amIadmin {
([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
}

# git setup
Import-Module posh-git

Set-Alias ssh-agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
Set-Alias ssh-add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"


Set-Alias mingw "c:/msys64/mingw64.exe"
Set-Alias g++ "C:\msys64\mingw64\bin\g++.exe
"

Set-Variable -Name "SshIsSet" -Value $FALSE -Scope Global
function Ssh-setup {
    # no known working ssh agent setup exists... 
    # for now: call Ssh-setup when required and input password for key when prompted. least effort maximum "convenience" possible
    if ( -Not $SshIsSet){
        Get-Service -Name ssh-agent | Set-Service -StartupType Manual
        # Set-Service ssh-agent -StartupType Automatic
        Start-Ssh-Agent -Quiet
        ssh-add ~/.ssh/github
        ssh-add ~/.ssh/gitlab_pc
        if( $?)
        {
            Set-Variable -Name "SshIsSet" -Value $TRUE -Scope Global
        }
        else
        {
            Write-Host "Could not add github key"
        }
    }
}

function msys-setup {
    $Env:CC="gcc"
    $Env:FC="gfortran"
    $Env:CXX="g++"
    $Env:path += ";C:/msys64/mingw64/bin/;C:\msys64\usr\bin"
}

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

function small-time {
    Get-Date -Format 'HH:mm:ss'
}

function background-verify-connection {
    param(
    [parameter(Mandatory=$false)]
    [String]$PingHost
    )

    if (! $PingHost){
        $PingHost = "8.8.8.8"
    }

    while ($true) { 
        test-connection -Count 1 8.8.8.8 > Out-Null 2>1
        if (! $?) {
            Write-Host "$(small-time) connection seems down!"
            balloon "Connection lost" "checking again in 3 seconds..."
            while ($true) {
                test-connection -Count 1 8.8.8.8 > Out-Null 2>1
                if ( $?) {
                    balloon "Connection reestablished" "resuming normal checking in 10 seconds"
                    Write-Host "$(small-time) connection up!"
                    sleep 10
                    break
                }
                sleep 3
                Write-Host "$(small-time) connection still down"
            }
        }
        else {
            Write-Host "$(small-time) connection up!"
        }
        sleep 10
    }
}



# outdated code, but something like this might be reasonable?
#     Param(
#         $git = "n"
#     )

#     }
#     }

#     }

#     }
# }

#     Param(
#         $dir = "",
#         $git = "n"
#     )
#     Write-Host changing to dir: $dir
#     pushd $dir
    
#     Ssh-Setup

#     if ($git -eq "y") {
#         git fetch
#         git status
#     }
# }

# function go-p {
#     Param(
#         $git = "n"
#     )
# }

# unnessary except as example code
#     #-- configure a profile
#       --idp-provider Okta `
#       --mfa=Auto `
#       --skip-prompt 

#     # --- login with the profile
#       --force

#     #-- set environment variables according to the profile

#     if($?) {
#     Write-Host "| Setting environment variables"
#     }
#     else
#     {
#         Write-Host "| ERROR: configuration or login was unsuccesful, not writing environment variables."
#     }
    
# }

cd ~/


