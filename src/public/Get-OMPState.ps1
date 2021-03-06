function Get-OMPState {
    <#
    .SYNOPSIS
    Returns the current OhMyPsh state.
    .DESCRIPTION
    Returns the current OhMyPsh state. Includes the detected OS platform and other information discovered at load time.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Get-OMPState
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
    process {}
    end {
        $Script:OMPState
        Write-Verbose "$($FunctionName): End."
    }
}
