# ConvertToSymlink
A right-click context menu option to convert any Windows shortcut into a symlink

# Elevate.exe
You will need https://github.com/PaoJiao/elevate because context menu options don't seem to run with admin privilages, which are required to create symlinks on windows apparently

In the Registry Editor, navigate to 'Computer\HKEY_CLASSES_ROOT\lnkfile\'
Right click on lnkfile->new->Key and name is 'shell'
Right click shell->new->Key and name is 'ConvertToSymlink'
On the right side double click (Default) and enter "Convert to Symlink" -- This is the text that will appear in the context menu of shortcuts
Right click ConvertToSymlink->new->key and name is 'command'
Double click (Default) and enter one of the following, this is the command that will run when you click the "Convert to Symlink" option, %1 will be replaced with the path of the file you've chosen.
1) C:\path\to\elevate.exe -c powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File "C:\path\to\ConvertToSymlink.ps1" "%1"
2) wscript.exe "C:\path\to\RunSilent.vbs" "%1"

1 is simpler but will flash 2 command promps for half a second. 2 is slightly more complicated but barely flashes 1 command prompt for just a moment.
