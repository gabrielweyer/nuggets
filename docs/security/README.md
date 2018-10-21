# Security

## For companies

- Pay for a password manager ([1Password][1password] and [LastPass][lastpass] are two alternatives I know of)
- Enforce strong passwords ([Jeff Atwood has some nice advice][jeff-atwood-password])
- Do not require user account password to be changed periodically ([NIST - Digital Identity Guidelines - Memorized Secret Verifiers][nist-digital-identity-guidelines])
  - `Verifiers SHOULD NOT require memorized secrets to be changed arbitrarily (e.g., periodically)`
- Use Two Factor Authentication
- Do not inspect the SSL traffic of your employees
- Avoid account sharing (typically happens on off the shelf products)
  - Instead use federation (such as `Azure Active Directory`) whenever possible

## Credentials

- Do not exchange credentials over insecure mediums (such as `Slack`, `Microsoft Teams`, `email`, `Skype`...). For a concrete example read [Slack bot token leakage exposing business critical information][slack-credentials]

## Infrastructure

- Protect the development infrastructure (CI / CD) with the same care than the production infrastructure

## Development

- Do not embed third-party `JavaScript` scripts on the sign-in page
- Avoid storing passwords
  - Leverage `OAuth 2.0` and / or `OpenID Connect` instead
  - If you decide to store passwords, rely on your framework of choice built-in capacity (after assessing than it complies with these [guidelines][nist-digital-identity-guidelines])
- Do not reuse credentials across environments (such as `UAT` and `PROD` for example)
- `HTTPS` only please

## Payment

- Use a payment provider rather than handling credit cards yourself
  - If you decide to handle payment yourself, do not embed third-party `JavaScript` scripts on the payment page

## Source control

- Do not store credentials alongside the code in source control (this includes third-party services credentials, certificates, certificate passwords...)

## Certificates

- The only acceptable use of a self-signed certificate is for development purpose on a locally hosted service
  - Each developer should generate its own `Certificate Authority` ([this can be scripted](../tls/README.md))
- Use valid certificates for everything else (cloud services often come with a valid `TLS` certificate, [Let's Encrypt][lets-encrypt] will allow you to automate certificates for you test environments)

[jeff-atwood-password]: https://blog.codinghorror.com/password-rules-are-bullshit/
[slack-credentials]: https://labs.detectify.com/2016/04/28/slack-bot-token-leakage-exposing-business-critical-information/
[1password]: https://1password.com/teams/pricing/
[lastpass]: https://www.lastpass.com/business-password-manager
[nist-digital-identity-guidelines]: https://pages.nist.gov/800-63-3/sp800-63b.html#-5112-memorized-secret-verifiers
[lets-encrypt]: https://letsencrypt.org/
