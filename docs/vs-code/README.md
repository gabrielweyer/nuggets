# Visual Studio Code

My editor of choice to edit `markdown`, `csproj`, `Cake build`... files.

## Configuration

```text
{
    "csharp.suppressDotnetRestoreNotification": true, // Disable the "restore missing dependencies" notification
    "editor.minimap.enabled": false, // Disable the Sublime minimap
    "explorer.confirmDelete": false,  // Because who needs confirmation?
    "html.format.enable": false, // Because not even Chuck Norris can format HTML
    "php.validate.enable": false, // If you're just browsing PHP files
}
```

## Extensions

- [EditorConfig for VS Code][editor-config]
- [markdownlint][markdownlint]
- [Prettier - Code formatter][prettier]

[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[editor-config]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[prettier]: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
