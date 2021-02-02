#Requires -Version 5.1

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
        [string[]]$ExcludeProperty
    )

    # get the immediate object type
    $ObjectType = $Object.psobject.TypeNames[0]

    # set the name of the class
    if ($ClassName) {
        $BaseClassName = $ClassName
    } else {
        $BaseClassName = "My" + $ObjectType
    }

    # get properties
    if ($IncludeProperty -ne '*') {
        $Properties = $Object.psobject.properties | Where-Object {
            $_.Name -in $IncludeProperty -and
            $_.Name -notin $ExcludeProperty
        }
    } else {
        $Properties = $Object.psobject.properties | Where-Object {
            $_.Name -notin $ExcludeProperty
        }
    }

    # create stringbuilder
    $Indent = ' ' * 4
    $ClassDefinition = [StringBuilder]::new()
    [void]$ClassDefinition.AppendLine(('# class definition created by {0} at {1} for object type {2}' -f $MyInvocation.MyCommand,(Get-Date),$ObjectType))
    [void]$ClassDefinition.AppendLine('')
    [void]$ClassDefinition.AppendLine(('class {0} {{' -f $BaseClassName ))
    [void]$ClassDefinition.AppendLine('')

    # add all properties
    [void]$ClassDefinition.AppendLine(('{0}# properties' -f $Indent))
    foreach ($Property in $Properties) {
        [void]$ClassDefinition.AppendLine(('{0}[{1}]${2}' -f $Indent,$Property.TypeNameOfValue,$Property.Name))
    }
    [void]$ClassDefinition.AppendLine('')

    # add simple constructors
    [void]$ClassDefinition.AppendLine(('{0}# constructors' -f $Indent))
    [void]$ClassDefinition.AppendLine(('{0}{1} () {{ }}' -f $Indent,$BaseClassName))
    [void]$ClassDefinition.AppendLine(('{0}{1} ([{2}]$InputObject) {{' -f $Indent,$BaseClassName,$ObjectType))
    foreach ($Property in $Properties) {
        [void]$ClassDefinition.AppendLine(('{0}{0}$this.{1} = $InputObject.{1}' -f $Indent,$Property.Name))
    }
    [void]$ClassDefinition.AppendLine(('{0}}}' -f $Indent))
    [void]$ClassDefinition.AppendLine('')

    # end class
    [void]$ClassDefinition.AppendLine('}')

    # output class definition
    $ClassDefinition.ToString()
}