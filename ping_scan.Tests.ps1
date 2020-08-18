$ping_scan='C:\Users\ERIC\Documents\devPowershell\my_powershell_modules\ping_scan\ping_scan.psm1'
Import-Module $ping_scan

Describe "ping_scan" {
    Context "Pinging One Address" {

    Mock -ModuleName ping_scan Test-Connection {} -Verifiable -ParameterFilter {
        $Object -eq @{Ping=1; Source="lhost"; Address="192.168.1.1"; Latecncy="4"; 
        BufferSize=32; Status="Success"}
    }

    Mock -ModuleName ping_scan $addressRange { $(Test-Connection 192.168.1.1 -Count 1) }
    Mock -ModuleName ping_scan $pingResults { @{ pinged_address=@("192.168.1.1"); Loss=@("")} }

    Mock -ModuleName ping_scan Show-Stats { }

    It "Should return pinged address" {
        Assert-MockCalled Show-Stats -ModuleName ping_scan -Times 0 -ParameterFilter { 
            $alive_hosts -eq @("192.168.1.1") 
        }
    }
}

    Context "Pinging a range of addresses" {

        Mock -ModuleName ping_scan $addressRange { 
            @("192.168.1.2", "192.168.1.3", "192.168.1.4") | 
            ForEach-Object{Test-Connection $_ -Count 1} 
        }

        Mock -ModuleName ping_scan $pingResults { 
            @{ 
                pinged_address= @("192.168.1.2", "192.168.1.2", "192.168.1.3", "192.168.1.4"); 
                Loss=@("")
            } 
        }

        Mock -ModuleName ping_scan Show-Stats { }

        It "It should return an array of pinged addresses" {
            Assert-MockCalled Show-Stats -ModuleName ping_scan -Times 0 -ParameterFilter {
                $alive_hosts -eq @("192.168.1.3", "192.168.1.4"); 
            }
        }
    }
    
    Context "Show-Stats" {
        Mock Show-Stats -Verifiable -ParameterFilter { 
            $alive_hosts -eq @("192.168.1.1", "192.168.1.4", "192.168.1.5")
        }

        Mock Show-Stats -Verifiable -ParameterFilter { 
            $host_IP -eq $("192.168.1.1")
        }

        Mock Show-Stats -Verifiable -ParameterFilter { 
            $r_num -eq $(3)
        }

        # Mock Show-Stats -ModuleName ping_scan -MockWith {
        #     return @{name="Ping_Scan_Stats"}
        # }

         $result = Show-Stats

        # It "Return ping statistics" {
        #     Assert-VerifiableMock
        # }

        It "Returns a hashtable" {
            # $alive_host -eq  @("192.168.1.1", "192.168.1.4", "192.168.1.5");
            Assert-MockCalled Show-Stats -ModuleName ping_scan -Times 0 -ParameterFilter {
                $result | Should -Be @{
                    Host_alive=@("192.168.1.1", "192.168.1.4", "192.168.1.5"); 
                    Localhost=$("192.168.1.1"); 
                    Host_scanned=@("192.168.1.1", "192.168.1.4", "192.168.1.5"); 
                    Num_alive_host=$(3)
                }
            }

            # $($result -eq $null) | Should -Be $false
        }
    }
}