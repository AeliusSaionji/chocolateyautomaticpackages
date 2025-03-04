﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'ImDisk-Toolkit'
  softwareName   = 'imdisk-toolkit*'
  fileType       = 'exe'
  file           = gi $toolsPath\*_x32.exe
  file64         = gi $toolsPath\*_x64.exe
  silentArgs     = '/fullsilent'
  validExitCodes = @(0)
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" "" }}

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"
