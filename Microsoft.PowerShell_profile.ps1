# configuration
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function TabCompleteNext


# convenience functions
function emc($a) {

& emacsclientw.exe -a emacs $a

}

function tmux() {
bash -c "tmux"
}

function gst(){
    git status
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



# git setup
Import-Module posh-git

Set-Alias ssh-agent "$env:ProgramFiles\git\usr\bin\ssh-agent.exe"
Set-Alias ssh-add "$env:ProgramFiles\git\usr\bin\ssh-add.exe"


Set-Alias mingw "c:/msys64/mingw64.exe"
Set-Alias g++ "C:\msys64\mingw64\bin\g++.exe
"


# ssh setup

Set-Variable -Name "SshIsSet" -Value $FALSE -Scope Global
function Ssh-setup {
    # no known working ssh agent setup exists... 
    # for now: call Ssh-setup when required and input password for key when prompted. least effort maximum "convenience" possible
    if ( -Not $SshIsSet){
        Set-Service ssh-agent -StartupType Automatic
        Start-SshAgent -Quiet
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


