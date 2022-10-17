powershell Start-Process powershell -Verb runAs

$taskName = "EmtecConsoleApp"
Enable-ScheduledTask -TaskName $taskName
Write-Output "task enabled