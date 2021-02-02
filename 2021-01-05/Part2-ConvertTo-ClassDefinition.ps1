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
        [string[]]$HiddenProperty
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
    [void]$ClassDefinition.AppendLine(('class {0} {{' -f $BaseClassName))
    [void]$ClassDefinition.AppendLine('')

    # part 1: add all properties
    # part 2: create a new stringbuilder for the properties in the constructor so we only have to loop through properties once
    $ConstructorProperty = [StringBuilder]::new()

    [void]$ClassDefinition.AppendLine(('{0}# properties' -f $Indent))
    foreach ($Property in $Properties) {

        # part 2: ensure proper PascalCase of the property
        $PascalCaseProperty = ConvertTo-PascalCase -String $Property.Name

        # part 2: ensure best guess for string values for PSCustomObject objects
        $PropertySetter = '$InputObject.{0}' -f $Property.Name
        if ($Property.TypeNameOfValue -match 'string' -and $ObjectType -eq 'PSCustomObject' ) {
            $PropertyTypeConversion = Resolve-PropertyType -PropertyValue $Property.Value
            $PropertyTypeName = $PropertyTypeConversion | Select-Object -First 1
            if ('Parse' -in $PropertyTypeConversion) {
                $PropertySetter = '[datetime]::Parse($InputObject.{0},(Get-Culture))' -f $Property.Name
            } elseif ('ParseExact' -in $PropertyTypeConversion) {
                $PropertySetter = '[datetime]::ParseExact($InputObject.{0},''{1}'',(Get-Culture))' -f $Property.Name,$PropertyTypeConversion[2]
            }
        } else {
            if ($Property.TypeNameOfValue -match 'PSCustomObject') {
                $PropertyTypeName = 'PSCustomObject'
            } else {
                $PropertyTypeName = $Property.TypeNameOfValue
            }
        }

        # part 2: if a property needs to be hidden, add that to the property statement
        if ($Property.Name -in $HiddenProperty -or $PascalCaseProperty -in $HiddenProperty) {
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
    [void]$ClassDefinition.AppendLine($ConstructorProperty.ToString())

    [void]$ClassDefinition.AppendLine(('{0}}}' -f $Indent))
    [void]$ClassDefinition.AppendLine('')

    # end class
    [void]$ClassDefinition.AppendLine('}')

    # output class definition
    $ClassDefinition.ToString()
}
