function ConvertTo-PascalCase {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [string[]]$String
    )
    begin {
        $Culture = Get-Culture
    }
    process {
        foreach ($Word in $String) {
            $Words = $Word -split '\W|_'
            $PascalCase = if ($Words.Count -gt 1)  {
                $Words | ForEach-Object {
                    $Culture.TextInfo.ToTitleCase($_.ToLower())
                }
            } else {
                if ($Word -cnotmatch '^[A-Z]') {
                    return $Culture.TextInfo.ToTitleCase($Word)
                } else {
                    return $Word
                }
            }
        }
        $PascalCase -join ''
    }
}