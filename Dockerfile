ARG InstallerRepo=mcr.microsoft.com/powershell
ARG InstallerVersion=lts-alpine-3.10

FROM ${InstallerRepo}:$InstallerVersion

WORKDIR /module

COPY ./ping_scan.psm1 .

# Import ping_scan Module And launch ping-AddressRange cmdlet
ENTRYPOINT  ["pwsh", "-Command", "Import-Module", "./ping_scan.psm1;", "Ping-AddressRange"]
