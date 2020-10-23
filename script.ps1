
$computerInformation = Get-wmiobject Win32_ComputerSystem
$cpuInfo = Get-WmiObject Win32_Processor | Select-Object -ExpandProperty name
$computerName = Get-wmiobject Win32_ComputerSystem | Select-Object -ExpandProperty name
$computerDomain = $computerInformation | Select-Object -ExpandProperty Domain
$computerManufacturer = $computerInformation | Select-Object -ExpandProperty Manufacturer
$computerModel = $computerInformation | Select-Object -ExpandProperty Model
$computerSerial = Get-WmiObject win32_bios | Select-Object -ExpandProperty Serialnumber
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
$hardDrive = Get-PhysicalDisk
$hardDriveType = Get-PhysicalDisk | Select-Object -ExpandProperty MediaType
$hardDriveSizeBytes = Get-PhysicalDisk | Select-Object -ExpandProperty Size
$hardDriveSizeGb = ([Math]::Round( $hardDriveSizeBytes / 1024 / 1024 / 1024 + 0.005, 0))
$outputFile = ".\$computerName.txt"

"Computer Information`
-----------------------`n`
Domain: $computerDomain`
Manufacturer: $computerManufacturer`
Model: $computerModel`
Serial: $computerSerial`
Monitor model: $computerManufacturer`
Monitor serial: $computerManufacturer`
Ram: $ram gb`
Disk: $hardDriveSizeGb GB`
CPU: $cpuInfo`
`n" >> $outputFile

"Application Installed`
------------------------`
" >> $outputFile
Get-WmiObject -Class Win32_Product | Select -ExpandProperty Name | Out-File -FilePath $outputFile -Append
