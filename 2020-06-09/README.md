# Building a PowerShell Command Inventory

I wrote two articles on for this challenge, each exploring a different avenue for the solution.
The [gist][PSCommandInventoryGist] includes the files for both methods.

[PSCommandInventoryGist]: https://bit.ly/37sL3yE

## First Article

In [this article][PSCommandInventory1], I went down the path with regular expressions (*regex*) the first time I tackled this challenge.
I provide a regex primer, going over some of the basics of using regular expressions within PowerShell.

I produced two commands, `Measure-PSCodeLine` and `Get-PSCodeStructure`.

[PSCommandInventory1]: https://bit.ly/2YCsIv5

+ Measure-PSCodeLine
+ Get-PSCodeStructure

## Second Article

In [this article][PSCommandInventory2], I used PowerShell's Abstract Tree Syntax (AST) to solve the main component of the challenge.
I also used `Measure-Object` instead of iterating each file line-by-line using regex to determine whether to count the line.

+ Measure-FileLine
+ Measure-PSCommand

[PSCommandInventory2]: https://bit.ly/2A5m0FV