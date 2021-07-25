# azure cli with powershell on a linux container. This is only possible because hell was frozen by Microsoft.

FROM mcr.microsoft.com/powershell:ubuntu-18.04

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

ENTRYPOINT [ "pwsh" ]
