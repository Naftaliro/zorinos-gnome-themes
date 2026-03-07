# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in any of the install scripts in this repository, **please do NOT open a public GitHub issue.** Instead, report it privately using one of the following methods:

1. **GitHub Security Advisory (preferred):** Navigate to the [Security tab](https://github.com/Naftaliro/zorinos-gnome-themes/security/advisories) of this repository and click "Report a vulnerability."
2. **Private contact:** Open a [private vulnerability report](https://github.com/Naftaliro/zorinos-gnome-themes/security/advisories/new) directly.

## Scope

This policy covers only the install scripts and documentation maintained in this repository. Vulnerabilities in the **upstream theme projects** (e.g., WhiteSur, Colloid, Fluent, Orchis, Catppuccin, etc.) should be reported directly to their respective maintainers. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for links to all upstream repositories.

## What Qualifies

The following are examples of issues that should be reported as security vulnerabilities:

- A script that executes arbitrary code beyond its documented purpose
- A script that transmits data to an unexpected remote endpoint
- A script that modifies system files outside its documented scope
- Hardcoded credentials or secrets accidentally committed to the repository
- A supply-chain risk introduced by an unpinned dependency

## Response

I will acknowledge receipt of your report within **72 hours** and aim to provide a fix or mitigation within **7 days** for confirmed vulnerabilities.

## Supported Versions

| Version | Supported |
|---|---|
| Latest release | Yes |
| Older releases | Best effort |
