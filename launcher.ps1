# Batch File Launcher - Test Version
# This will download and execute batch files from a URL

param(
    [string]$BatUrl = ""
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   BATCH FILE LAUNCHER - TEST VERSION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# If no URL provided, use a default test
if ([string]::IsNullOrEmpty($BatUrl)) {
    Write-Host "No URL provided. Please specify the URL to your .bat file." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Usage examples:" -ForegroundColor White
    Write-Host "  .\launcher.ps1 -BatUrl 'https://raw.githubusercontent.com/username/repo/main/test.bat'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  Or pipe directly:" -ForegroundColor Gray
    Write-Host "  irm 'URL/launcher.ps1' | iex" -ForegroundColor Gray
    Write-Host ""
    
    $BatUrl = Read-Host "Enter the URL to your .bat file"
    
    if ([string]::IsNullOrEmpty($BatUrl)) {
        Write-Host "Error: No URL provided. Exiting..." -ForegroundColor Red
        exit
    }
}

# Extract filename from URL
$fileName = [System.IO.Path]::GetFileName($BatUrl)
if (-not $fileName.EndsWith(".bat")) {
    $fileName = "script.bat"
}

$tempFile = Join-Path $env:TEMP $fileName

Write-Host "Downloading: $fileName" -ForegroundColor Yellow
Write-Host "From: $BatUrl" -ForegroundColor Gray
Write-Host ""

try {
    # Download the batch file
    Invoke-RestMethod -Uri $BatUrl -OutFile $tempFile -ErrorAction Stop
    
    Write-Host "Download complete!" -ForegroundColor Green
    Write-Host "Executing batch file..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Execute the batch file
    & cmd.exe /c $tempFile
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Batch file execution completed!" -ForegroundColor Green
    
    # Optional: Uncomment to auto-delete the temp file
    # Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    
}
catch {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "ERROR OCCURRED" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Could not download or execute the batch file." -ForegroundColor Red
    Write-Host ""
    Write-Host "Error details:" -ForegroundColor Yellow
    Write-Host $_.Exception.Message -ForegroundColor Gray
    Write-Host ""
    Write-Host "Please check:" -ForegroundColor Yellow
    Write-Host "  1. The URL is correct and accessible" -ForegroundColor White
    Write-Host "  2. You have internet connection" -ForegroundColor White
    Write-Host "  3. The file exists at the specified URL" -ForegroundColor White
}
