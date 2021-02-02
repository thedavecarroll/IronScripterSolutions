class Person {

    # properties
    [System.String]$Name
    [System.Boolean]$IsCool
    [System.Int32]$Age
    [System.String]$DOB

    # constructors
    Person () { }
    Person ([PSCustomObject]$InputObject) {
        $this.Name = $InputObject.Name
        $this.IsCool = $InputObject.IsCool
        $this.Age = $InputObject.Age
        $this.DOB = $InputObject.DOB
    }

}