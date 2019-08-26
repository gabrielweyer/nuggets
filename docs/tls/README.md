# Generate a TLS server certificate on Windows and macOS

`Generate-TlsCertificate.ps1` generates a `TLS` server certificate for `localtest.me` and `*.localtest.me` ([localhost testing done right][locatest-me]).

:rotating_light: this is only intended to be used on **your** machine for development purposes. For everything else please use [Let's Encrypt][lets-encrypt] :bow:.

## Goals

- No configuration
- Generates a `Certificate Authority` so that it can be trusted in [Firefox][mozilla-ca-certiifcate-store] and other systems as required

## Pre-requisites

- [Docker][download-docker]
- `PowerShell Core`
  - [instructions for Windows][install-ps-core-windows]
  - [instructions for macOS][install-ps-core-macos]

## Usage

```powershell
.\Generate-TlsCertificate.ps1
```

You can optionally decide to trust the `Certificate Authority`:

```powershell
.\Generate-TlsCertificate.ps1 -TrustCa
```

:notebook: you can get `Firefox` to import `Certificate Authorities` from the `Windows certificate store` automatically. You can enable this feature in `about:config` by creating this boolean value:

```text
security.enterprise_roots.enabled
```

and set it to `true`. The `Certificate Authority` needs to be added to the `Trusted Root Certification Authorities` store of the **Local Computer**.

## Troubleshooting

The easiest way to troubleshoot is to get yourself a terminal using the same image that was used to create the `TLS` server certificate:

```powershell
docker run -it --rm -v "${PWD}/out:/tls" -w '/tls' node bash
```

### Inspecting the Certificate Authority certificate

```bash
openssl x509 -noout -text -in ./ca.crt
```

### Inspecting the localtest.me CSR

```bash
openssl req -noout -text -in ./tls-cert.csr
```

### Inspecting the localtest.me TLS server certificate

```bash
openssl x509 -noout -text -in ./tls-cert.crt
```

[locatest-me]: https://github.com/localtest-dot-me/localtest-dot-me.github.com#readme
[lets-encrypt]: https://letsencrypt.org/
[mozilla-ca-certiifcate-store]: https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/
[add-root-to-firefox]: https://wiki.mozilla.org/CA:AddRootToFirefox
[download-docker]: https://www.docker.com/get-started
[install-ps-core-windows]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6
[install-ps-core-macos]: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-macos?view=powershell-6
