$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/ton-blockchain/ton/releases/latest/download/ton-win-x86-64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url64bit      = $url64
  softwareName  = 'ton*'
  checksum64    = 'F0DABFB12A8886BE6B665A3A161C04D7FD54290A15F1E99B71AB6CE1FD2588B5'
  checksumType64= 'sha256'
}

Function Ensure-RemovedFromPath ($PathToRemove,$Scope,$PathVariable)
{
  If (!$Scope) {$Scope='Machine'}
  If (!$PathVariable) {$PathVariable='PATH'}
  $ExistingPathArray = @([Environment]::GetEnvironmentVariable("$PathVariable","$Scope").split(';'))
  write-host "Ensuring `"$PathToRemove`" is removed from variable `"$PathVariable`" for scope `"$scope`" "

  if (($ExistingPathArray -icontains $PathToRemove) -OR ($ExistingPathArray -icontains "$PathToRemove"))
  {
    foreach ($path in $ExistingPathArray)
    {
      If ($Path)
      {
        If (($path -ine "$PathToRemove") -AND ($path -ine "$PathToRemove\"))
        {
          [string[]]$Newpath += "$path"
        }
      }
    }
    $AssembledNewPath = ($Newpath -join(';')).trimend(';')
    [Environment]::SetEnvironmentVariable("$PathVariable",$AssembledNewPath,"$Scope")
  }
}

Ensure-RemovedFromPath "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 'User'
Uninstall-ChocolateyZipPackage @packageArgs
