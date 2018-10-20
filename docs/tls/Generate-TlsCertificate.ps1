[CmdletBinding()]
Param (
    [switch]
    $TrustCa
)

$ErrorActionPreference = 'Stop'

try {
    wsl /bin/bash --version 1>$null
}
catch {
    Write-Error 'Windows Subsystem for Linux is not installed, please refer to the README'
}

Write-Host ''
Write-Host '- Creating the CA RSA key'
Write-Host ''

# https://www.openssl.org/docs/manmaster/man1/genpkey.html
wsl openssl genpkey `
    -algorithm RSA `
    -pkeyopt rsa_keygen_bits:2048 `
    -out out/ca.key

if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating the CA RSA key returned exit code $LASTEXITCODE"
}

Write-Host ''
Write-Host '- Creating the CA certificate'
Write-Host ''

# https://www.openssl.org/docs/manmaster/man1/req.html
wsl openssl req `
    -x509 `
    -config ca.cnf `
    -new `
    -nodes `
    -key out/ca.key `
    -sha256 `
    -days 365 `
    -out out/ca.crt

if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating the CA certificate returned exit code $LASTEXITCODE"
}

Write-Host ''
Write-Host '- Creating the "localtest.me" TLS server certificate RSA key'
Write-Host ''

wsl openssl genpkey `
    -algorithm RSA `
    -pkeyopt rsa_keygen_bits:2048 `
    -out out/localtest.me.key

if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating the ""localtest.me"" TLS server certificate RSA key returned exit code $LASTEXITCODE"
}

Write-Host ''
Write-Host '- Creating the CSR for "localtest.me"'
Write-Host ''

wsl openssl req `
    -config localtest.me.cnf `
    -new `
    -nodes `
    -key out/localtest.me.key `
    -sha256 `
    -reqexts v3_req `
    -days 365 `
    -out out/localtest.me.csr

if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating the CSR for ""localtest.me"" returned exit code $LASTEXITCODE"
}

Write-Host ''
Write-Host '- Creating the TLS server certificate for "localtest.me"'
Write-Host ''

wsl openssl x509 `
    -req `
    -in out/localtest.me.csr `
    -CA out/ca.crt `
    -CAkey out/ca.key `
    -CAcreateserial `
    -extfile localtest.me.cnf `
    -extensions v3_req `
    -sha256 `
    -days 365 `
    -out out/localtest.me.crt

if ($LASTEXITCODE -ne 0) {
    Write-Error "Creating the TLS server certificate for ""localtest.me"" returned exit code $LASTEXITCODE"
}

Write-Host ''
Write-Host '- Trusting the Certificate Authority'
Write-Host ''

if ($TrustCa) {
    Write-Host 'Converting the CA certificate to a PKCS#12'

    wsl openssl pkcs12 `
        -export `
        -in out/ca.crt `
        -inkey out/ca.key `
        -out out/ca.p12 `
        -passout pass:password `
        -name "Local Development CA"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Converting the CA certificate to a PKCS#12 returned exit code $LASTEXITCODE"
    }

    Write-Warning 'Windows will display a prompt demanding you if you want to install this Certificate Authority''s certificate'

    $Path = Join-Path $PSScriptRoot "out\ca.p12"
    $CertificateAuthority = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($Path, 'password')
    $Store = get-item cert:\CurrentUser\Root
    $Store.Open("ReadWrite")
    $Store.Add($CertificateAuthority)
    $Store.Close()
} else {
    Write-Host 'The switch "TrustCa" was not used, we won''t install this Certificate Authority certificate'
}
