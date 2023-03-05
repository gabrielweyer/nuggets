# Visual Studio Code

My editor of choice to edit `markdown`, `csproj`... files.

## Configuration

```text
{
    "csharp.suppressDotnetRestoreNotification": true, // Disable the "restore missing dependencies" notification
    "editor.minimap.enabled": false, // Disable the Sublime minimap
    "editor.renderControlCharacters": true,
    "editor.renderWhitespace": "all",
    "explorer.confirmDelete": false,  // Because who needs confirmation?
    "html.format.enable": false, // Because not even Chuck Norris can format HTML
    "php.validate.enable": false, // If you're just browsing PHP files
    "powershell.integratedConsole.showOnStartup": false
}
```

## Extensions

- [Azure Resource Manager (ARM) Tools][arm-tools]
- [Azurite][azurite]
- [Bicep][bicep]
- [EditorConfig for VS Code][editorconfig]
- [Jest Runner][jest-runner]
- [markdownlint][markdownlint]
- [PowerShell][powershell]
- [Prettier - Code formatter][prettier]

[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[editorconfig]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[prettier]: https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode
[arm-tools]: https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools
[azurite]: https://marketplace.visualstudio.com/items?itemName=Azurite.azurite
[jest-runner]: https://marketplace.visualstudio.com/items?itemName=firsttris.vscode-jest-runner
[powershell]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[bicep]: https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep
