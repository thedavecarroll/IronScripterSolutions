# A PowerShell Nonsense Challenge

## Intermediate Level

- [x] Create word of user specified length
- [x] Create a sentence using varying lengths nonsense words
- [x] Create a paragraph of nonsense sentences, of varying lengths
- [x] Create 10 sample document files of varying paragraph length

## Extra Credit

- [x] Sentences should start with upper case letter and end in a period (or terminating punctuation)
- [x] Insert punctuation into your sentences such as commas, exclamation points, and semi-colons
- [x] Include letters with diacritical marks such as è
- [ ] Create a command to create a nonsense markdown document

## Remaining Tasks

- Create a command to create a nonsense markdown document
- Add lists with an Oxford comma to `Get-RandomSentence`
- Possibly others that haven't come to mind

## Solution Overview

Instead of generating a character array list and then getting a random sample for each word, I wanted to weight each letter differently (based on sampling of 40000 English words).

### $CharacterSet

This module variable includes the weighted letter array, along with *vowel* and *consonant* ASCII character arrays for both standard alphabet and diacritics.

```powershell
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
```

Uppercase letters (or diacritics) are supported by subtracting 32 from the value.
For example, the lowercase letter `a` is `97` in decimal in ASCII.
Subtracting `32` from `97` results in `65` which is the uppercase letter `A`.

```powershell
[char]97
# a
[char](97-32)
# A
```

By dealing with `[char]` type instead of the `[string]` letter, I am able to use the `decimal` in comparisons.

*This may produce strange behavior for some diacritics.*

### Get-RandomLetter

- Uses `Get-WeightedCharArray` which generates weighted character array included in `$CharacterSet`
- Returns diacritic, if requested
- Returns uppercase, if requested

### Get-RandomWord

- Uses `Get-RandomLetter`
- Prevents more than 3 vowels together
- Can uppercase the initial character
- Can include additional diacritics

### Get-RandomSentence

- Uses `Get-RandomWord`
- Enforces uppercase on the first word
- Ensures no 1 or 2 length words are together
- Uses `Get-RandomConjunction` which inserts `and`, `or`, `,`, `;`, or `:` at varying probabilities
- Ends the sentence with terminating punctuation:  85% period, 8% exclamation point, 7% question mark

### Get-RandomParagraph

- Uses `Get-RandomSentence`
- 25% chance of a sentence having a conjunction
- Joins the sentences with a single space.

### Get-RandomDocument

- Uses `Get-RandomParagraph`
- Uses the following defaults:
  - SentenceCount: Minimum 5 Maximum 25
  - MaxWordLength: Minimum 3 Maximum 18
  - MaxWordsPerSentence: Minimum 3 Maximum 25
  - MaxDiacriticsPerSentence:
    - 30 % of no diacritics
    - 20 % of 1 diacritics
    - 20 % of 2 diacritics
    - 20 % of 3 diacritics
    - 10 % of 4 diacritics

### GenerateRandomFiles.ps1

This script saves the results from `Get-RandomDocument` to a randomly named txt file in the `SampleFiles` folder.
By default, it produces 10 files, but you can change this by providing a different number in the range of 1 and 25.
