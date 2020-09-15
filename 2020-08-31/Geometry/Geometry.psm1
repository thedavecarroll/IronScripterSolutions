function Measure-RightTriangle {
    param(
        [Parameter(ParameterSetName='Hypotenuse',Mandatory)]
        [Parameter(ParameterSetName='SideB',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$SideA,

        [Parameter(ParameterSetName='Hypotenuse',Mandatory)]
        [Parameter(ParameterSetName='SideA',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$SideB,

        [Parameter(ParameterSetName='SideA',Mandatory)]
        [Parameter(ParameterSetName='SideB',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$Hypotenuse,

        [switch]$Area,

        [switch]$Perimeter,

        [ValidateRange(0,28)]
        [Nullable[int]]$Precision
    )

    # switches can be used to limit to the output value only
    # only one switch can be used per call
    # the return value is the name of the cylinder's property
    $Switches = [regex]::Matches($PSBoundParameters.Keys,'Area|Perimeter')
    if ($Switches.count -gt 1) {
        'Include Area, Perimeter, or neither but not both.' | Write-Warning
        return
    } elseif ($Switches.count -eq 1) {
        $ReturnValue = $Switches[0]
    } else {
        $ReturnValue = $false
    }

    # calculate the side not provided
    $BadCalculation = 'Error calculating the {0} for the right angle. Please try again.'
    switch ($PSCmdlet.ParameterSetName) {
        'Hypotenuse' {
            $HypotenuseValue = [math]::Sqrt(([math]::Pow($SideA,2) + [math]::Pow($SideB,2) ) )
        }
        'SideA' {
            $SideAValue = [math]::Sqrt(([math]::Pow($Hypotenuse,2) - [math]::Pow($SideB,2) ) )
            if ($SideAValue -match [double]::NaN) {
                $BadCalculation -f 'SideA' | Write-Error -ErrorAction Stop
            }
        }
        'SideB' {
            $SideBValue = [math]::Sqrt(([math]::Pow($Hypotenuse,2) - [math]::Pow($SideA,2) ) )
            if ($SideBValue -match [double]::NaN) {
                $BadCalculation -f 'SideB'  | Write-Error -ErrorAction Stop
            }
        }
    }

    # calculate the area and perimter
    $AreaValue = ($SideAValue * $SideBValue) / 2
    $PerimeterValue = $SideAValue + $SideBValue + $HypotenuseValue

    # handle precision if provided
    if ($null -ne $Precision) {
        $SideAValue = [math]::Round($SideAValue,$Precision)
        $SideBValue = [math]::Round($SideBValue,$Precision)
        $HypotenuseValue = [math]::Round($HypotenuseValue,$Precision)
        $AreaValue = [math]::Round($AreaValue,$Precision)
        $PerimeterValue = [math]::Round($PerimeterValue,$Precision)
    }

    # create rich object
    # by setting the PSTypeName value, we are effectively creating that type.
    # all object properties will be NoteProperty type.
    $RightTriangle = [PSCustomObject]@{
        PSTypeName = 'Math.Geometry.RightTriangle'
        SideA = $SideAValue
        SideB = $SideBValue
        Hypotenuse = $HypotenuseValue
        Area = $AreaValue
        Perimeter = $PerimeterValue
        Precision = $Precision
    }

    # if specific value switches are used, output just that value
    if ($ReturnValue) {
        $RightTriangle.$ReturnValue
    } else {
        $RightTriangle
    }

}

function Measure-Circle {
    [CmdletBinding(DefaultParameterSetName='Diameter')]
    param(
        [Parameter(ParameterSetName='Diameter')]
        [ValidateRange('Positive')]
        [decimal]$Diameter,

        [Parameter(ParameterSetName='Radius')]
        [ValidateRange('Positive')]
        [decimal]$Radius,

        [switch]$Area,

        [switch]$Circumference,

        [ValidateRange(0,28)]
        [Nullable[int]]$Precision
    )

    # switches can be used to limit to the output value only
    # only one switch can be used per call
    # the return value is the name of the circle's property
    $Switches = [regex]::Matches($PSBoundParameters.Keys,'Area|Circumference')
    if ($Switches.count -gt 1) {
        'Include Area, Circumference, or neither but not both.' | Write-Warning
        return
    } elseif ($Switches.count -eq 1) {
        $ReturnValue = $Switches[0]
    } else {
        $ReturnValue = $false
    }

    # get the diameter or radius based on the input
    if ($PSCmdlet.ParameterSetName -eq 'Radius') {
        $RadiusValue = $Radius
        $DiameterValue = $Radius * 2
    } else {
        $DiameterValue = $Diameter
        $RadiusValue = $Diameter / 2
    }

    # calculate the area and circumference
    $AreaValue = [math]::PI * [math]::Pow($RadiusValue,2)
    $CircumferenceValue = 2 * [math]::PI * $RadiusValue

    # handle precision if provided
    if ($null -ne $Precision) {
        $DiameterValue = [math]::Round($DiameterValue,$Precision)
        $RadiusValue = [math]::Round($RadiusValue,$Precision)
        $AreaValue = [math]::Round($AreaValue,$Precision)
        $CircumferenceValue = [math]::Round($CircumferenceValue,$Precision)
    }

    # create rich object
    $Circle = [PSCustomObject]@{
        PSTypeName = 'Math.Geometry.Circle'
        Radius = $RadiusValue
        Diameter = $DiameterValue
        Area = $AreaValue
        Circumference = $CircumferenceValue
        Precision = $Precision
    }

    # if specific value switches are used, output just that value
    if ($ReturnValue) {
        $Circle.$ReturnValue
    } else {
        $Circle
    }
}

function Measure-Sphere {
    param(
        [Parameter(ParameterSetName='Diameter',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$Diameter,

        [Parameter(ParameterSetName='Radius',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$Radius,

        [switch]$Volume,

        [switch]$SurfaceArea,

        [ValidateRange(0,28)]
        [Nullable[int]]$Precision
    )

    # switches can be used to limit to the output value only
    # only one switch can be used per call
    # the return value is the name of the sphere's property
    $Switches = [regex]::Matches($PSBoundParameters.Keys,'Volume|SurfaceArea')
    if ($Switches.count -gt 1) {
        'Include Volume, SurfaceArea, or neither but not both.' | Write-Warning
        return
    } elseif ($Switches.count -eq 1) {
        $ReturnValue = $Switches[0]
    } else {
        $ReturnValue = $false
    }

    # caluclate diameter or radius
    if ($PSCmdlet.ParameterSetName -eq 'Diameter') {
        $DiameterValue = $Diameter
        $RadiusValue = $Diameter / 2
    } else {
        $DiameterValue = $Radius * 2
        $RadiusValue = $Radius
    }

    # calculate the volume and surface area
    $VolumeValue = (4 / 3) * [math]::PI * [math]::Pow($RadiusValue,3)
    $SurfaceAreaValue = 4 * [math]::PI *[math]::Pow($RadiusValue,2)

    # handle precision if provided
    if ($null -ne $Precision) {
        $DiameterValue = [math]::Round($DiameterValue,$Precision)
        $RadiusValue = [math]::Round($RadiusValue,$Precision)
        $VolumeValue = [math]::Round($VolumeValue,$Precision)
        $SurfaceAreaValue = [math]::Round($SurfaceAreaValue,$Precision)
    }

    # create rich object
    $Sphere = [PSCustomObject]@{
        PSTypeName = 'Math.Geometry.Sphere'
        Radius = $RadiusValue
        Diameter = $DiameterValue
        Volume = $VolumeValue
        SurfaceArea = $SurfaceAreaValue
        Precision = $Precision
    }

    # if specific value switches are used, output just that value
    if ($ReturnValue) {
        $Sphere.$ReturnValue
    } else {
        $Sphere
    }

}

function Measure-Cylinder {
    param(
        [Parameter(ParameterSetName='Diameter',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$Diameter,

        [Parameter(ParameterSetName='Radius',Mandatory)]
        [ValidateRange('Positive')]
        [decimal]$Radius,

        [ValidateRange('Positive')]
        [decimal]$Height,

        [switch]$Volume,

        [switch]$SurfaceArea,

        [switch]$LateralSurface,

        [switch]$BaseArea,

        [ValidateRange(0,28)]
        [Nullable[int]]$Precision
    )

    # switches can be used to limit to the output value only
    # only one switch can be used per call
    # the return value is the name of the cylinder's property
    $Switches = [regex]::Matches($PSBoundParameters.Keys,'Volume|SurfaceArea|LateralSurface|BaseArea')
    if ($Switches.count -gt 1) {
        'Include Volume, SurfaceArea, LateralSurface, BaseArea, or none but not more than one.' | Write-Warning
        return
    } elseif ($Switches.count -eq 1) {
        $ReturnValue = $Switches[0]
    } else {
        $ReturnValue = $false
    }

    # caluclate diameter or radius
    if ($PSCmdlet.ParameterSetName -eq 'Diameter') {
        $DiameterValue = $Diameter
        $RadiusValue = $Diameter / 2
    } else {
        $DiameterValue = $Radius * 2
        $RadiusValue = $Radius
    }

    # calulate all the values
    $VolumeValue = [math]::PI * [math]::Pow($RadiusValue,2) * $Height
    $SurfaceAreaValue = (2 * [math]::PI * $RadiusValue * $Height) + (2 * [math]::PI * [math]::Pow($RadiusValue,2))
    $LateralSurfaceValue = 2 * [math]::PI * $RadiusValue * $Height
    $BaseAreaValue = [math]::PI * [math]::Pow($RadiusValue,2)

    # handle precision if provided
    if ($null -ne $Precision) {
        $DiameterValue = [math]::Round($DiameterValue,$Precision)
        $RadiusValue = [math]::Round($RadiusValue,$Precision)
        $VolumeValue = [math]::Round($VolumeValue,$Precision)
        $SurfaceAreaValue = [math]::Round($SurfaceAreaValue,$Precision)
        $LateralSurfaceValue = [math]::Round($LateralSurfaceValue,$Precision)
        $BaseAreaValue = [math]::Round($BaseAreaValue,$Precision)
    }

    # create rich object
    $Cylinder = [PSCustomObject]@{
        PSTypeName = 'Math.Geometry.Cylinder'
        Radius = $RadiusValue
        Diameter = $DiameterValue
        Volume = $VolumeValue
        SurfaceArea = $SurfaceAreaValue
        LateralSurface = $LateralSurfaceValue
        BaseArea = $BaseAreaValue
        Precision = $Precision
    }

    # if specific value switches are used, output just that value
    if ($ReturnValue) {
        $Cylinder.$ReturnValue
    } else {
        $Cylinder
    }

}

function Get-Factorial {
    param(
        [ValidateRange('NonNegative')]
        [int]$Integer,
        [switch]$ValueOnly
    )
    if ($Integer -eq 0) {
        $FactorialObject = [PsCustomObject]@{
            Factorial = 1
            Solution = '0! = 1 (forced)'
        }
    } else {
        $Factorial = 1
        $Solution = @()
        $Integer..1 | Foreach-Object {
            $Factorial *= $_
            $Solution += $_
        }
        $FactorialObject =  [PsCustomObject]@{
            Factorial = $Factorial
            Solution = '{0}! = {1}' -f $Integer,($Solution -join ' x ')
        }
    }

    if ($ValueOnly) {
        $FactorialObject.Factorial
    } else {
        $FactorialObject
    }
}