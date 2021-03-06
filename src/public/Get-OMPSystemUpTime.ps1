function Get-OMPSystemUpTime {
    <#
    .SYNOPSIS
    Retreive platform independant uptime informaton (should run on both linux and windows properly).
    .DESCRIPTION
    Retreive platform independant uptime informaton (should run on both linux and windows properly).
    .LINK
    https://github.com/zloeber/OhMyPsh
    .PARAMETER FromSleep
    For windows you can retrieve the time that the system has been up since it last was in sleep mode. Uses event log entries to determine and can be time consuming.
    .EXAMPLE
    Get-OMPSystemUpTime
    .NOTES
    Author: Zachary Loeber
    #>

    [CmdletBinding()]
    param(
        [switch]$FromSleep
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
        function Test-EventLogSource {
            param(
                [Parameter(Mandatory = $true)]
                [string] $SourceName
            )
            try {
                [System.Diagnostics.EventLog]::SourceExists($SourceName)
            }
            catch {
                $false
            }
        }
    }
    process {}
    end {
        switch ( Get-OMPOSPlatform -ErrorVariable null ) {
            'Linux' {
                # Add me!
            }
            'OSX' {
                # Add me!
            }
            Default {
                if (-not $FromSleep) {
                    $os = Get-WmiObject win32_operatingsystem
                    $Uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
                }
                elseif (Test-EventLogSource 'Microsoft-Windows-Power-Troubleshooter') {
                    try {
                        $LastPowerEvent = (Get-EventLog -LogName system -Source 'Microsoft-Windows-Power-Troubleshooter' -Newest 1 -ErrorAction:Stop).TimeGenerated
                    }
                    catch {
                        $error.Clear()
                    }
                    if ($LastPowerEvent -ne $null) {
                        $Uptime = ( (Get-Date) - $LastPowerEvent )
                    }
                }
                if ($Uptime -ne $null) {
                    $Display = "" + $Uptime.Days + " days / " + $Uptime.Hours + " hours / " + $Uptime.Minutes + " minutes"
                    Write-Output $Display
                }
            }
        }
        Write-Verbose "$($FunctionName): End."
    }
}
