# Beginner Challenge Functions

# get hypotenuse of a right triangle
function Get-Hypotenuse {
    param($SideA,$SideB)
    [math]::Sqrt(([math]::Pow($SideA,2) + [math]::Pow($SideB,2) ) )
}

# calculate the area of a circle with a given diameter
function Get-CircleArea {
    param($Diameter)
    $Radius = $Diameter / 2
    [Math]::PI * [Math]::Pow($Radius,2)
}

# calculate the volume of a sphere with a given diameter
function Get-SphereVolume {
    param($Diameter)
    $Radius = $Diameter / 2
    (4 / 3) * [Math]::PI * [Math]::Pow($Radius,3)
}

# calculate the volume of a cylinder from a given diameter and height
function Get-CylinderVolume {
    param($Diameter,$Height)
    $Radius = $Diameter / 2
    [Math]::PI * [Math]::Pow($Radius,2) * $Height
}

# calculate the factorial of an integer
function Get-Factorial {
    param($Integer)
    $Factorial = 1
    1..$Integer | Foreach-Object { $Factorial *= $_ }
    $Factorial
}