# A PowerShell Conversion Challenge

For this challenge, I wrote a seriers of extensive walk-through articles.

## Part 1

In [the part 1 article][SolutionPart1], I cover the basics for PowerShell objects and classes, `Get-Member` command, the `Requires` statement, `ValueFromPipeline`, and the `StringBuilder` class. My solution (part 1) solved 7 primary requirements and 1 personal requirement.

Standard

- [x] Copy selected properties
- [] Insert placeholder for methods
- [x] Work from pipeline
- [x] Allow user to specify a new class name
- [x] Support Windows PowerShell 5.1 and PowerShell 7.x

Bonus

- [x] Allow the user to include or exclude properties
- [x] Include a placeholder for a constructor
- [] Let the user specify a method
- [] Be VSCode aware an insert the new class automatically into the current file
- [x] Support cross-platform

Personal

- [] Contained in a small module, as there will be a few private functions.
- [] Use an existing PSCustomObject with non-conventional property names.
  - [] A private function would be used to enforce proper PascalCase casing and removal of punctuation (with maybe exception of period).
- [] Should be recursive.
  - [] Any object that contains a property which is itself another complex object should generate a separate class definition.
- [x] Generate two constructors:
  - [] One empty constructor to create a clean instance of the class.
  - [] One constructor that will use the input object to populate a new instance.
- [] Allow user to specify hidden properties.
- [] If not specified, detect the property type and include in definition.

[SolutionPart1]: https://powershell.anovelidea.org/powershell/creating-class-definition-from-object-part-1/

## Part 2

In [part 2][SolutionPart2], I solved 3 personal requirements, which included converting property and class names to PascalCase, detecting property types, and hiding properties.

Primary

- [] Insert placeholder for methods
- [] Let the user specify a method
- [] Be VSCode aware an insert the new class automatically into the current file

Personal

- [] Contained in a small module, as there will be a few private functions.
- [x] Use an existing PSCustomObject with non-conventional property names.
  - [x] A private function would be used to enforce proper PascalCase casing and removal of punctuation (with maybe exception of period).
- [] Should be recursive.
  - [] Any object that contains a property which is itself another complex object should generate a separate class definition.
- [x] Allow user to specify hidden properties.
- [x] If not specified, detect the property type and include in definition.

[SolutionPart2]: https://powershell.anovelidea.org/powershell/creating-class-definition-from-object-part-2/

## Part 3

Soon...
