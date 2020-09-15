# PowerShell Back-to-School Scripting Challenge

## Beginner Level

Create a PowerShell function for each of these goals.

- [x] Given 2 lengths of a right triangle, calculate the missing length. You will need to let the user specify which sides (traditionally A, B and C) of the triangle they are specifying.
- [x] Calculate the area of a circle with a given diameter.
- [x] Calculate the volume of a sphere with a given diameter.
- [x] Calculate the volume of a cylinder from a given diameter and height.
- [x] Calculate the factorial of an integer.

### Beginner Solution

For the beginner level challenge, please review the `GeometryMath-Beginner.ps1` in the same folder as this file.

I did not provide validation or error handling.
And I only provided the computed value.

## Intermediate Level

- [x] Include parameter validation
- [x] Option to write rich object to the pipeline (or specify which value you want)
- [x] Create a simple module with a manifest

### Intermediate Solution

For the intermediate level challenge, I wrote the `Geometry` script module.

#### Learning Points

- Module Manifest
  - Used `New-ModuleManifest` to generate a new module manifest, `Geometry.psd1`.
  - Specified minimum PowerShellVersion for module (see ValidateRange below)
    - `PowerShellVersion = '6.1'`
  - Used the `FunctionsToExport` key instead of `Export-ModuleMember` or dot-sourcing the functions file.
  - Rremoved unused/unneeded ones.
    - Note: I left the `CmdletsToExport` and `AliasesToExport` keys both with an empty array as instructed in comments of newly generated manifest.
- Appropriate Function Names
  - For all functions, except the one for calculating the factorial, I used the `Measure` verb.
    - Measure-RightTriangle
    - Measure-Circle
    - Measure-Sphere
    - Measure-Cylinder
    - Get-Factorial
- Parameter Sets
  - For all of the `Measure-*` functions, I used parameter sets to separate *diameter* and *radius* or other input.
- ValidateRange
  - Beginning in PowerShell 6.1, the `ValidateRange` parameter attribute accepts the `ValidateRangeKind`. See below for details.
- Nullable Types
  - For the `Precision` parameter on all functions, I used `[Nullable[int]]` with `[ValidateRange(0,28)` to specify that it can accept a `$null` or `int` between the values of 0 and 28, which is the range for `[math]::Round()`.
- Switches
  - Since many of the functions have multiple switches to return the corresponding values, I needed a way to restrict the function from allowing multiple switches used for each call.
  - I also use the switch to determine the property of the object to return.
  - By performing a simple regex on `$PSBoundParameters.Keys`, I would have access to the number of switches (that we care about) and the value (name).
    - Example: `$Switches = [regex]::Matches($PSBoundParameters.Keys,'Area|Perimeter')`
- .Net `[math]` class which provides constants and static methods (availabe without having to instantiate a new instance) for many math functions.
  - The `[math]::PI` constant contains the value of Pi.
  - The method `[math]::Sqrt($number)` returns the square root of a number.
  - The method `[math]::Pow($number,$power)` returns a number raised by another number.
  - The method `[math]::Round($decimal,$precision)` rounds the value to the provided decimal.
- The `[double]::NaN` is returned when a calculation returns *not a number*.
- Range Operator
  - For the factorial, I used a range operator, but I reversed the order from largest to smallest.
    - `$Integer..1`
- PSCustomObject/PSObject
  - PSTypeName
    - When creating a `PSCustomObject` or `PSObject`, you can add the `PSTypeName` property and specify a string value.
    - I used Math.Geometry prefix for all types, giving a final type like `Math.Geometry.Circle` which makes it look like a .Net namespace class name.
    - It's best to avoid existing type names.
    - For modules, consider using the module name as the first component.
  - Referencing a property with a variable.
    - For the `Measure-*` functions, when the user wants a specific value (and not the full object), I used a variable to reference the property name, e.g. `$Cylinder.$ReturnValue`

The `ValidateRangeKind` is an enum that allows the following values:

- Positive - A number greater than zero.
- Negative - A number less than zero.
- NonPositive - A number less than or equal to zero.
- NonNegative - A number greater than or equal to zero.

## Summary

I have been working on this solution since the challenge was presented, but wasn't able to put a considerable chunk of effort into it at any given time.

A few of the learning points were definitely new to me, such as `ValidateRangeKind` and the `[double]::NaN`. I knew of the `[math]` namespace, but I don't use it that often.

Overall, this was another fun challenge.

Please check out my other solutions in [this repository](https://github.com/thedavecarroll/IronScripterSolutions).
