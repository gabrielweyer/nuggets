# Documentation

**Note**: this is a work in progress.

The projects that I join tend to fall into two categories: either they have no documentation at all (not even a `README`) or the documentation is composed of lenghty `Word` documents mainly filled with placeholders and sections pasted from other documents.

## High level guidance

- Documentation should be colocated with the code
- Favor a format that can be edited without dedicated software and viewed easily on different platforms (such as [Markdown][markdown] for example)

## Types of documentation

### Getting started

- `README`
- High level diagram

### No name yet

Describe the implementation details for parts of the system that are important and / or complex.

### Architecture Decision Record

#### Examples of Architecture Decision Record

- [The GOV.UK repository for our Migration to AWS][adr-govuk-aws]
- [Eclipse Winery project][adr-eclipse-winery]
- [Gauge][adr-gauge]
- [Holochain in Rust][adr-holochain]

## References

- [Documenting Architecture Decisions][michael-nygard-documenting-architecture-decisions] by Michael Nygard
- [Decision Log][simon-brown-decision-log], [Code][simon-brown-code] and [Development Environment][simon-brown-development-environment] by Simon Brown

[markdown]: https://en.wikipedia.org/wiki/Markdown
[michael-nygard-documenting-architecture-decisions]: http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions
[simon-brown-decision-log]: https://structurizr.com/help/documentation/decision-log
[simon-brown-code]: https://structurizr.com/help/documentation/code
[simon-brown-development-environment]: https://structurizr.com/help/documentation/development-environment
[adr-govuk-aws]: https://github.com/alphagov/govuk-aws/tree/master/doc/architecture/decisions
[adr-eclipse-winery]: https://github.com/eclipse/winery/tree/master/docs/adr
[adr-gauge]: https://github.com/getgauge/gauge/wiki/ADR
[adr-holochain]: https://github.com/holochain/holochain-rust/tree/master/doc/architecture/decisions
