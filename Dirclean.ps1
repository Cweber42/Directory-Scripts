#Home Directory Cleanup
#Remove files with a LastWriteTime or LastAccessTime

#Variables to configure
# $directory1 = '\\domain.local\homes\Faculty-Homes' #Staff to run the cleanup DFS namespace 
$directory2 = '\\fileserver\HSAPPS\class' #Student directory
$days = "-2" # How far back do you want to keep files
$Lastvalue = "LastAccessTime" #Change this value from LastAccessTime to LastWriteTime, Access is last time opened, LastWrite is last time the file was changed/written to
$logpath1 = "c:\scripts\Stafflog.csv"
$logpath2 = "c:\scripts\Studentlog.csv"
$docs2clean = ("*.png","*.bmp","*.tif","*.tiff","*.jpg","*.txt","*.docx","*.doc","*.pdf","*.mov","*.avi","*.mp3","*.tmp","*.bmp","*.mp4","*.xls","*.xlr","*.xlsx","*.log","*.rft","*.csv", "*.dat","*.pps","*.ppt","*.pptx","*.xml","*.vcf","*.wav","*.wma","*.flv","*.mov","*.m4v","*.db","*.accdb","*.mdb")
$cleanup1 = "True" #Set to False to run reports. Changing to True will delete files, leave as false until you have backed up the files/fileserver and are REALLY sure you want to delete the files.
########
#Script#
#######
# Staff Directory Cleanup
#$deadspace1 = Get-ChildItem $directory1 -include $docs2clean -Recurse |Where-Object {$_.$Lastvalue -lt (Get-Date).AddDays($days)} 
#$freeme =($deadspace1 | Measure-Object -Sum Length).Sum / 1gb 
#Write-Host $freeme "Gb will be removed if this script is ran"

#$deadspace1 | Select-Object Directory,Name,$Lastvalue,Length | Export-Csv $logpath1
#Write-Host "Exported log to $logpath1"


#Student Directory cleanup
$deadspace2 = Get-ChildItem $directory2 -include $docs2clean -Recurse |Where-Object {$_.$Lastvalue -lt (Get-Date).AddDays($days)} 
$freeme =($deadspace2 | Measure-Object -Sum Length).Sum / 1gb 
Write-Host $freeme "Gb will be removed if this script is ran"

$deadspace2 | Select-Object Directory,Name,$Lastvalue,Length | Export-Csv $logpath2
Write-Host "Exported log to $logpath2"

##########################
####### Clean Up #########
#########################

if ($cleanup1 -eq "True"){
$deadspace1 = Get-ChildItem $directory2 -include $docs2clean -Recurse |Where-Object {$_.$Lastvalue -lt (Get-Date).AddDays($days)} | Remove-Item
 } else {
 Write-host "The jet is fueled and ready to go, on your command change staging to true and we will drop a nuke on the files"
 }
