function Test-OMPIsElevated {
    <#
    .SYNOPSIS
    Platform independant validation if the current user is elevated as root or administrator.
    .DESCRIPTION
    Platform independant validation if the current user is elevated as root or administrator.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Test-OMPIsElevated
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
    }
    process {
    }
    end {
        switch ( Get-OMPOSPlatform -ErrorVariable null ) {
            'Linux' {
                # Add me!
            }
            'OSX' {
                # Add me!
            }
            Default {
                if (([System.Environment]::OSVersion.Version.Major -gt 5) -and ((New-object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
                    return $true
                }
                else {
                    return $false
                }
            }
        }
        Write-Verbose "$($FunctionName): End."
    }
}
