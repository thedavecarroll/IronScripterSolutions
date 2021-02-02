function Resolve-PropertyType {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$PropertyValue
    )

    $TwitterDateFormat ='ddd MMM dd HH:mm:ss zzz yyyy'

    # check for url
    try {
        [void][Uri]::new($PropertyValue)
        return 'Uri'
    }
    catch { } # do nothing, continue to next text

    # check for known date time
    try {
        [void][datetime]::Parse($PropertyValue,(Get-Culture))
        return 'DateTime','Parse'
    }
    catch { }

    # check for Twitter date time
    try {
        [void][datetime]::ParseExact($PropertyValue,$TwitterDateFormat,(Get-Culture))
        return 'DateTime','ParseExact',$TwitterDateFormat
    }
    catch { }

    return 'String'
}
