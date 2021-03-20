# Code review

- Code reviews are everyone's responsibility
- Reply to a code review request as soon as you can
- Limit the number of reviewers (no more than 2)
- Remember to praise
- Reviews should be based on agreed-on coding standards, not personal preferences

## Focus (mainly) on the logic rather than the formatting

- Does it meet the Acceptance Criteria?
- Do you understand it?
  - Don't hesitate to pull down the code and run it on your machine
- [Formatting, style and syntax should be enforced by tooling](../dotnet/coding-convention/README.md)

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

## Don't block the author

- Once you're happy with the changes and you're confident the developer will address the remaining comments you can approve with suggestions so that the author can merge the changes without requiring any further interaction
- Prefix comments with "_Nit:_ " to indicate to the author that they're not expected to fix them
- If you find some major design issues, provide feedback immediately rather than reviewing the whole Pull Request

## Behaviours to avoid

- Drive-by comment: leaving a single comment without following through or approving the changes, hence forcing the Pull Request author to contact you
- Oral feedback: not capturing the feedback that led to changes, if it's not written it'll be forgotten

## Conflict

Sometimes you go back and forth a few times on a specific comment without reaching an agreement:

1. If possible discuss face to face
2. If you still can't resolve the issue, involve a third person

## References

- [Code Review Best Practices - Palantir Technologies][code-review-best-practices-palantir-technologies]
- [Code Review - thoughtbot][code-review-thoughtbot]
- [Code review guidelines - Madalin Ilie][code-review-guidelines-madalin-ilie]
- [Code Review Guidance - The Nerdery][code-review-guidance-the-nerdery]
- [How to Make Good Code Reviews Better - Stack Overflow blog][how-to-make-good-code-reviews-better-stack-overflow-blog]
- [How to do a code review - Google][how-to-do-a-code-review-google] (the document is hard to navigate but contains valuable guidance, `CL` stands for changelist as defined in the [terminology][google-engineering-practices-terminology])

[code-review-best-practices-palantir-technologies]: https://medium.com/palantir/code-review-best-practices-19e02780015f
[code-review-thoughtbot]: https://thoughtbot.com/blog/five-tips-for-more-helpful-code-reviews
[code-review-guidelines-madalin-ilie]: https://www.codeproject.com/Articles/524235/Codeplusreviewplusguidelines
[code-review-guidance-the-nerdery]: https://github.com/thenerdery/process-guidance/blob/master/code-review-guidance.md
[how-to-do-a-code-review-google]: https://google.github.io/eng-practices/review/reviewer/
[google-engineering-practices-terminology]: https://google.github.io/eng-practices/#terminology
[how-to-make-good-code-reviews-better-stack-overflow-blog]: https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/
