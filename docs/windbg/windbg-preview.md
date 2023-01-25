# WinDbg Preview

:rocket: [WinDbg Preview][windbg-preview-store] :rocket: supports both `x86` and `x64` memory dumps and can be installed [side by side][debugger-coexistence] with `WinDbg`.

## Shortcuts

- `Alt+Del`: Break - this is very convenient when on a laptop
- `Ctrl+Alt+H`: Highlight selected text (no multi-line support yet)

## Configure source and symbols

You can set `srcpath` and `sympath` from the [settings menu][settings-menu].

## Extensions

:rotating_light: You'll have to provide a path when loading extensions:

```text
.load E:\symbols\winext\x86\mex.dll
```

## References

- [Documentation][documentation]

[debugger-coexistence]: https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/windbg-install-preview#debugger-coexistence
[windbg-preview-store]: https://apps.microsoft.com/store/detail/windbg-preview/9PGJGD53TN86
[settings-menu]: https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/windbg-setup-preview#settings
[documentation]: https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/debugging-using-windbg-preview
