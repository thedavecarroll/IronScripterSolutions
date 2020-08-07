# Building a PowerShell Command Inventory

I wrote two articles on for this challenge, each exploring a different avenue for the solution.

## First Article

In [this article][PSCommandInventory1], I went down the path with regular expressions (*regex*) the first time I tackled this challenge.
I provide a regex primer, going over some of the basics of using regular expressions within PowerShell.

I produced two commands, `Measure-PSCodeLine` and `Get-PSCodeStructure`.

[PSCommandInventory1]: https://bit.ly/2YCsIv5

+ [Measure-PSCodeLine](https://gist.github.com/thedavecarroll/bdb519bf474739851ca1e7d2d3faeee6.js?file=1-Measure-PSCodeLine.ps1)
+ [Get-PSCodeStructure](https://gist.github.com/thedavecarroll/bdb519bf474739851ca1e7d2d3faeee6.js?file=2-Get-PSCodeStructure.ps1)

## Second Article

In [this article][PSCommandInventory2], I used PowerShell's Abstract Tree Syntax (AST) to solve the main component of the challenge.
I also used `Measure-Object` instead of iterating each file line-by-line using regex to determine whether to count the line.

+ [Measure-FileLine](https://gist.github.com/thedavecarroll/bdb519bf474739851ca1e7d2d3faeee6.js?file=4-Measure-FileLine.ps1)
+ [Measure-PSCommand](https://gist.github.com/thedavecarroll/bdb519bf474739851ca1e7d2d3faeee6.js?file=3-Measure-PSCommand.ps1)

[PSCommandInventory2]: https://bit.ly/2A5m0FV