function GET-OMPOSPlatform {
    <#
    .SYNOPSIS
    Retrieve the current OS platform.
    .DESCRIPTION
    Retrieve the current OS platform.
    .PARAMETER IncludeLinuxDetails
    Get further details about the possible linux distribution in use.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Get-OMPOSPlatform
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [Parameter()]
        [Switch]$IncludeLinuxDetails
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
        $ThisIsCoreCLR = if ($IsCoreCLR) {$True} else {$False}
        $ThisIsLinux = if ($IsLinux) {$True} else {$False} #$Runtime::IsOSPlatform($OSPlatform::Linux)
        $ThisIsOSX = if ($IsOSX) {$True} else {$False} #$Runtime::IsOSPlatform($OSPlatform::OSX)
        $ThisIsWindows = if ($IsWindows) {$True} else {$False} #$Runtime::IsOSPlatform($OSPlatform::Windows)

        if (-not ($ThisIsLinux -or $ThisIsOSX)) {
            $ThisIsWindows = $true
        }

        if ($ThisIsLinux) {
            if ($IncludeLinuxDetails) {
                $LinuxInfo = Get-Content /etc/os-release | ConvertFrom-StringData
                $IsUbuntu = $LinuxInfo.ID -match 'ubuntu'
                if ($IsUbuntu -and $LinuxInfo.VERSION_ID -match '14.04') {
                    return 'Ubuntu 14.04'
                }
                if ($IsUbuntu -and $LinuxInfo.VERSION_ID -match '16.04') {
                    return 'Ubuntu 16.04'
                }
                if ($LinuxInfo.ID -match 'centos' -and $LinuxInfo.VERSION_ID -match '7') {
                    return 'CentOS'
                }
            }
            return 'Linux'
        }
        elseif ($ThisIsOSX) {
            return 'OSX'
        }
        elseif ($ThisIsWindows) {
            return 'Windows'
        }
        else {
            return 'Unknown'
        }
        Write-Verbose "$($FunctionName): End."
    }
}
