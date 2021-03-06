function Get-OMPGitBranchName {
    <#
    .SYNOPSIS
    Returns the git branch based on the current directory.
    .DESCRIPTION
    Returns the git branch based on the current directory.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Get-OMPGitBranchName
    .NOTES
    Author: Zachary Loeber
    #>
    $currentBranch = ''
    try {
        git branch | foreach {
            if ($_ -match "^\* (.*)") {
                $currentBranch += $matches[1]
            }
        }
    }
    catch {
        # do nothing but git likely isn't available
    }

    return $currentBranch
}
