## Ping_Scan

Scan a range of Addresses and get back all alive host along side other statistics

## Usage

```powershell Ping-AddressRange <ip_address [string]> <interface (Wi-Fi | Ethernet | ...) [string]>```

## Example

```powershell Ping-AddressRange 192.168.1.3-45 Wi-Fi``` 
    
## Dependencies

None

## Install

```Install-Module -Name ping_scan -RequiredVersion 0.2.1``` 

then

```import-module -Path ${env:ProgramFiles(x86)}\WindowsPowerShell\Modules\ping_scan\<version>\ping_scan.psm1``` 

where 'version' is the version you installed
