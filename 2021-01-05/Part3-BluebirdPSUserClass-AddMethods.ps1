# class definition created by ConvertTo-ClassDefinition at 2/2/2021 12:19:34 AM for object type PSCustomObject

class BluebirdPSUser {

    # properties
    hidden [String]$IdStr
    [String]$Location
    [String]$ScreenName
    [System.Int64]$Id
    [System.Boolean]$DefaultProfile

    # constructors
    BluebirdPSUser () { }
    BluebirdPSUser ([PSCustomObject]$InputObject) {
        $this.IdStr = $InputObject.id_str
        $this.Location = $InputObject.location
        $this.ScreenName = $InputObject.screen_name
        $this.Id = $InputObject.id
        $this.DefaultProfile = $InputObject.default_profile
    }

    <# original output from ConvertTo-ClassDefinition
    [OutputTypeName] UpdateProfile (
        [TypeName]$Param1,
        [TypeName]$Param2
    ) {
        # your code
        return $Output
    }

    [OutputTypeName] SetLocation (
        [TypeName]$Param1,
        [TypeName]$Param2
    ) {
        # your code
        return $Output
    }
    #>

    # update code
    [string] UpdateProfile ( ) {
        return ("Updated Profile for {0}" -f $this.ScreenName)
    }

    # update code
    [bool] SetLocation () {
        return $false
    }

}
