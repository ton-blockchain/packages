$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/ton-blockchain/ton/releases/latest/download/ton-win-x86-64.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url64bit      = $url64
  softwareName  = 'ton*'
  checksum64    = '42B5D8AEB8ECCD8D92FA7C513E5B840E9175B0B356EB71F8C36E823985796101'
  checksumType64= 'sha256'
}

Install-ChocolateyPath -PathToInstall "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage @packageArgs
