BeforeAll{
    # If the module is already in memory, remove it
    Get-Module ping_scan | Remove-Module -Force
     
    # Import the module from the local path, not from the users Documents folder
    import-module .\ping_scan.psm1 -Force
            
    }
    
    Describe "ping_scan::Ping-AddressRange Test" {
    
        Context "Invoked with parameters" {
            
        BeforeAll{

            Mock -ModuleName ping_scan Ping-AddressRange {
                return @{
                    Host_scanned="5"
                    Host_alive=@("192.168.8.31", "192.168.8.30", "192.168.8.33");
                    Localhost="192.168.23.4"
                    Num_alive_host="3"
                }
            } -ParameterFilter {
                # $NetIP -and $interface  
            } -Verifiable

             $net_ip = "192.168.8.30-35"
             $interface = "Wi-Fi"

             $result = Ping-AddressRange $net_ip $interface
            }
    
            It "Test should Scan all host  ✔" {
                Should -InvokeVerifiable
            }
    
            
            It "Test should Scan all host  ✔" {
                $result.Host_scanned | Should -Be $([int]$net_ip.split('-')[0].split('.')[$net_ip.split('-')[0].split('.').length - 1] - [int]$net_ip.split('-')[1])
            }
            # AfterAll{
               
                
            # }
    
    }
    
    # Context "Invoked with Incognito" {
    #     BeforeAll{
        
            
    #     }

    #     It "Test should ✔" {
               
    #     }

    #     AfterAll{
          
            
    #     }
    #  }

    }