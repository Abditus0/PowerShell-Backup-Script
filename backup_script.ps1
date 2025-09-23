# PowerShell Backup Script
# Author: Ivaylo Atanassov
# Description: This script backs up all files from a source folder to a timestamped destination folder.
# It preserves subfolder structure, logs successes and errors, verifies the copy by comparing file size, and handles duplicate filenames.


$Source = "C:\Test"
$TimeStamp= Get-Date -Format "dd-MM-yyyy_HH-mm"
$Destination = "C:\TestBackup\$TimeStamp"
$LogFile = "$Destination\backup.log"
$FilesBackedUp = 0
$BackupErrors = 0

# Check if source folder exists. If not, log error and exit.
if (-not (Test-Path -Path $Source)) {
    $ErrorMsg = "ERROR: Source path '$Source' does not exist. Exiting."
    Write-Host $ErrorMsg
    New-Item -ItemType Directory -Path (Split-Path $LogFile) -Force | Out-Null
    "[$(Get-Date)] $ErrorMsg" | Out-File $LogFile -Append
    exit 1
}

# Ensure there is enough free disk space on the drive where destination is located
$Drive = Split-Path $Destination -Qualifier         # Gets the drive root, e.g. "C:\"
$DiskSpace = Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$Drive'"
$FreeSpaceGB = [math]::Round($DiskSpace.FreeSpace / 1GB, 2)     # Free space in GB
$MinRequiredGB = 1      # Minimum 1GB free space required

# Create destination folder if it does not exist
if (-not (Test-Path -Path $Destination)) {
    try {
        New-Item -ItemType Directory -Path $Destination | Out-Null
        Write-Host "Successfully created backup directory"
    }
    catch {
        Write-Host "ERROR: Could not create backup directory: $($_.Exception.Message)"
        exit 1
    }
}

# Check free space and exit if insufficient
if ($FreeSpaceGB -lt $MinRequiredGB) {
    $ErrorMsg = "ERROR: Insufficient disk space. Available: ${FreeSpaceGB}, Required: ${MinRequiredGB}GB"
    Write-Host $ErrorMsg
    "[$(Get-Date)] $ErrorMsg" | Out-File $LogFile -Append
    exit 1
}


# Get files to back up and prepare a duplicate tracker
$Files = Get-ChildItem -Path $Source -File -Recurse
$DuplicateCounter = @{}

# The core loop. Copy each file, handle duplicates, verify copy
foreach ($file in $Files) {
    try {
        $RelativePath = $file.FullName.Replace($Source, "").TrimStart('\')
        $DestinationFile = Join-Path $Destination $RelativePath
        $DestinationFolder = Split-Path $DestinationFile -Parent
        
        # Create the folder structure if it doesn't exist
        if (-not (Test-Path $DestinationFolder)) {
            New-Item -ItemType Directory -Path $DestinationFolder -Force | Out-Null
        }
        
# Handle duplicate filenames in the same destination path (safety net)        
if (Test-Path $DestinationFile) {
    if (-not $DuplicateCounter.ContainsKey($DestinationFile)) {
        $DuplicateCounter[$DestinationFile] = 1
    } else {
        $DuplicateCounter[$DestinationFile]++
    }
    $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $Ext = [System.IO.Path]::GetExtension($file.Name)
    $NewName = "$BaseName($($DuplicateCounter[$DestinationFile]))$Ext"
    $DestinationFile = Join-Path $DestinationFolder $NewName
}
        # Copy the file to destination
        Copy-Item -Path $file.FullName -Destination $DestinationFile -Force -ErrorAction Stop
       
         # Check that copied file size matches original
        $OriginalSize = (Get-Item $file.FullName).Length
        $CopiedSize = (Get-Item $DestinationFile).Length
        if ($OriginalSize -eq $CopiedSize) {
            "[$(Get-Date)] SUCCESS: Backed up $($file.FullName) to $DestinationFile" | Out-File $LogFile -Append
            $FilesBackedUp++
        } else {
            throw "Verification failed (size mismatch)"
        }
    }
    catch {
        # Log any errors during backup
        "[$(Get-Date)] ERROR: Failed to backup $($file.FullName) - $($_.Exception.Message)" | Out-File $LogFile -Append
        $BackupErrors++
    }
}
    
# Summary
$SummaryMessage = "BACKUP COMPLETED - Files backed up: $FilesBackedUp, Errors: $BackupErrors"
"[$(Get-Date)] SUMMARY: $SummaryMessage" | Out-File $LogFile -Append
Write-Host $SummaryMessage