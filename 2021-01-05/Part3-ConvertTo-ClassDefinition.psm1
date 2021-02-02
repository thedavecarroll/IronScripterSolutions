#Requires -Version 5.1
using namespace System.Management.Automation
using namespace System.Text

function ConvertTo-ClassDefinition {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [object]$Object,

        [ValidateNotNullOrEmpty()]
        [string]$ClassName,

        [ValidateNotNullOrEmpty()]
        [Alias('Include')]
        [string[]]$IncludeProperty = '*',

        [ValidateNotNullOrEmpty()]
        [Alias('Exclude')]
        [string[]]$ExcludeProperty,

        [ValidateNotNullOrEmpty()]
        [Alias('Hidden')]
        [string[]]$HiddenProperty,

        [ValidateNotNullOrEmpty()]
        [string[]]$Method
    )

    # get the immediate object type
    $ObjectTypeBase = $Object.psobject.TypeNames[0]

    # part 2: correct PSCustomObject input object
    if ($ObjectTypeBase -match 'PSCustomObject') {
        $ObjectType = 'PSCustomObject'
    } else {
        $ObjectType = $ObjectTypeBase
    }

    # set the name of the class
    # part 2: PascalCase the class name
    if ($ClassName) {
        $BaseClassName = $ClassName | ConvertTo-PascalCase
    } else {
        $BaseClassName = "My." + $ObjectType | ConvertTo-PascalCase
    }

    # huge bugfix: original property names or PascalCase property names should be allowed for included and excluded properties.
    $PascalCaseProperties = @{}
    $Object.psobject.properties | ForEach-Object {
        $PascalCaseProperties.Add((ConvertTo-PascalCase -String $_.Name),$_)
    }

    if ($IncludeProperty -ne '*') {
        $IncludeProperties = $PascalCaseProperties.Keys | Where-Object {
            ($_ -in $IncludeProperty -or $PascalCaseProperties[$_].Name -in $IncludeProperty)
        }
    } else {
        $IncludeProperties = $PascalCaseProperties.Keys
    }

    if ($ExcludeProperty) {
        $ExcludeProperties = $PascalCaseProperties.Keys | Where-Object {
            ($_ -in $ExcludeProperty -or $PascalCaseProperties[$_].Name -in $ExcludeProperty)
        }
    }
    if ($ExcludeProperties) {
        $Properties = Compare-Object -ReferenceObject $IncludeProperties -DifferenceObject $ExcludeProperties -PassThru | Where-Object { $_.SideIndicator -eq '<=' }
    } else {
        $Properties = $IncludeProperties
    }

    # create stringbuilder
    $Indent = ' ' * 4
    $ClassDefinition = [StringBuilder]::new()
    [void]$ClassDefinition.AppendLine(('# class definition created by {0} at {1} for object type {2}' -f $MyInvocation.MyCommand,(Get-Date),$ObjectType))
    [void]$ClassDefinition.AppendLine('')
    [void]$ClassDefinition.AppendLine(('class {0} {{' -f $BaseClassName))
    [void]$ClassDefinition.AppendLine('')

    # part 1: add all properties
    # part 2: create a new stringbuilder for the properties in the constructor so we only have to loop through properties once
    $ConstructorProperty = [StringBuilder]::new()

    [void]$ClassDefinition.AppendLine(('{0}# properties' -f $Indent))
    foreach ($PascalCaseProperty in $Properties) {

        # part 2: ensure best guess for string values for PSCustomObject objects
        $PropertySetter = '$InputObject.{0}' -f $PascalCaseProperties[$PascalCaseProperty].Name
        if ($PascalCaseProperties[$PascalCaseProperty].TypeNameOfValue -match 'string' -and $ObjectType -eq 'PSCustomObject' ) {
            $PropertyTypeConversion = Resolve-PropertyType -PropertyValue $PascalCaseProperties[$PascalCaseProperty].Value
            $PropertyTypeName = $PropertyTypeConversion | Select-Object -First 1
            if ('Parse' -in $PropertyTypeConversion) {
                $PropertySetter = '[datetime]::Parse($InputObject.{0},(Get-Culture))' -f $PascalCaseProperties[$PascalCaseProperty].Name
            } elseif ('ParseExact' -in $PropertyTypeConversion) {
                $PropertySetter = '[datetime]::ParseExact($InputObject.{0},''{1}'',(Get-Culture))' -f $PascalCaseProperties[$PascalCaseProperty].Name,$PropertyTypeConversion[2]
            }
        } else {
            if ($PascalCaseProperties[$PascalCaseProperty].TypeNameOfValue -match 'PSCustomObject') {
                $PropertyTypeName = 'PSCustomObject'

                # part 3: make it recursive
                $PascalCaseProperties[$PascalCaseProperty].Value | ConvertTo-ClassDefinition -ClassName "$BaseClassName$PascalCaseProperty"

            } else {
                $PropertyTypeName = $PascalCaseProperties[$PascalCaseProperty].TypeNameOfValue
            }
        }

        # part 2: if a property needs to be hidden, add that to the property statement
        if ($PascalCaseProperties[$PascalCaseProperty].Name -in $HiddenProperty -or $PascalCaseProperty -in $HiddenProperty) {
            $PropertyStatement = '{0}hidden [{1}]${2}' -f $Indent,$PropertyTypeName,$PascalCaseProperty
        } else {
            $PropertyStatement = '{0}[{1}]${2}' -f $Indent,$PropertyTypeName,$PascalCaseProperty
        }
        [void]$ClassDefinition.AppendLine($PropertyStatement)
        [void]$ConstructorProperty.AppendLine(('{0}{0}$this.{1} = {2}' -f $Indent,$PascalCaseProperty,$PropertySetter))

    }
    [void]$ClassDefinition.AppendLine('')

    # add simple constructors
    [void]$ClassDefinition.AppendLine(('{0}# constructors' -f $Indent))
    [void]$ClassDefinition.AppendLine(('{0}{1} () {{ }}' -f $Indent,$BaseClassName))
    [void]$ClassDefinition.AppendLine(('{0}{1} ([{2}]$InputObject) {{' -f $Indent,$BaseClassName,$ObjectType))

    # part 2: ensure proper PascalCase in the constructor
    [void]$ClassDefinition.AppendLine($ConstructorProperty.ToString().TrimEnd())
    [void]$ClassDefinition.AppendLine(('{0}}}' -f $Indent))

    # part 3: add methods, ensure proper PascalCase
    [void]$ClassDefinition.AppendLine('')
    foreach ($ThisMethod in $Method) {
        $PascalCaseMethod = ConvertTo-PascalCase -String $ThisMethod
        [void]$ClassDefinition.AppendLine(('{0}[OutputTypeName] {1} (' -f $Indent,$PascalCaseMethod))
        [void]$ClassDefinition.AppendLine(('{0}{0}[TypeName]$Param1,' -f $Indent))
        [void]$ClassDefinition.AppendLine(('{0}{0}[TypeName]$Param2' -f $Indent))
        [void]$ClassDefinition.AppendLine(('{0}) {{' -f $Indent))
        [void]$ClassDefinition.AppendLine(('{0}{0}# your code' -f $Indent))
        [void]$ClassDefinition.AppendLine(('{0}{0}return $Output' -f $Indent))
        [void]$ClassDefinition.AppendLine(('{0}}}' -f $Indent))
        [void]$ClassDefinition.AppendLine('')
    }

    # end class
    [void]$ClassDefinition.AppendLine('}')
    [void]$ClassDefinition.AppendLine('')

    # output class definition
    $ClassDefinition.ToString()
}

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