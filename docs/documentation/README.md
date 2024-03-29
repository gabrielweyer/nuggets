# Documentation

The projects that I join tend to fall into two categories: either they have no documentation at all (not even a `README`) or the documentation is composed of lenghty `Word` documents mainly filled with placeholders and sections pasted from other documents.

## High level guidance

- Documentation should be colocated with the code
- Favor a format that can be edited without dedicated software and viewed easily on different platforms (such as [Markdown][markdown] for example)

If required you can write more extensive documentation in a knowledge management system. Link to it from your repository.

## Types of documentation

### Getting started

Ideally a new team member should be able to run a system without any assistance. The root of the repository should contain a `README.md` file containing:

- The prerequisites required to run the system
- The configuration (including secrets)

Ideally this would be automated so a new developer would only need to run a single command to get their environment up and running.

You can provide additional information, either in `README` or in a knowledge management system:

- Links to build and release pipelines
- High level architecture and flow diagrams
- Environments

### Implementation details

Describe the implementation details for parts of the system that are important and / or complex.

### Architecture Decision Record

An [Architecture Decision Record][michael-nygard-documenting-architecture-decisions] is a short text file. Each record describes a set of forces and a single decision in response to those forces. The concept was introduced by Michael Nygard.

#### Examples of Architecture Decision Record

- [The GOV.UK repository for our Migration to AWS][adr-govuk-aws]
- [Eclipse Winery project][adr-eclipse-winery]
- [Gauge][adr-gauge]
- [Holochain in Rust][adr-holochain]

## References

- [Decision Log][simon-brown-decision-log], [Code][simon-brown-code] and [Development Environment][simon-brown-development-environment] by Simon Brown

[markdown]: https://en.wikipedia.org/wiki/Markdown
[michael-nygard-documenting-architecture-decisions]: https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
[simon-brown-decision-log]: https://structurizr.com/help/documentation/decision-log
[simon-brown-code]: https://structurizr.com/help/documentation/code
[simon-brown-development-environment]: https://structurizr.com/help/documentation/development-environment
[adr-govuk-aws]: https://github.com/alphagov/govuk-aws/tree/master/docs/architecture/decisions
[adr-eclipse-winery]: https://github.com/eclipse/winery/tree/master/docs/adr
[adr-gauge]: https://github.com/getgauge/gauge/wiki/ADR
[adr-holochain]: https://github.com/holochain/holochain-rust/tree/master/doc/architecture/decisions
