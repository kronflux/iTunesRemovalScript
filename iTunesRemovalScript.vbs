On Error Resume Next
Const HKEY_LOCAL_MACHINE = &H80000002
strComputer = "."
Set WshShell = CreateObject("wscript.Shell")

Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_
strComputer & "\root\default:StdRegProv")

strKeyPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
oReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys

For Each subkey In arrSubKeys
    strDisplayName = WshShell.RegRead ("HKLM\" & strKeyPath & "\" & subkey & "\DisplayName")
    If  strDisplayName = "iTunes" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Application Support (32-bit)" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Application Support (64-bit)" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Mobile Device Support" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Software Update" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Bonjour" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
Next

strKeyPath = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
oReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys

For Each subkey In arrSubKeys
    strDisplayName = WshShell.RegRead ("HKLM\" & strKeyPath & "\" & subkey & "\DisplayName")
    If  strDisplayName = "iTunes" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Application Support (32-bit)" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Application Support (64-bit)" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Mobile Device Support" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Apple Software Update" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
    If  strDisplayName = "Bonjour" Then
     WshShell.Run "msiexec.exe /norestart /X " & SubKey & " /qn", 7, True
    End If
Next
