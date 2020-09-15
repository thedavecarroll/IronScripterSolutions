@{

RootModule = 'Geometry.psm1'
ModuleVersion = '0.0.1'
CompatiblePSEditions = @('Core')
GUID = '20f5ad03-55dd-424f-b060-a6b23fc54e10'
Author = 'Dave Carroll'
CompanyName = 'thedavecarroll'
Copyright = '(c) 2020 Dave Carroll. All rights reserved.'
Description = 'IronScripter Back-To-School Challenge - Geometry'

PowerShellVersion = '6.1'

FunctionsToExport = 'Measure-RightTriangle','Measure-Circle',
    'Measure-Sphere','Measure-Cylinder','Get-Factorial'

CmdletsToExport = @()
AliasesToExport = @()
PrivateData = @{ PSData = @{} }

}

