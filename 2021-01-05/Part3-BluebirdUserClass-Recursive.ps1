# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserStatusRetweetedStatusEntities {

    # properties
    [System.Object[]]$Hashtags
    [System.Object[]]$UserMentions
    [System.Object[]]$Symbols
    [System.Object[]]$Urls

    # constructors
    BluebirdPSUserStatusRetweetedStatusEntities () { }
    BluebirdPSUserStatusRetweetedStatusEntities ([PSCustomObject]$InputObject) {
        $this.Hashtags = $InputObject.hashtags
        $this.UserMentions = $InputObject.user_mentions
        $this.Symbols = $InputObject.symbols
        $this.Urls = $InputObject.urls
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserStatusRetweetedStatus {

    # properties
    [System.Object]$Contributors
    [System.Object]$InReplyToUserIdStr
    [System.Boolean]$PossiblySensitive
    [String]$Text
    [System.Object]$Geo
    [System.Int64]$Id
    [System.Object]$InReplyToStatusId
    [System.Boolean]$Truncated
    [System.Object]$Coordinates
    [System.Boolean]$IsQuoteStatus
    [System.Boolean]$Retweeted
    [System.Object]$InReplyToScreenName
    [String]$Lang
    [DateTime]$CreatedAt
    [System.Int64]$RetweetCount
    [PSCustomObject]$Entities
    [System.Object]$InReplyToStatusIdStr
    [String]$IdStr
    [System.Boolean]$Favorited
    [System.Object]$InReplyToUserId
    [System.Object]$Place
    [String]$Source
    [System.Int64]$FavoriteCount

    # constructors
    BluebirdPSUserStatusRetweetedStatus () { }
    BluebirdPSUserStatusRetweetedStatus ([PSCustomObject]$InputObject) {
        $this.Contributors = $InputObject.contributors
        $this.InReplyToUserIdStr = $InputObject.in_reply_to_user_id_str
        $this.PossiblySensitive = $InputObject.possibly_sensitive
        $this.Text = $InputObject.text
        $this.Geo = $InputObject.geo
        $this.Id = $InputObject.id
        $this.InReplyToStatusId = $InputObject.in_reply_to_status_id
        $this.Truncated = $InputObject.truncated
        $this.Coordinates = $InputObject.coordinates
        $this.IsQuoteStatus = $InputObject.is_quote_status
        $this.Retweeted = $InputObject.retweeted
        $this.InReplyToScreenName = $InputObject.in_reply_to_screen_name
        $this.Lang = $InputObject.lang
        $this.CreatedAt = [datetime]::ParseExact($InputObject.created_at,'ddd MMM dd HH:mm:ss zzz yyyy',(Get-Culture))
        $this.RetweetCount = $InputObject.retweet_count
        $this.Entities = $InputObject.entities
        $this.InReplyToStatusIdStr = $InputObject.in_reply_to_status_id_str
        $this.IdStr = $InputObject.id_str
        $this.Favorited = $InputObject.favorited
        $this.InReplyToUserId = $InputObject.in_reply_to_user_id
        $this.Place = $InputObject.place
        $this.Source = $InputObject.source
        $this.FavoriteCount = $InputObject.favorite_count
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserStatusEntities {

    # properties
    [System.Object[]]$Hashtags
    [System.Object[]]$UserMentions
    [System.Object[]]$Symbols
    [System.Object[]]$Urls

    # constructors
    BluebirdPSUserStatusEntities () { }
    BluebirdPSUserStatusEntities ([PSCustomObject]$InputObject) {
        $this.Hashtags = $InputObject.hashtags
        $this.UserMentions = $InputObject.user_mentions
        $this.Symbols = $InputObject.symbols
        $this.Urls = $InputObject.urls
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserStatus {

    # properties
    [System.Object]$Contributors
    [System.Object]$InReplyToUserIdStr
    [String]$Text
    [System.Object]$Geo
    [System.Int64]$Id
    [System.Object]$InReplyToStatusId
    [System.Boolean]$Truncated
    [System.Object]$Coordinates
    [PSCustomObject]$RetweetedStatus
    [System.Boolean]$Retweeted
    [System.Object]$InReplyToScreenName
    [String]$Lang
    [DateTime]$CreatedAt
    [System.Int64]$RetweetCount
    [PSCustomObject]$Entities
    [System.Boolean]$IsQuoteStatus
    [System.Object]$InReplyToStatusIdStr
    [String]$IdStr
    [System.Boolean]$Favorited
    [System.Object]$InReplyToUserId
    [System.Object]$Place
    [String]$Source
    [System.Int64]$FavoriteCount

    # constructors
    BluebirdPSUserStatus () { }
    BluebirdPSUserStatus ([PSCustomObject]$InputObject) {
        $this.Contributors = $InputObject.contributors
        $this.InReplyToUserIdStr = $InputObject.in_reply_to_user_id_str
        $this.Text = $InputObject.text
        $this.Geo = $InputObject.geo
        $this.Id = $InputObject.id
        $this.InReplyToStatusId = $InputObject.in_reply_to_status_id
        $this.Truncated = $InputObject.truncated
        $this.Coordinates = $InputObject.coordinates
        $this.RetweetedStatus = $InputObject.retweeted_status
        $this.Retweeted = $InputObject.retweeted
        $this.InReplyToScreenName = $InputObject.in_reply_to_screen_name
        $this.Lang = $InputObject.lang
        $this.CreatedAt = [datetime]::ParseExact($InputObject.created_at,'ddd MMM dd HH:mm:ss zzz yyyy',(Get-Culture))
        $this.RetweetCount = $InputObject.retweet_count
        $this.Entities = $InputObject.entities
        $this.IsQuoteStatus = $InputObject.is_quote_status
        $this.InReplyToStatusIdStr = $InputObject.in_reply_to_status_id_str
        $this.IdStr = $InputObject.id_str
        $this.Favorited = $InputObject.favorited
        $this.InReplyToUserId = $InputObject.in_reply_to_user_id
        $this.Place = $InputObject.place
        $this.Source = $InputObject.source
        $this.FavoriteCount = $InputObject.favorite_count
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserEntitiesDescription {

    # properties
    [System.Object[]]$Urls

    # constructors
    BluebirdPSUserEntitiesDescription () { }
    BluebirdPSUserEntitiesDescription ([PSCustomObject]$InputObject) {
        $this.Urls = $InputObject.urls
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserEntitiesUrl {

    # properties
    [System.Object[]]$Urls

    # constructors
    BluebirdPSUserEntitiesUrl () { }
    BluebirdPSUserEntitiesUrl ([PSCustomObject]$InputObject) {
        $this.Urls = $InputObject.urls
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUserEntities {

    # properties
    [PSCustomObject]$Description
    [PSCustomObject]$Url

    # constructors
    BluebirdPSUserEntities () { }
    BluebirdPSUserEntities ([PSCustomObject]$InputObject) {
        $this.Description = $InputObject.description
        $this.Url = $InputObject.url
    }

}


# class definition created by ConvertTo-ClassDefinition at 2/2/2021 1:01:11 AM for object type PSCustomObject

class BluebirdPSUser {

    # properties
    [System.Boolean]$NeedsPhoneVerification
    [System.Boolean]$Protected
    [String]$ProfileBackgroundColor
    [System.Boolean]$HasExtendedProfile
    [System.Boolean]$IsTranslationEnabled
    [Uri]$ProfileBackgroundImageUrl
    [Uri]$Url
    [System.Int64]$Id
    [String]$Description
    [System.Object]$TimeZone
    [System.Object]$Lang
    [System.Boolean]$Suspended
    [PSCustomObject]$Status
    [System.Int64]$FavouritesCount
    [System.Boolean]$ProfileBackgroundTile
    [System.Boolean]$Verified
    [System.Boolean]$FollowRequestSent
    [System.Int64]$ListedCount
    [System.Boolean]$ProfileUseBackgroundImage
    [Uri]$ProfileImageUrl
    [System.Int64]$FriendsCount
    [String]$ProfileLinkColor
    [System.Boolean]$GeoEnabled
    [System.Boolean]$ContributorsEnabled
    [String]$ProfileSidebarFillColor
    [String]$Location
    [System.Boolean]$Notifications
    [System.Boolean]$DefaultProfile
    [String]$ProfileTextColor
    [String]$ScreenName
    [System.Object]$ProfileLocation
    [System.Int64]$FollowersCount
    [String]$Name
    [System.Boolean]$Following
    [Uri]$ProfileBannerUrl
    [String]$TranslatorType
    [String]$IdStr
    [System.Object]$UtcOffset
    [Uri]$ProfileImageUrlHttps
    [DateTime]$CreatedAt
    [System.Int64]$StatusesCount
    [Uri]$ProfileBackgroundImageUrlHttps
    [PSCustomObject]$Entities
    [String]$ProfileSidebarBorderColor
    [System.Boolean]$IsTranslator
    [System.Boolean]$DefaultProfileImage

    # constructors
    BluebirdPSUser () { }
    BluebirdPSUser ([PSCustomObject]$InputObject) {
        $this.NeedsPhoneVerification = $InputObject.needs_phone_verification
        $this.Protected = $InputObject.protected
        $this.ProfileBackgroundColor = $InputObject.profile_background_color
        $this.HasExtendedProfile = $InputObject.has_extended_profile
        $this.IsTranslationEnabled = $InputObject.is_translation_enabled
        $this.ProfileBackgroundImageUrl = $InputObject.profile_background_image_url
        $this.Url = $InputObject.url
        $this.Id = $InputObject.id
        $this.Description = $InputObject.description
        $this.TimeZone = $InputObject.time_zone
        $this.Lang = $InputObject.lang
        $this.Suspended = $InputObject.suspended
        $this.Status = $InputObject.status
        $this.FavouritesCount = $InputObject.favourites_count
        $this.ProfileBackgroundTile = $InputObject.profile_background_tile
        $this.Verified = $InputObject.verified
        $this.FollowRequestSent = $InputObject.follow_request_sent
        $this.ListedCount = $InputObject.listed_count
        $this.ProfileUseBackgroundImage = $InputObject.profile_use_background_image
        $this.ProfileImageUrl = $InputObject.profile_image_url
        $this.FriendsCount = $InputObject.friends_count
        $this.ProfileLinkColor = $InputObject.profile_link_color
        $this.GeoEnabled = $InputObject.geo_enabled
        $this.ContributorsEnabled = $InputObject.contributors_enabled
        $this.ProfileSidebarFillColor = $InputObject.profile_sidebar_fill_color
        $this.Location = $InputObject.location
        $this.Notifications = $InputObject.notifications
        $this.DefaultProfile = $InputObject.default_profile
        $this.ProfileTextColor = $InputObject.profile_text_color
        $this.ScreenName = $InputObject.screen_name
        $this.ProfileLocation = $InputObject.profile_location
        $this.FollowersCount = $InputObject.followers_count
        $this.Name = $InputObject.name
        $this.Following = $InputObject.following
        $this.ProfileBannerUrl = $InputObject.profile_banner_url
        $this.TranslatorType = $InputObject.translator_type
        $this.IdStr = $InputObject.id_str
        $this.UtcOffset = $InputObject.utc_offset
        $this.ProfileImageUrlHttps = $InputObject.profile_image_url_https
        $this.CreatedAt = [datetime]::ParseExact($InputObject.created_at,'ddd MMM dd HH:mm:ss zzz yyyy',(Get-Culture))
        $this.StatusesCount = $InputObject.statuses_count
        $this.ProfileBackgroundImageUrlHttps = $InputObject.profile_background_image_url_https
        $this.Entities = $InputObject.entities
        $this.ProfileSidebarBorderColor = $InputObject.profile_sidebar_border_color
        $this.IsTranslator = $InputObject.is_translator
        $this.DefaultProfileImage = $InputObject.default_profile_image
    }

}


