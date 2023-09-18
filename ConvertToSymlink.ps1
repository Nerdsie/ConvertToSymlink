param([string]$shortcutPath)

# Check if the current user is an administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "This script requires administrative privileges. Please run as an administrator."
    exit
}

if (-not ($shortcutPath -like "*.lnk")) {
    Write-Error "$shortcutPath is not a shortcut. Exiting script."
    exit
}

$linkPath = $shortcutPath -replace '\.lnk$', '.jar'

if (Test-Path $linkPath) {
    Write-Error "A file already exists at $linkPath. Exiting script."
    exit
}

# Load the necessary COM object for working with shortcuts
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$targetPath = $shortcut.TargetPath

# Remove the original shortcut
Remove-Item -Path $shortcutPath

# Create a symbolic link in place of the shortcut
New-Item -ItemType SymbolicLink -Path $linkPath -Target $targetPath