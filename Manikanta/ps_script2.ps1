Write-Output "Yess it's working now.."

#Main function
function main {
    do {
        #starting helper function
        Write-Output "`n Select 1 to deal with Services `n `n Select 2 to deal with Event logs `n `n Select 3 to deal with files `n `n Select 4 for EXIT `n"
        # Should handle gibrish input
        $choice = Read-Host -Prompt "Input the choice"
        #Regex to take input only from 1 to 4
        while ($choice -match '^[1-4]+$' -ne 'True') {
            Write-Host "`n PLEASE ENTER A VALID INPUT AND TRY AGAIN `n" -ForegroundColor Red
            $choice = Read-Host -Prompt "Input the choice"
        }
        switch ($choice) {
            1 { funcServices; break }
            2 { funcEventLogs; break }
            3 { funcFiles; break }
        }
    }while ($choice -ne 4)
}

#Helpers
function funcServices {
    do {
        Write-Output "`n Select 1 to list all the Services `n `n Select 2 to view Running services `n `n Select 3 to view Stopped services `n `n Select 4 to start a service `n `n Select 5 to stop a service `n `n Select 6 to EXIT `n"
        $choice = Read-Host -Prompt "Input the choice"
        while ($choice -match '^[0-6]+$' -ne 'True') {
            Write-Host "`n PLEASE ENTER A VALID INPUT AND TRY AGAIN `n" -ForegroundColor Red
            $choice = Read-Host -Prompt "Input the choice"
        }
        switch ($choice) {
            1 {
                $allServices = Get-Service #lists all the services
                write-Output $allServices
                ; break
            } 
            2 {
                #Running Services
                $runningServices = Get-Service | Where-Object { $_.Status -eq "Running" } 
                Write-Output $runningServices
                ; break
            }
            3 {
                #Stopped Services
                $stoppedServices = Get-Service | Where-Object { $_.Status -eq "Stopped" } #
                Write-Output $stoppedServices
                ; break
            }
            4 {
                #Startinga service
                $servName = Read-Host -Prompt "`n Enter the service name "
                Start-Service -Name $servName
                Get-Service -Name $servName
                Write-Output `n; break
            }

            5 {
                #Stopping a service
                $serviceName = Read-Host -Prompt "`n Enter the service name " 
                Stop-Service -Name $serviceName
                Get-Service -Name $serviceName
                Write-Output `n; break
            }

            6 { break }
        }
    }while ($choice -ne 6)
}

    
function funcEventLogs {
    do {
        Write-Output "`n Select 1 to just get log details `n `n Select 2 to get log details of specific entry type `n `n Select 3 to Exit `n"
        $choice = Read-Host -Prompt "Input the choice"
        while ($choice -match '^[0-3]+$' -ne 'True') {
            Write-Host "`n PLEASE ENTER A VALID INPUT AND TRY AGAIN `n" -ForegroundColor Red
            $choice = Read-Host -Prompt "Input the choice"
        }
        switch ($choice) {
            1 {
                #Get log details of events
                $eventName = Read-Host -Prompt "`n Enter the event name"
                $data = Get-EventLog -LogName $eventName | select -First 20 
                Write-Output $data        
            }

            2 {
                #Get log details of specific event and entry type
                $eventName = Read-Host -Prompt "`n Enter the event name"
                $entryType = Read-Host -Prompt "`n Enter the entry type"
                $data = Get-EventLog -LogName $eventName | Where-Object { $_.EntryType -eq $entryType } | select -First 20   
                Write-Output $data
            }
            3 { break }
        }
    }while ($choice -ne 3)    
}


function funcFiles {
    do {
        Write-Output "`n Select 1 to write to a new file `n `n Select 2 to override an exiting file `n `n Select 3 to append to an existing file `n `n Select 4 to Exit `n"
        $choice = Read-Host -Prompt "Input the choice"
        while ($choice -match '^[0-4]+$' -ne 'True') {
            Write-Host "`n PLEASE ENTER A VALID INPUT AND TRY AGAIN `n" -ForegroundColor Red
            $choice = Read-Host -Prompt "Input the choice"
        }
        switch ($choice) {
            1 {
                Write-Output "`n List of existing files"
                ls C:\ShellScripts\testFolder\
                $fileName = Read-Host -Prompt "`n Enter the file name"
                #Creating a new File
                New-Item C:\ShellScripts\testFolder\$filename -ItemType File
                $content = Read-Host -Prompt "`n Enter the content"
                #Set-Content over rides the existing content
                $content | Set-Content C:\ShellScripts\testFolder\$filename
                Write-Output "`n Contetnt written succesfully"
            }

            2 {
                Write-Output "`n List of existing files"
                ls C:\ShellScripts\testFolder\
                $fileName = Read-Host -Prompt "`n Enter the file name"
                $content = Read-Host -Prompt "`n Enter the new content to override"
                $content | Set-Content C:\ShellScripts\testFolder\$filename
                Write-Output "`n Contetnt overridden succesfully"
            }

            3 {
                Write-Output "`n List of existing files"
                ls C:\ShellScripts\testFolder\
                $fileName = Read-Host -Prompt "`n Enter the file name"
                $content = Read-Host -Prompt "`n Enter the new content to append"
                #Add-Content appends to current content
                $content | Add-Content C:\ShellScripts\testFolder\$filename
                Write-Output "`n Contetnt appended succesfully"
            }
        }
    }while ($choice -ne 4)       
}

#Entry point
main

