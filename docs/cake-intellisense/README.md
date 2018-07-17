# Cake Intellisense in Visual Studio Code

Because I can never remember how to set it up.

**Note**: this does not work - yet - for `Cake.CoreCLR`.

## 1. Install `Cake.Bakery` globally

```posh
nuget.exe install Cake.Bakery -OutputDirectory <path> -ExcludeVersion
```

## 2. Install required `Visual Studio Code` extensions

- [C# for Visual Studio Code (powered by OmniSharp)][code-extension-c-sharp]
- [Cake][code-extension-cake]

## 3. Configure `OmniSharp`

Create a file called `omnisharp.json` in `%USERPROFILE%/.omnisharp/` with the following content:

```json
{
  "cake": {
    "bakeryPath": "<path>/Cake.Bakery/tools/Cake.Bakery.exe"
  }
}
```

## 4. Profit

Restart `Visual Studio Code` and start editing your `.cake` file.

## Troubleshooting

- Read the `OmniSharp Log` (`View` => `Output` => Select `OmniSharp Log` in the dropdown)

## References

- [Cake blog: Intellisense improvements in Visual Studio Code][code-cake-intellisense-improvements]

[code-extension-c-sharp]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp
[code-extension-cake]: https://marketplace.visualstudio.com/items?itemName=cake-build.cake-vscode
[code-cake-intellisense-improvements]: https://cakebuild.net/blog/2018/02/intellisense-improvements
