# Code review

- Code reviews are everyone's responsibility
- Limit the number of reviewers (no more than 2)
- Remember to praise
- Reviews should be based on agreed-on coding standards, not personal preferences

## Focus (mainly) on the logic rather than the formatting

- Does it meet the Acceptance Criteria?
- Do you understand it?
  - Don't hesitate to pull down the code and run it on your machine
- Formatting, style and syntax should be enforced by tooling

## Provide constructive feedback

- Prefer questions to demands
  - Avoid assumptions, ask for clarification
- Link to documentation, blog articles...

## Does it have meaningful tests

- Are the tests testing the behaviour rather than the implementation details?

## Is documentation required

- If it's a new service, could you start it up on your own?
- If it's an integration with a 3rd party, could you run it on your own?

## Consistency

- Is the author re-inventing a pattern that is already present in the codebase?

## Conflict

Sometimes you go back and forth a few times on a specific comment without reaching an agreement:

1. If possible discuss face to face
2. If you still can't resolve the issue, involve a third person

## References

- [Code Review Best Practices - Palantir Technologies][code-review-best-practices-palantir-technologies]
- [Code Review - thoughtbot][code-review-thoughtbot]
- [Code review guidelines - Madalin Ilie][code-review-guidelines-madalin-ilie]

[code-review-best-practices-palantir-technologies]: https://medium.com/palantir/code-review-best-practices-19e02780015f
[code-review-thoughtbot]: https://github.com/thoughtbot
[code-review-guidelines-madalin-ilie]: https://www.codeproject.com/Articles/524235/Codeplusreviewplusguidelines
