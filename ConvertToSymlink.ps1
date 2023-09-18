param([string]$shortcutPath)

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "This script requires administrative privileges. Please run as an administrator."
    exit
}

if (-not ($shortcutPath -like "*.lnk")) {
    Write-Error "$shortcutPath is not a shortcut. Exiting script."
    exit
}

# Resolve path because for some reason relative path was causing some issues when reading the shortcut
$shortcutPath = Resolve-Path $shortcutPath

if (-not (Test-Path $shortcutPath)) {
    Write-Error "$shortcutPath is not a valid path, no file/shortcut is found at this location."
    exit
}

# Load the necessary COM object for working with shortcuts
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$targetPath = $shortcut.TargetPath
$targetExt = [System.IO.Path]::GetExtension($targetPath)
$targetExt

if (-not $targetPath){
    Write-Error "$shortcutPath is an invalid shortcut, try specifying the full path to the file."
    exit
}

$linkPath = $shortcutPath
# If default shortcut name, try to remove it
if ($linkPath -like "* - Shortcut.lnk") {
    $linkPath = $linkPath -replace ' - Shortcut.lnk$', ""
    
    # If somebody changed the extension on the shortcut (ie: '.txt.lnk -> .exe.lnk') we want to make sure the symlink has the proper extension
    # because if it gets copy-pasted, it will copy-paste the whole file with whatever extension is on the symlink.

    if (-not($linkPath -like "*$targetExt")) {
        $linkPath = $linkPath + $targetExt
    }
}

if (Test-Path $linkPath) {
    Write-Error "A file already exists at $linkPath. Exiting script."
    exit
}
    
# Create a symbolic link in place of the shortcut
New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath

# Remove the original shortcut
Remove-Item -Path $shortcutPath
