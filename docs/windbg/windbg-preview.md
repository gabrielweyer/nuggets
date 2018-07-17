# WinDbg Preview

:rocket: [WinDbg Preview][windbg-preview-store] :rocket: supports both `x86` and `x64` memory dumps and can be installed [side by side][debugger-coexistence] with `WinDbg`.

## Shortcuts

- `Alt+Del`: Break - this is very convenient when on a laptop
- `Ctrl+Alt+H`: Highlight selected text (no multi-line support yet)

## Configure source and symbols

You can set `srcpath` and `sympath` from the [settings menu][settings-menu].

:rotating_light: After saving the settings, closing `WinDbg Preview` and opening it again, the settings will appear blank. Currently the settings are persisted in this file: `C:\Users\<user>\AppData\Local\Packages\Microsoft.WinDbg_8wekyb3d8bbwe\LocalCache\Local\DBG\DbgX.xml`, as long as they appear as expected in the file you're good to go.

## Extensions

:rotating_light: You'll have to provide a path when loading extensions:

```text
.load E:\symbols\winext\x86\mex.dll
```

## References

- [Documentation][documentation]
- [Blog][blog]

[debugger-coexistence]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/windbg-install-preview#debugger-coexistence
[windbg-preview-store]: https://www.microsoft.com/store/apps/9pgjgd53tn86
[settings-menu]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/windbg-setup-preview#settings
[documentation]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/debugging-using-windbg-preview
[blog]: https://blogs.msdn.microsoft.com/windbg/
