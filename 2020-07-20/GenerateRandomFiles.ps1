[CmdletBinding()]
param(
    [ValidateRange(1,25)]
    [int]$NumberOfFiles = 10
)

Import-Module .\PSGibberish.psm1

$FilePath = Join-Path -Path $PSScriptRoot -ChildPath 'SampleFiles'
if (-not (Test-Path -Path $FilePath)) {
    $null = New-Item -Path $FilePath -ItemType Directory
}

for ($FileCount = 1; $FileCount -le $NumberOfFiles; $FileCount++) {

    $FileName = '{0}.txt' -f [System.IO.Path]::GetRandomFileName().Split('.')[0]
    $FullFileName = Join-Path -Path $FilePath -ChildPath $FileName

    Get-RandomDocument | Out-File -FilePath $FullFileName

}