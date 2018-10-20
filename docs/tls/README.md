# Generate a TLS server certificate on Windows

:rotating_light: this is still a work a progress.

`Generate-TlsCertificate.ps1` generates a `TLS` server certificate for `localtest.me` ([localhost testing done right][locatest-me]).

:rotating_light: this is only intended to be used on **your** machine for development purposes. For everything else please use [Let's Encrypt][lets-encrypt] :bow:.

## Goals

- No configuration
- Generates a `Certificate Authority` so that it can be trusted in [Firefox][mozilla-ca-certiifcate-store]

## Pre-requisites

- [Windows Subsystem for Linux][install-wsl]

## Usage

```posh
.\Generate-TlsCertificate.ps1
```

You can optionally decide to trust the `Certificate Authority`:

```posh
.\Generate-TlsCertificate.ps1 -TrustCa
```

:notebook: you can get `Firefox` to import `Certificate Authorities` from the `Windows certificate store` automatically. You can enable this feature in `about:config` by creating this boolean value:

```text
security.enterprise_roots.enabled
```

and set it to `true`.

## Troubleshooting

### Inspecting the Certificate Authority certificate

```posh
wsl openssl x509 -noout -text -in out/ca.crt
```

### Inspecting the localtest.me CSR

```posh
wsl openssl req -noout -text -in out/localtest.me.csr
```

### Inspecting the localtest.me TLS server certificate

```posh
wsl openssl x509 -noout -text -in out/localtest.me.crt
```

[locatest-me]: https://github.com/localtest-dot-me/localtest-dot-me.github.com#readme
[lets-encrypt]: https://letsencrypt.org/
[mozilla-ca-certiifcate-store]: https://www.mozilla.org/en-US/about/governance/policies/security-group/certs/
[install-wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[add-root-to-firefox]: https://wiki.mozilla.org/CA:AddRootToFirefox
