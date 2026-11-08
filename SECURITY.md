# Security Policy

## Supported Versions

Security fixes are developed on `main` and included in the next release. The
latest published release is the supported stable line. Older releases may be
asked to upgrade before receiving a fix.

## Reporting a Vulnerability

Do not open a public issue, pull request, or discussion for a suspected
vulnerability. Report it privately through GitHub Security Advisories:

https://github.com/ShariqueSalie/dwm-s/security/advisories/new

Include affected versions or commits, reproduction steps, impact, relevant
logs, and any proposed mitigation. Do not include credentials, private keys,
tokens, or unrelated personal data.

The maintainer will assess severity and scope, then coordinate a fix and
disclosure when the report is confirmed. Please allow a reasonable remediation
window before public disclosure. An initial response is expected within 7 days.

## Security Boundaries

The installer and helpers must preserve the privilege and configuration rules
in `SPEC.md`: package and system installation are explicit, user configuration
is preserved, downloaded artifacts are verified where checksums are available,
and privileged repair actions remain allowlisted and bounded.
