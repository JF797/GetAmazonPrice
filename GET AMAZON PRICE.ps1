write-host ("Please put your link in the clipboard")
Read-Host
$siteRead = Get-Clipboard

$site = Invoke-WebRequest -uri $SiteRead

$site.RawContent > "PSTesting.txt"

$search = "displayPrice"
$linenumber=get-content "PSTesting.txt" | Select-String $search
$stringname = $linenumber.tostring()
$poundIndex = $stringname.indexof("£") #returns 204


$leftSelect = $stringname.Substring($poundIndex, 10) # no pound value is more than 10 characters so this is safe
$commaIndex = $leftSelect.indexof(",") #first first comma
$rightSelect = $leftSelect.Substring(0, $commaIndex - 1)

Write-Host("stringname: " + $stringname.Substring($poundIndex,6))

#debugging



Write-Host("linenumber: " + $linenumber)
Write-Host("stringname: " + $stringname)
Write-Host("poundIndex: " + $poundIndex)
Write-Host("commaIndex: " + $commaIndex)
Write-Host("leftSelect: " + $leftSelect)
Write-Host("rightSelect: " + $rightSelect)


Pause
del "PSTesting.txt"
