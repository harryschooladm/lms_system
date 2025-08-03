# Supabase Initialization Script

Write-Host "ULMP - Supabase Setup Instructions" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green
Write-Host ""
Write-Host "Please follow these steps to set up your Supabase project:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to your Supabase Dashboard:" -ForegroundColor Cyan
Write-Host "   https://supabase.com/dashboard/project/lygeidmrzcdtugmkwijm/sql/new" -ForegroundColor White
Write-Host ""
Write-Host "2. Copy the entire content of 'database\complete_setup.sql'" -ForegroundColor Cyan
Write-Host ""
Write-Host "3. Paste it into the SQL Editor and click 'Run'" -ForegroundColor Cyan
Write-Host ""
Write-Host "4. Verify all tables are created successfully" -ForegroundColor Cyan
Write-Host ""
Write-Host "5. Update your .env.local file with your project credentials" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to open the SQL file..." -ForegroundColor Yellow
Read-Host
notepad.exe $PSScriptRoot\..\database\complete_setup.sql
