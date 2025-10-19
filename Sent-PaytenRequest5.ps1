# Send-PaytenRequest3.ps1
# Launches AdbTriggerActivity with Base64-encoded Payten ECR JSON via ADB.

# --- CONFIG ---
$ComponentName = 'com.example.myapplication/.Preathorization'
$JsonFile      = 'C:\payten\preauth_completion.json'

# --- VALIDATION ---
if (-not (Test-Path $JsonFile)) {
    Write-Host 'JSON file not found at' $JsonFile
    exit 1
}

# --- READ + ENCODE JSON ---
$JsonPayload = Get-Content -Raw -Path $JsonFile
$Base64      = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($JsonPayload))

# --- BUILD + EXECUTE ADB COMMAND ---
Write-Host 'Launching AdbTriggerActivity via ADB...'

$cmd = 'adb shell am start -S -n {0} --es requestJsonB64 "{1}"' -f $ComponentName, $Base64

Write-Host "Running:`n$cmd`n"
Invoke-Expression $cmd

Write-Host 'Command sent. Check logcat for AdbTriggerActivity output.'
