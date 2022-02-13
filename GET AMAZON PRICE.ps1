# print first line to user
# asking for them to put their amazon link to their clipboard for the program to search
write-host ("Please put your link in the clipboard")

# a small break to wait for user input, so the user has time to be able to go grab a link, if they haven't already
Read-Host
# grabs raw value of clipboard
$siteRead = Get-Clipboard

# downloads raw site data to then be read through. Saves this data in a temp file called 'PSTesting.txt' that's in the same directory
$site = Invoke-WebRequest -uri $SiteRead
$site.RawContent > "PSTesting.txt"

# define what we are looking for in a variable and then use this later on to search through file
$searchCriteria = "displayPrice"
$startingPointOfString = get-content "PSTesting.txt" | Select-String $searchCriteria
$dataConvertedToString = $startingPointOfString.tostring()
$poundIndex = $dataConvertedToString.indexof("£") #returns 204

# splicing down text to find the data we need
$leftSelect = $dataConvertedToString.Substring($poundIndex, 10) # no pound value is more than 10 characters so this is safe
$commaIndex = $leftSelect.indexof(",") #first first comma
$rightSelect = $leftSelect.Substring(0, $commaIndex - 1)

# display results to user.
Write-Host("The price of this product is: " + $rightSelect)


Pause
del "PSTesting.txt"
