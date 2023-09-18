Set objShell = CreateObject("WScript.Shell")
convertScript = "C:\Windows\System32\WindowsPowerShell\v1.0\scripts\ConvertToSymlink.ps1"
path = Trim(WScript.Arguments(0))
command = """E:\Program Files\Elevate\elevate.exe"" -c powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -File """ & convertScript & """ """ & path & """"
objShell.Run command, 0, False
