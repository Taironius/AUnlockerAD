$groupDN = (Get-ADGroup "Colaboradores_Venezuelal").DistinguishedName

$query = Search-ADAccount -LockedOut | Where-Object{($_.enabled -ieq "True")}
$queryname = $query.samaccountname 
$date = Get-Date
$querynamed = write-output $queryname 
$count = $queryname | measure
$value = $count.count
if ($value -ne 0){
    if ($value -gt 1){
        write-host "Quantidade de contas Bloqueadas: $value" -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        foreach($i in $queryname){
            $user = Get-ADUser $i -Properties MemberOf
            if ($groupDN -in $user.MemberOf){
                Unlock-ADAccount -Identity $i
                write-host $i.tostring() " Foi desbloqueado" -ForegroundColor green -backgroundcolor black
            }
        }
    }elseif($value -lt 2){
        write-host "Quantidade de contas Bloqueadas: $value" -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
        foreach($i in $queryname){
            $user = Get-ADUser $i -Properties MemberOf
            if ($groupDN -in $user.MemberOf){
                Unlock-ADAccount -Identity $i
                write-host $i.tostring() " Foi desbloqueado" -ForegroundColor green -backgroundcolor black
            }
        }    
    }
    
}elseif ($value -eq 0){
    write-host "Quantidade de contas Bloqueadas: $value" -ForegroundColor white -BackgroundColor red
        write-host "-------------------------------------------------------" -ForegroundColor black -BackgroundColor yellow
}
#Read-Host -Prompt "Press Enter to exit"
