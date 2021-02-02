# class definition created by ConvertTo-ClassDefinition at 1/30/2021 11:55:19 AM for object type PSCustomObject

class BluebirdPS {

    # properties
    [System.Int64]$Id
    hidden [String]$IdStr
    [String]$Name
    [String]$ScreenName
    [String]$Location
    [System.Object]$ProfileLocation
    [String]$Description
    [Uri]$Url
    [PSCustomObject]$Entities
    [System.Boolean]$Protected
    [System.Int64]$FollowersCount
    [System.Int64]$FriendsCount
    [System.Int64]$ListedCount
    [DateTime]$CreatedAt
    [System.Int64]$FavouritesCount
    [System.Object]$UtcOffset
    [System.Object]$TimeZone
    [System.Boolean]$GeoEnabled
    [System.Boolean]$Verified
    [System.Int64]$StatusesCount
    [System.Object]$Lang
    [PSCustomObject]$Status
    [System.Boolean]$ContributorsEnabled
    [System.Boolean]$IsTranslator
    [System.Boolean]$IsTranslationEnabled
    [String]$ProfileBackgroundColor
    [Uri]$ProfileBackgroundImageUrl
    [Uri]$ProfileBackgroundImageUrlHttps
    [System.Boolean]$ProfileBackgroundTile
    [Uri]$ProfileImageUrl
    [Uri]$ProfileImageUrlHttps
    [Uri]$ProfileBannerUrl
    [String]$ProfileLinkColor
    [String]$ProfileSidebarBorderColor
    [String]$ProfileSidebarFillColor
    [String]$ProfileTextColor
    [System.Boolean]$ProfileUseBackgroundImage
    [System.Boolean]$HasExtendedProfile
    [System.Boolean]$DefaultProfile
    [System.Boolean]$DefaultProfileImage
    [System.Boolean]$Following
    [System.Boolean]$FollowRequestSent
    [System.Boolean]$Notifications
    [String]$TranslatorType
    [System.Boolean]$Suspended
    [System.Boolean]$NeedsPhoneVerification

    # constructors
    BluebirdPS () { }
    BluebirdPS ([PSCustomObject]$InputObject) {
        $this.Id = $InputObject.id
        $this.IdStr = $InputObject.id_str
        $this.Name = $InputObject.name
        $this.ScreenName = $InputObject.screen_name
        $this.Location = $InputObject.location
        $this.ProfileLocation = $InputObject.profile_location
        $this.Description = $InputObject.description
        $this.Url = $InputObject.url
        $this.Entities = $InputObject.entities
        $this.Protected = $InputObject.protected
        $this.FollowersCount = $InputObject.followers_count
        $this.FriendsCount = $InputObject.friends_count
        $this.ListedCount = $InputObject.listed_count
        $this.CreatedAt = [datetime]::ParseExact($InputObject.created_at,'ddd MMM dd HH:mm:ss zzz yyyy',(Get-Culture))
        $this.FavouritesCount = $InputObject.favourites_count
        $this.UtcOffset = $InputObject.utc_offset
        $this.TimeZone = $InputObject.time_zone
        $this.GeoEnabled = $InputObject.geo_enabled
        $this.Verified = $InputObject.verified
        $this.StatusesCount = $InputObject.statuses_count
        $this.Lang = $InputObject.lang
        $this.Status = $InputObject.status
        $this.ContributorsEnabled = $InputObject.contributors_enabled
        $this.IsTranslator = $InputObject.is_translator
        $this.IsTranslationEnabled = $InputObject.is_translation_enabled
        $this.ProfileBackgroundColor = $InputObject.profile_background_color
        $this.ProfileBackgroundImageUrl = $InputObject.profile_background_image_url
        $this.ProfileBackgroundImageUrlHttps = $InputObject.profile_background_image_url_https
        $this.ProfileBackgroundTile = $InputObject.profile_background_tile
        $this.ProfileImageUrl = $InputObject.profile_image_url
        $this.ProfileImageUrlHttps = $InputObject.profile_image_url_https
        $this.ProfileBannerUrl = $InputObject.profile_banner_url
        $this.ProfileLinkColor = $InputObject.profile_link_color
        $this.ProfileSidebarBorderColor = $InputObject.profile_sidebar_border_color
        $this.ProfileSidebarFillColor = $InputObject.profile_sidebar_fill_color
        $this.ProfileTextColor = $InputObject.profile_text_color
        $this.ProfileUseBackgroundImage = $InputObject.profile_use_background_image
        $this.HasExtendedProfile = $InputObject.has_extended_profile
        $this.DefaultProfile = $InputObject.default_profile
        $this.DefaultProfileImage = $InputObject.default_profile_image
        $this.Following = $InputObject.following
        $this.FollowRequestSent = $InputObject.follow_request_sent
        $this.Notifications = $InputObject.notifications
        $this.TranslatorType = $InputObject.translator_type
        $this.Suspended = $InputObject.suspended
        $this.NeedsPhoneVerification = $InputObject.needs_phone_verification

    }

}

