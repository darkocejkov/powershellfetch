

$log = Get-CimInstance -ClassName Win32_LogonSession | Select-Object -Property StartTime
$log = $log."StartTime"[0]
#got the logon time (full date/time)

$mobo = (Get-WmiObject -Class Win32_BaseBoard).product
$pc = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property Name
#mobo model
$pc = $pc.Name
#pc name
$user = $env:USERNAME

$cpu = Get-CimInstance -ClassName Win32_Processor
$cpu = $cpu.Name
#cpu name/brand/clock

$os = (Get-WMIObject win32_operatingsystem).name
$os = $os.Split("|")
$os = $os[0]
#0th index is OS, others are irrelevant
$arch = (Get-WmiObject win32_operatingsystem).osarchitecture
# gets architecture

$ram = (systeminfo | Select-String 'Total Physical Memory:').ToString().Split(':')[1].Trim()
#ram in MB

@"

 g@@@@@@@@@@@@@@@@@@@@@@@@b_    ━━━━━━━━━━━( $user@$pc )━━━━━━━━━━┐
0@@@@@@@@@@@@@@@@@@@@@@@@@@@k                      
0@@@@@@@@@@@@@^^#@@@@@@@@@@@@L                     
 #@@@@@@@@@@"   J@@@@@@@@@@@@@             Logon: $log                            
               J@@@@@@@@@@@@@@b               
              d@@@@@##@@@@@@@@@L           Mobo:  $mobo                 
             d@@@@#   ^@@@@@@@@Q                        
            d@@@@@@r    #@@@@@@@|          CPU:   $cpu
           d@@@@@@@|     #@@@@@@@r             
          0@@@@@@@P       0@@@@@@%         OS:    $os $arch        
         0@@@@P            0@@@@@@L        
        0@@@@^              0@@@@@@        Mem:   $ram        
       #@@@F                 0@@@@@b       
       1@@@^                   @@@@@L      
                                @@@@@      
                                 @@@@|     
                                  ##P  
"@
