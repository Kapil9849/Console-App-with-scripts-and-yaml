powershell Start-Process powershell -Verb runAs

$taskName = "EmtecConsoleApp"
$taskExists = Get-ScheduledTask | Where-Object { $_.TaskName -like $taskName }
$appPath = 'C:\ConsoleApp\ConsoleApp-Try-1\bin\Release\netcoreapp3.1\ConsoleApp-Try-1.exe'

if ($taskExists) {
    Write-Output "task exist"
    Disable-ScheduledTask -TaskName $taskName
    Write-Output "task disabled"
    
}
else {
    Write-Output "task is being starting" 
    $action = New-ScheduledTaskAction -Execute $appPath;
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1);
    $setting = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
    Register-ScheduledTask -Action $action -Settings $setting -Trigger $trigger -TaskName $taskName -Description "This is a test task. Its job is to start app.";
    Write-Output "task created"
    Disable-ScheduledTask -TaskName $taskName
    Write-Output "task disabled"
}