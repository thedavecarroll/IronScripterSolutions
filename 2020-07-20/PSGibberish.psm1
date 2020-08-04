function Get-WeightedCharArray {
    [CmdletBinding()]
    param()

    #http://pi.math.cornell.edu/~mec/2003-2004/cryptography/subs/frequencies.html

    $Weighted = [ordered]@{
        '97' = 8.12   # a
        '98' = 1.49   # b
        '99' = 2.71   # c
        '100' = 4.32  # d
        '101' = 12.02 # e
        '102' = 2.30  # f
        '103' = 2.03  # g
        '104' = 5.92  # h
        '105' = 7.31  # i
        '106' = 0.10  # j
        '107' = 0.69  # k
        '108' = 3.98  # l
        '109' = 2.61  # m
        '110' = 6.95  # n
        '111' = 7.68  # o
        '112' = 1.82  # p
        '113' = 0.11  # q
        '114' = 6.02  # r
        '115' = 6.28  # s
        '116' = 9.10  # t
        '117' = 2.88  # u
        '118' = 1.11  # v
        '119' = 2.09  # w
        '120' = 0.17  # x
        '121' = 2.11  # y
        '122' = 0.07  # z
    }

    foreach ($Key in $Weighted.Keys) {
        $Weight = [math]::Ceiling(($Weighted[$Key] * 10))
        1..$Weight | ForEach-Object { [int]$Key }
    }

}
$WeightCharArray = Get-WeightedCharArray

# all lowercase
$CharacterSet =  @{
    Alphabetical = @{
        Both = 97..122
        Vowel = 97,101,105,111,117,121
        Consonant = (98..100),(102..104),(106..110),(112..116),(118..122)
        Weighted = $WeightCharArray
    }
    Diacritical = @{
        Both = (224..246),(248..253),255
        Vowel = (224..230),(232..239),(242..246),(248..253),255
        Consonant = 231,240,241
        Weighted = (224..246),(248..253),255
    }
}

function Get-RandomPercent { 1..100 | Get-Random }

function Get-RandomLetter {
    [CmdletBinding()]
    param(
        [switch]$Diacritic,
        [ValidateSet('Both','Vowel','Consonant','Weighted')]
        [string]$Type = 'Weighted'
    )
    if ($PSBoundParameters.ContainsKey('Diacritic')) {
        $AsciiLetterCodes = $CharacterSet.Diacritical
    } else {
        $AsciiLetterCodes = $CharacterSet.Alphabetical
    }
    $Char = $AsciiLetterCodes.$Type | Get-Random
    [char]$Char
}

function Get-RandomConjunction {
    [CmdletBinding()]
    param()
    $Chance = Get-RandomPercent
    switch ($Chance) {
        { 1..45 -contains $_ }  { 'and' } # 45% chance for 'and'
        { 46..75 -contains $_ } { 'or' }  # 25% chance for 'or'
        { 76..85 -contains $_ } { ',' }   # 10% chance for 'comma'
        { 86..95 -contains $_ } { ';' }   # 10% chance for 'semi-colon'
        { 96..100 -contains $_ } { ':' }  # 5% chance for 'colon'

    }
}

function Get-RandomWord {
    [CmdletBinding()]
    param(
        [ValidateRange(1, 50)]      # the longest English word is 45 characters long
        [int]$Length = 5,           # 4.7 characters is the average English word length
        [switch]$BeginUppercase,
        [switch]$IncludeDiacritic
    )

    # if IncludeDiacritic, set index to place diacritic, excluding first character
    if ($PSBoundParameters.ContainsKey('IncludeDiacritic')) {
        if (2 -ge $Length) {
            $DiacriticIndex = 2
        } else {
            $DiacriticIndex = Get-Random -Minimum 2 -Maximum $Length
        }
    } else {
        $DiacriticIndex = -1
    }

    $RandomWord = [System.Text.StringBuilder]::new()

    while ($RandomWord.Length -lt $Length) {

        $RandomLetterParam = @{}

        if ($RandomWord.Length -eq 0 -and $PSBoundParameters.ContainsKey('BeginUppercase')) {
            if ($PSBoundParameters.ContainsKey('IncludeDiacritic')) {
                # 10 % chance to have diacritic at the beginning of a word
                $DiacriticFirstLetter = Get-RandomPercent
                if ($DiacriticFirstLetter -gt 90) {
                    $RandomLetterParam.Add('Diacritic',$true)
                }
            }
            $UpperCaseLetter = [char]((Get-RandomLetter @RandomLetterParam) -32)
            $null = $RandomWord.Append($UpperCaseLetter)

        } else {

            # max of 3 vowels together
            if ($RandomWord.Length -gt 3){
                $LastChar = $RandomWord.Chars($RandomWord.Length-1)
                $SecondToLastChar = $RandomWord.Chars($RandomWord.Length-2)
                $ThirdToLastChar = $RandomWord.Chars($RandomWord.Length-3)
                if ([int]$LastChar,[int]$SecondToLastChar,[int]$ThirdToLastChar -in $CharacterSet.Alpahbetical.Vowel) {
                    $RandomLetterParam.Add('Type','Consonant')
                }
            }

            if ($RandomWord.Length -eq $DiacriticIndex) {
                $RandomLetterParam.Add('Diacritic',$true)
            }

            $null = $RandomWord.Append((Get-RandomLetter @RandomLetterParam))
        }
    }
    $RandomWord.ToString()
}

function Get-RandomSentence {
    [CmdletBinding()]
    param(
        [ValidateRange(2,50)]
        [int]$Words = 17,           # average number of words in sentence
        [ValidateRange(0,10)]
        [int]$MaxDiacritics = 3,
        [ValidateRange(1, 50)]
        [int]$MaxWordLength = 15,
        [switch]$IncludeConjunction,
        [ValidateScript({
            if ($_ -match '[0]|[3]|[4]|[5]') {
                $true
            } else {
                throw ('{0} not in list of valid arugments: 0, 3, 4, or 5.' -f $_)
            }
        })]
        [int]$ListItemCount = 0
    )

    $RandomSentence = [System.Text.StringBuilder]::new()
    $WordCount = 0
    $DiacriticsUsed = 0

    $HasConjunction = $false
    if ($Words -ge 4) {
        $ConjunctionIndex = Get-Random -Minimum 2 -Maximum ($Words - 1)
    } else {
        $ConjunctionIndex = -1
    }

    # if word count is less than list item count, reduce list item count.
    if ($Words -le $ListItemCount) {
        $ListItemCount = $Words - $ListItemCount
        if ($ListItemCount) {

        }
    }
    $CurrentListItem = 0

    while ($WordCount -le $Words) {
        $WordLength = 1..$MaxWordLength | Get-Random

        # ensure that no 1 or 2 length words are together
        if ($WordLength -in 1,2) {
            $AllWords = $RandomSentence.ToString().Split(' ')
            if ($AllWords[-2].Length -eq 1) {
                $WordLength = 2..$MaxWordLength | Get-Random
            }
        }

        $WordCount++
        if ($WordCount -eq 1) {
            $Word = Get-RandomWord -Length $WordLength -BeginUppercase
        } else {
            if ($DiacriticsUsed -lt $MaxDiacritics) {
                $UseDiacriticChance = Get-RandomPercent
                if ($UseDiacriticChance -ge 90) {
                    $Word = Get-RandomWord -Length $WordLength -IncludeDiacritic
                    $DiacriticsUsed++
                }  else {
                    $Word = Get-RandomWord -Length $WordLength
                }
            } else {
                $Word = Get-RandomWord -Length $WordLength
            }
        }
        $null = $RandomSentence.Append($Word)

        if ($PSBoundParameters.ContainsKey('IncludeConjunction') -and $ConjunctionIndex -ge 2) {
            if ($WordCount -eq $ConjunctionIndex) {
                $Conjunction = Get-RandomConjunction
                if ($Conjunction.Length -gt 1) {
                    # add comma in front of conjunction
                    if (($true,$false | Get-Random) -eq $true) {
                        $null = $RandomSentence.Append((', {0}' -f $Conjunction))
                    } else {
                        $null = $RandomSentence.Append((' {0}' -f $Conjunction))
                    }
                    $WordCount++
                } else {
                    $null = $RandomSentence.Append($Conjunction)
                }
                $HasConjunction = $true
            }
        }

        if ($ListItemCount -gt 0 -and $CurrentListItem -le $ListItemCount) {

        }

        if ($WordCount -ge $Words) {
            $EndingPunctuationChance = Get-RandomPercent
            switch ($EndingPunctuationChance) {
                {1..85 -contains $_}   { $null = $RandomSentence.Append('.') } # 85% period
                {86..93 -contains $_}  { $null = $RandomSentence.Append('!') } # 8% exclamation point
                {94..100 -contains $_} { $null = $RandomSentence.Append('?') } # 7% question mark
            }
            break
        } else {
            $null = $RandomSentence.Append(' ')
        }

    }

    $RandomSentence.ToString()
}

function Get-RandomParagraph {
    [CmdletBinding()]
    param(
        [int]$SentenceCount = 6,            # average sentences per paragraph
        [ValidateRange(1, 50)]
        [int]$MaxWordLength = 15,
        [ValidateRange(2,50)]
        [int]$MaxWordsPerSentence = 17,     # average words per sentence
        [ValidateRange(0,10)]
        [int]$MaxDiacriticsPerSentence = 3
    )

    $Paragraph = for ($Sentences = 0; $Sentences -le $SentenceCount; $Sentences++) {

        $RandomSentenceParams = @{
            Words = 3..$MaxWordsPerSentence | Get-Random -Count 10 | Select-Object -Last 1
            MaxDiacritics = 0,0,0,(1..$MaxDiacriticsPerSentence) | Get-Random -Count 10 | Select-Object -Last 1
            MaxWordLength = 3..$MaxWordLength | Get-Random -Count 10 | Select-Object -Last 1
        }
        if ((Get-RandomPercent) -ge 75) {
            $RandomSentenceParams.IncludeConjunction = $true
        }

        Get-RandomSentence @RandomSentenceParams

    }

    $Paragraph -join ' '

}

function Get-RandomDocument {
    [CmdletBinding()]
    param(
        [ValidateRange(4,50)]
        [int]$MaxParagraphs = 20,
        [ValidateRange(4,50)]
        [int]$MinParagraphs = 4
    )
    if ($MinParagraphs -ge $MaxParagraphs) {
        $MinParagraphs = $MaxParagraphs - 1
    }

    $ParagraphsPerDocument= Get-Random -Minimum $MinParagraphs -Maximum $MaxParagraphs
    $Paragraphs = for ($ParagraphCount = 1; $ParagraphCount -le $ParagraphsPerDocument; $ParagraphCount++) {

        $RandomParagraphParams = @{
            SentenceCount = Get-Random -Minimum 5 -Maximum 25
            MaxWordLength = Get-Random -Minimum 3 -Maximum 18
            MaxWordsPerSentence = Get-Random -Minimum 3 -Maximum 25
        }

        switch ((Get-RandomPercent)) {
            {1..30 -contains $_ }   { $RandomParagraphParams.MaxDiacriticsPerSentence = 0 } # 30 % of no diacritics
            {31..50 -contains $_ }  { $RandomParagraphParams.MaxDiacriticsPerSentence = 1 } # 20 % of 1 diacritics
            {51..70 -contains $_ }  { $RandomParagraphParams.MaxDiacriticsPerSentence = 2 } # 20 % of 2 diacritics
            {71..90 -contains $_ }  { $RandomParagraphParams.MaxDiacriticsPerSentence = 3 } # 20 % of 3 diacritics
            {91..100 -contains $_ } { $RandomParagraphParams.MaxDiacriticsPerSentence = 4 } # 10 % of 4 diacritics
        }

        Get-RandomParagraph @RandomParagraphParams
    }

    $Paragraphs -join [System.Environment]::NewLine,[System.Environment]::NewLine
}