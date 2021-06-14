#
# Module manifest for module 'ping_scan'
#
# Generated by: ERIC
#
# Generated on: 4/12/2020
#

@{

  # Script module or binary module file associated with this manifest.
  RootModule = 'ping_scan'
  
  # Version number of this module.
  ModuleVersion = '0.1.3'
  
  # Supported PSEditions
  # CompatiblePSEditions = @()
  
  # ID used to uniquely identify this module
  GUID = 'cdfee914-9bf0-424d-9e14-8c571d4e1d1c'
  
  # Author of this module
  Author = 'ERIC MUTUA'
  
  # Company or vendor of this module
  CompanyName = 'Techcloud ltd'
  
  # Copyright statement for this module
  Copyright = '(c) ERIC MUTUA. All rights reserved.'
  
  # Description of the functionality provided by this module
  Description = 'Scan a range of Addresses and get back all alive host along side other statistics'
  
  # Minimum version of the PowerShell engine required by this module
  # PowerShellVersion = ''
  
  # Name of the PowerShell host required by this module
  # PowerShellHostName = ''
  
  # Minimum version of the PowerShell host required by this module
  # PowerShellHostVersion = ''
  
  # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # DotNetFrameworkVersion = ''
  
  # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # ClrVersion = ''
  
  # Processor architecture (None, X86, Amd64) required by this module
  ProcessorArchitecture = 'None'
  
  # Modules that must be imported into the global environment prior to importing this module
  # RequiredModules = @()
  
  # Assemblies that must be loaded prior to importing this module
  # RequiredAssemblies = @()
  
  # Script files (.ps1) that are run in the caller's environment prior to importing this module.
  # ScriptsToProcess = @()
  
  # Type files (.ps1xml) to be loaded when importing this module
  # TypesToProcess = @()
  
  # Format files (.ps1xml) to be loaded when importing this module
  # FormatsToProcess = @()
  
  # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
  # NestedModules = @()
  
  # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
  FunctionsToExport = @("Ping-AddressRange")
  
  # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
  CmdletsToExport = @()
  
  # Variables to export from this module
  VariablesToExport = '*'
  
  # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
  AliasesToExport = @()
  # DSC resources to export from this module
  # DscResourcesToExport = @()
  
  
  # List of all modules packaged with this module
  # ModuleList = @()
  
  # List of all files packaged with this module
  FileList = @("ping_scan.psd1", "ping_scan.psm1")
  
  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData = @{
  
      PSData = @{
  
          # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @("Powershell", "Ping", "Network", "IPv4")
  
          # A URL to the license for this module.
          # LicenseUri = 'https://github.com/ertush/ping_scan/blob/master/LICENSE'
  
          # A URL to the main website for this project.
          ProjectUri = 'https://github.com/ertush/ping_scan.git'
  
          # A URL to an icon representing this module.
          # IconUri = ''
  
          # ReleaseNotes of this module
          ReleaseNotes = 'https://gist.github.com/ertush/68e650d90df71ee75c4b6411674cf482'
  
          # Prerelease string of this module
          # Prerelease = ''
  
          # Flag to indicate whether the module requires explicit user acceptance for install/update/save
          RequireLicenseAcceptance = $false
  
          # External dependent modules of this module
            ExternalModuleDependencies = @("Test-Connection")
  
      } # End of PSData hashtable
  
  } # End of PrivateData hashtable
  
  # HelpInfo URI of this module
  HelpInfoURI = ''
  
  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  # DefaultCommandPrefix = ''
  
  }
  
  