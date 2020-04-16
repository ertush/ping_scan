function Ping-AddressRange{

<#
.SYNOPSIS 
    Scan a range of addresses in a network or subnet 
.EXAMPLE
    Ping-AddressRange -NetID 192.168.0.1-224 -interface Wi-Fi  
.FUNCTIONALITY
    Get the successfull ping results of all the machines in a network
.DESCRIPTION
    Scan a range of Addresses and get back all alive host along side other statistics
#>

    [CmdletBinding()]
    param (
        # NetIP can be a range or a single IP
        [Parameter(
            Mandatory=$true,
            Position=1
        )]
        [string]
        $NetIP,

        # Network Interface to send ping requests
        [Parameter(
            Mandatory=$true,
            Position=2
        )]
        [string]
        $interface,

        # Path to save results
         [Parameter(
            Mandatory=$false,
            Position=3
        )]
        [string]
        $pathName
    
    )
    
    begin {
        
        $_range = $NetIP.Split('.')[3].Replace('-', '..');
        $_minRange, $_maxRange = [int]$_range.Split('..')[0], [int]$_range.Split('..')[1]
        $r_num = $($_maxRange - $_minRange); 
        $all_host = @{};
        $ErrorActionPreference = "SilentlyContinue";
       
    }
    
    process {

            if($_range -match '\d..\d'){

            $addressRange = $(
                                $(Invoke-Expression $_range) | 
                                ForEach-Object { $NetIP.Replace($NetIP.Split('.')[3], $_) } | 
                                ForEach-Object {

                                    # Show Progress of ping
                                    $current_add = [int]$_.Split('.')[3]
                                    Show-Progress($_, $current_add); 
                                    
                                    # Send 1 ping to IP
                                    ping $_ -n 1 
                                } 
                            )

            $pingResults = @{
                                    pinged_address=$(
                                    $addressRange |
                                    Select-String "Pinging*" | 
                                    ForEach-Object{
                                        $_.Line.split(' ')[1]
                                    }
                                    );
                                    Loss=$(
                                    $addressRange |
                                    Select-string "Packets*" |  
                                    
                                    # Select First No. x of the pinged addresses
                                    Select-Object -First $r_num |
                                    ForEach-Object{
                                        @{Packets=$_.Line.split(':')[1]}
                                    } | 
                                    ForEach-Object{
                                        $_["Packets"].split(',')[2].split('(')[0]
                                    })
                                }  
                                
            }
            
            # Populating $all_host
            if(@($pingResults.pinged_address).Count -ne 0){
                for($i=0;$i -lt @($pingResults.pinged_address).Count; $i++){
                    $all_host[@($pingResults["pinged_address"])[$i]]=@($pingResults["Loss"])[$i]
                }
            }   

        

            if($all_host.Count -ne 0){
                # filter all the alive host
        
                $alive_h = @( 
                                $all_host.Keys |
                                Where-Object{
                                    $($all_host.Item($_)) -imatch "Lost = 0"
                                }
                            )

               
                 # Print Results                                     
                Show-Stats($alive_h)

            
            }
                   
        }
    
    end {
        
    }
}


function Show-Progress(){

    param([string]$ip, [int]$pcnt)
    
    $_pcnt = [int]$ip.Split(' ')[1]
    $_ip = $ip.Split(' ')[0]
  
    while($_pcnt -gt 10){
        $_pcnt -= 10
    }

        $percnt = $($([int]$_ip.Split('.')[3] - $_minRange) * 100) / $($_maxRange - $_minRange)
    
        Write-Progress -Activity $("ping scan "+[int]$percnt+"%") -Status $("Pinging "+$_ip)  -PercentComplete  $($_pcnt * 10)
}

function Show-Stats(){
    param([string[]] $alive_hosts)

    $host_IP = $(Get-NetIPAddress | Where-Object{$_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -eq $interface} | ForEach-Object{$_.IPAddress})
    $stats = @{Host_alive=$alive_hosts; Localhost=$host_IP; Host_scanned=$r_num; Num_alive_host=$alive_hosts.Count}

    if($pathName -ne ""){
        Out-File -InputObject $stats -FilePath $pathName
    }

    return $stats
                 
}