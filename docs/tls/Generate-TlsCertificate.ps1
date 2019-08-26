#requires -Version 6.0

<#

.SYNOPSIS
Generate a TLS certificate for local development

.DESCRIPTION
Generate a Certificate Authority and a TLS certificate for localtest.me and *.localtest.me.

.PARAMETER TrustCa
Automatically trust the Certificate Authority.
This switch is only available on Windows.

.EXAMPLE
./Generate-TlsCertificate.ps1

.EXAMPLE
./Generate-TlsCertificate.ps1 -TrustCa

.NOTES
Requires Docker to be installed.

.LINK
https://github.com/gabrielweyer/nuggets/

#>

[CmdletBinding()]
Param (
    [switch]
    $TrustCa
)

$ErrorActionPreference = 'Stop'

if (!$IsWindows -and $TrustCa) {
    throw 'The -TrustCa switch is only available on Windows for the moment'
}

try {
    docker --version 1>$null
}
catch {
    throw 'Docker is not installed'
}

try {
    Push-Location "$PSScriptRoot/out"

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Running Docker image to generate TLS certificate'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    Write-Verbose "Current directory is '$PWD'"

    docker run --detach --interactive --rm --tty `
        --name cert-maker `
        -v "${PWD}:/tls" `
        -w '/tls' `
        node | Out-Null

    if ($LASTEXITCODE -ne 0) {
        Throw "Running the Node.js Docker image returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Creating the Certificate Authority RSA key'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    # https://www.openssl.org/docs/manmaster/man1/genpkey.html
    docker exec cert-maker openssl genpkey `
        -algorithm RSA `
        -pkeyopt rsa_keygen_bits:2048 `
        -out ./ca.key

    if ($LASTEXITCODE -ne 0) {
        Throw "Creating the Certificate Authority RSA key returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Creating the Certificate Authority certificate'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    # https://www.openssl.org/docs/manmaster/man1/req.html
    docker exec cert-maker openssl req `
        -x509 `
        -config ./configuration/ca.cnf `
        -new `
        -nodes `
        -key ./ca.key `
        -sha256 `
        -days 365 `
        -out ./ca.crt

    if ($LASTEXITCODE -ne 0) {
        Throw "Creating the Certificate Authority certificate returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Creating the "localtest.me" TLS server certificate RSA key'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    docker exec cert-maker openssl genpkey `
        -algorithm RSA `
        -pkeyopt rsa_keygen_bits:2048 `
        -out ./tls-cert.key

    if ($LASTEXITCODE -ne 0) {
        Throw "Creating the 'localtest.me' TLS server certificate RSA key returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Creating the Certificate Signing Request for "localtest.me"'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    docker exec cert-maker openssl req `
        -config ./configuration/localtest.me.cnf `
        -new `
        -nodes `
        -key ./tls-cert.key `
        -sha256 `
        -reqexts v3_req `
        -out ./tls-cert.csr

    if ($LASTEXITCODE -ne 0) {
        Throw "Creating the Certificate Signing Request for 'localtest.me' returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Creating the TLS server certificate for "localtest.me"'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    docker exec cert-maker openssl x509 `
        -req `
        -in ./tls-cert.csr `
        -CA ./ca.crt `
        -CAkey ./ca.key `
        -CAcreateserial `
        -extfile ./configuration/localtest.me.cnf `
        -extensions v3_req `
        -sha256 `
        -days 365 `
        -out ./tls-cert.crt

    if ($LASTEXITCODE -ne 0) {
        Throw "Creating the TLS server certificate for 'localtest.me' returned exit code $LASTEXITCODE"
    }

    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'
    Write-Host -ForegroundColor Magenta '| Trusting the Certificate Authority'
    Write-Host -ForegroundColor Magenta '-------------------------------------------------------------------'

    if ($TrustCa) {
        Write-Host -ForegroundColor Cyan 'Converting the Certificate Authority certificate to a PKCS#12'

        docker exec cert-maker openssl pkcs12 `
            -export `
            -in ./ca.crt `
            -inkey ./ca.key `
            -out ./ca.p12 `
            -passout pass:password `
            -name 'Local Development CA'

        if ($LASTEXITCODE -ne 0) {
            Throw "Converting the Certificate Authority certificate to a PKCS#12 returned exit code $LASTEXITCODE"
        }

        Write-Warning "Windows will display a prompt demanding you if you want to install this Certificate Authority's certificate"

        $Path = Join-Path $PSScriptRoot 'out\ca.p12'
        $CertificateAuthority = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($Path, 'password')
        $Store = get-item cert:\CurrentUser\Root
        $Store.Open('ReadWrite')
        $Store.Add($CertificateAuthority)
        $Store.Close()
    } else {
        Write-Host -ForegroundColor Cyan "The switch -TrustCa was not used, we won't install this Certificate Authority certificate"
    }
}
finally {
    docker container stop cert-maker | Out-Null
    Pop-Location
}
