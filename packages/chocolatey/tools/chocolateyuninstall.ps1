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
