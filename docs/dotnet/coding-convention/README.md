# .NET coding convention

Stay close to the convention adopted by the framework you're using and/or the community. When selecting the tooling keep in mind than `.NET Core` is cross-platform and it is likely than some of your developers will not be using `Visual Studio`.

As a starting point I recommend the [coding convention][roslyn] adopted by the `Roslyn` team.

The most important benefit you get out of a coding convention is **consistency**.

## Tooling

I recommend using [EditorConfig][editorconfig] as it is supported by:

- [Visual Studio][visual-studio]
- [ReSharper][resharper]
- [Rider][rider]
- [Visual Studio Code][visual-studio-code]

[editorconfig]: https://editorconfig.org/
[visual-studio]: https://docs.microsoft.com/en-us/visualstudio/ide/editorconfig-code-style-settings-reference
[resharper]: https://www.jetbrains.com/help/resharper/Using_EditorConfig.html
[rider]: https://www.jetbrains.com/help/rider/Using_EditorConfig.html
[visual-studio-code]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[roslyn]: https://github.com/dotnet/roslyn/blob/main/.editorconfig
