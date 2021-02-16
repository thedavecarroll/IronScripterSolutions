#requires -Version 7
function Get-SumTotal {
    [CmdLetBinding()]
    param(
        [Parameter(Mandatory,Position = 0,ValueFromPipeline)]
        [ValidatePattern('^\d{1,10}$', ErrorMessage = '"{0}" does not match only numbers 0-9 with a maximum of 10.')]
        #[ValidatePattern('^\d{1,10}$')]
        #[ValidateScript({ if ($_ -notmatch '^\d{1,10}$') { throw ('{0}"{1}" does not match only numbers 0-9 with a maximum of 10.' -f [System.Environment]::NewLine,$_) } else { $true }})]
        [string]$Value,

        [switch]$Full
    )

    process {
        $NumberList = [System.Collections.ArrayList]::new()
        $Value.ToCharArray() | ForEach-Object {
            [void]$NumberList.Add([System.Char]::GetNumericValue($_))
        }
        $SumTotal = $NumberList | Measure-Object -Sum
        $Calculation = '{0} = {1}' -f ($NumberList -join ' + '),$SumTotal.Sum

        $SumTotalOutput = [PsCustomObject]@{
            Value = $Value
            NumberCount = $SumTotal.Count
            Sum = $SumTotal.Sum
            Calculation = $Calculation
        }

        $Calculation | Write-Verbose

        if ($PSBoundParameters.ContainsKey('Full')) {
            $SumTotalOutput
        } else {
            $SumTotalOutput.Sum
        }
    }
}