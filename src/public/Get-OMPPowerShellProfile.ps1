function Get-OMPPowerShellProfile {
    <#
    .SYNOPSIS
    Retrieves the current session PowerShell profile.
    .DESCRIPTION
    Retrieves the current session PowerShell profile.
    .PARAMETER ProfileType
    The type of profile to show the contents of.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Get-OMPPowerShellProfile
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet('AllUsersAllHosts','AllUsersCurrentHost','CurrentUserAllHosts','CurrentUserCurrentHost')]
        [string]$ProfileType = 'CurrentUserCurrentHost'
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
    }
    end {
        if (Test-Path $PROFILE.$ProfileType) {
            Get-Content $PROFILE.$ProfileType
        }
        else {
            Write-Warning "$($FunctionName): Profile does not exist - $($PROFILE.$ProfileType)"
        }
        Write-Verbose "$($FunctionName): End."
    }
}
