$query = Search-ADAccount -LockedOut | Where-Object{($_.enabled -ieq "True")}
$queryname = $query.samaccountname 
$date = Get-Date
$querynamed = write-output $queryname 
$count = $queryname | measure
$value = $count.count
if ($value -ne 0){
    if ($value -gt 1){
        write-host "The number of Accounts locked out are $value" -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        write-host "Users locked are $querynamed"  -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        write-host "$value Unlock Operations were done" -ForegroundColor green -backgroundcolor black
        $value.tostring() + " Accounts are locked out at " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "$querynamed" + " were locked out at " | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "$querynamed" + " have been unlocked on " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "`n" | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        foreach($i in $queryname){
            $user = Get-ADUser $i -Properties MemberOf
            if ("Colaborador_Venezuelal" -in $user.MemberOf){
                Unlock-ADAccount -Identity $i
                write-host $i.tostring() " was unlocked" -ForegroundColor green -backgroundcolor black
            }
        }
    }elseif($value -lt 2){
        write-host "The number of Accounts locked is are $value" -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        write-host "User locked is $querynamed"  -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        write-host "$value Unlock Operations were done" -ForegroundColor green -backgroundcolor black
        $value.tostring() + " Accounts are locked out at " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "$querynamed" + " was locked out at " | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "$querynamed" + " has been unlocked on " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        "`n" | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        foreach($i in $queryname){
            $user = Get-ADUser $i -Properties MemberOf
            if ("Colaborador_Venezuelal" -in $user.MemberOf){
                Unlock-ADAccount -Identity $i
                write-host $i.tostring() " was unlocked" -ForegroundColor green -backgroundcolor black
            }
        }    
    }
    
}elseif ($value -eq 0){
    write-host "The number of Account locked out is $value" -ForegroundColor green -backgroundcolor black
    write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
    write-host "$value Unlock Operation was done" -ForegroundColor green -backgroundcolor black
    $value.tostring() + " Accounts are locked out at " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
    "No User has been unlocked" + " has been unlocked on " + ($date) | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
    "`n" | Out-File -filepath C:\Users\ogie\Desktop\Alog.txt -Append
}
#Read-Host -Prompt "Press Enter to exit"
