function Test-OMPInAGitRepo {
    <#
    .SYNOPSIS
    Validate if the current path is a git repo.
    .DESCRIPTION
    Validate if the current path is a git repo.
    .LINK
    https://github.com/zloeber/OhMyPsh
    .EXAMPLE
    Test-OMPInAGitRepo
    .NOTES
    Author: Zachary Loeber
    #>

    if ((Test-Path ".git") -eq $TRUE) {
        return $TRUE
    }

    # Test within parent dirs
    $checkIn = (Get-Item .).parent
    while ($checkIn -ne $NULL) {
        $pathToTest = $checkIn.fullname + '/.git'
        if ((Test-Path $pathToTest) -eq $TRUE) {
            return $TRUE
        } else {
            $checkIn = $checkIn.parent
        }
    }

    return $FALSE
}
