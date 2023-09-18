# ConvertToSymlink
A right-click context menu option to convert any Windows shortcut into a symlink

![image](https://github.com/Nerdsie/ConvertToSymlink/assets/1341449/cd182165-bf27-43e5-acee-8cd4d48dca0b)

# Elevate.exe
You will need https://github.com/PaoJiao/elevate because context menu options don't seem to run with admin privilages, which are required to create symlinks on windows apparently

# Setup
#### Adding 'convert to symlink' right click option

1) In the Registry Editor, navigate to 'Computer\HKEY_CLASSES_ROOT\lnkfile\'
2) Right click on lnkfile->new->Key and name is 'shell'
3) Right click shell->new->Key and name is 'ConvertToSymlink'
4) On the right side double click (Default) and enter "Convert to Symlink" -- This is the text that will appear in the context menu of shortcuts
5) Right click ConvertToSymlink->new->key and name is 'command'
6) Double click (Default) and enter one of the following, this is the command that will run when you click the "Convert to Symlink" option, %1 will be replaced with the path of the file you've chosen.

#### Specific commands you can use

1) C:\path\to\elevate.exe -c powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File "C:\path\to\ConvertToSymlink.ps1" "%1"
2) wscript.exe "C:\path\to\RunSilent.vbs" "%1"

   -- If you use #2, make sure to update the paths in RunSilent.vbs

1 is simpler and doesn't require any editing of files but will flash 2 command promps for half a second. 2 is slightly more complicated but barely flashes 1 command prompt for just a moment.
