# WinDbg

`WinDbg` is a beast, this guide will barely touch the surface but hopefully it will be enough to get you started.

## Write a memory dump

The first step is to get a **memory dump**. I recommend using [ProcDump][proc-dump] from [Sysinternals]. You can set up rules to capture a dump when certain conditions are met (i.e. exception thrown, CPU usage, memory usage...). The simplest use case is to capture a dump using a process name:

```posh
procdump.exe -ma process-name
```

**Note**: If you decide to use something else don't forget you need a **full** dump (instead of a **mini** dump).

## Download and install `WinDbg`

You can get `WinDbg` by installing the `Windows Development Kit` or by getting it from the store (`Windows 10` only).

### Windows Development Kit

Download the [Windows Development Kit][windows-development-kit].

In the installation wizard, select `Debugging Tools for Windows` and clear all the other components.

`WinDbg` comes in two flavors: `x86` and `x64`. Both will be installed, when loading a dump make sure you select the one matching the bitness of your process.

### Store

Alternatively if you're running `Windows 10` you can install a `WinDbg` preview from the [store][win-dbg-store]. This most likely will become the preferred distribution channel.

## Symbols

Having `symbols` will make the debugging experience much nicer. When building, either publish your `PDB`s to a `symbols` server or store them as artifacts. Then when needed copy them to `C:\bin\` (or whatever you set your `sympath` too).

You can set `sympath` - the location(s) where `WinDbg` will look for `symbols` - via an environment variable, a setting or during the debugging session.

### Environment variable

- **Variable name**: `_NT_SYMBOL_PATH`
- **Variable value**: `C:\bin\;symsrv*symsrv.dll*c:\symbols*http://msdl.microsoft.com/download/symbols`

### Setting

- Open the `File` menu -> Select `Symbol File Path ...`
- Enter the below in the textbox, select `Reload` and click `Ok`

```text
C:\bin\;SRV*C:\symbols*http://msdl.microsoft.com/download/symbols
```

### During the session

Alternatively you can load the `symbols` during the session:

```text
.sympath C:\bin\;SRV*C:\symbols*http://msdl.microsoft.com/download/symbols
.reload
```

`File` -> `Save Workspace` will persist your `sympath`!

## Extensions

`WinDbg` is a bit dry but luckily there are some extensions providing some nifty commands.

### SOS

Load the `CLR` debugging extensions.

- Full framework:

```text
.loadby sos clr
```

**Note**: `SOS` has been superseded by `Psscor4` for the full framework.

- `.NET Core`

```text
.loadby sos coreclr
```

### Psscor4

**Note**: `Psscor4` does not support `.NET Core` yet. You'll have to stick with `SOS`.

`Psscor4` is a superset of `SOS`. Most of the added functionality helps you identify issues in `ASP.NET`.

Download [Psscor4][psscor4]. You need to "install" it, but it will actually extract it somewhere of your choosing.

Extract them here:

- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\winext`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\winext`

Basically find where `WinDbg` (`windbg.exe`) is installed and copy in the `winext\` sub-folder.

```text
.load psscor4
```

### SOSEX

My favorite and the masterpiece of Steve Johnson.

Download links:

- [x86][sosex-32]
- [x64][sosex-64]

Copy the `DLL`s in the same folder than `Psscor4`.

```text
.load sosex
```

## `WinDbg` commands

Find available commands for a specific extension (once loaded):

```text
.extmatch /e *psscor4* *
```

Get latest exception (also known as the magic command):

```text
!analyze -v
```

See all threads:

```text
!threads
```

Objects per generation:

```text
!FinalizeQueue
```

List of drivers:

```text
lm t.lon
```

### Shortcuts

- **Exiting current operation**: `Ctrl + Break key`
- **Focus textbox**: `ALT + 1`

### Session settings

Will add hyperlinks you can click instead of having to type the commands yourself (might be on by default in latest versions):

```text
.prefer_dml 1
```

## `SOSEX` commands

Build an index heap and make searching in the heap faster (takes "some" time):

```text
!bhi
```

List the content of the finalization queue:

```text
!finq
```

Freachable queue:

```text
!frq
```

Detect deadlocks:

```text
!dlk
```

Displays the fields of an object or type, optionally recursively:

```text
!mdt address
```

## Analysing managed memory leak

Get all the objects in the managed heaps. Bigger objects are at the bottom:

```text
!dumpheap -stat
```

Once you identified a problematic type:

```text
!dumpheap -type Full.Namespace.Type
```

Seee managed heaps:

```text
!eeheap -gc
```

## Unmanaged memory

Summary of memory by types:

```text
!address -summary
```

## Working with exceptions

Find all the exceptions on the heap:

```text
!dumpheap -type Exception -stat
```

Find the addresses of this exception:

```text
!dumpheap -type System.Threading.ThreadAbortException
```

Print exception using the address:

```text
!pe 0x01c601ac
```

See all exceptions of dump:

```text
!dumpallexceptions or !dae or !dumpheap -type Exception -stat
```

## Analyzing the dump on another machine

You'll need to get the following `DLL`s from the machine where the dump was taken:

- `mscordacwks.dll`
- `SOS.dll`
- `clr.dll`

They're located in the proper version of the `.NET framework`: `C:\Windows\Microsoft.NET\`. [Debugging Managed Code Using the Windows Debugger][locating-dlls] has a detailed guide.

## References

- [CodeProject - A WinDbg Tutorial][code-project-win-dbg-tutorial]
- [Tess Ferrandez - New commands in SOS for .NET 4.0][new-commands-sos]
- [SO - `WinDbg` symbols resolution][so-windbg-symbols-resolution]
- [kb - Troubleshooting ASP.NET using WinDbg and the SOS extension][kb-troubleshooting-asp-net]
- [SO - Starting to learn `WinDbg`][so-learn-win-dbg]
- [SO - Why psscor4 command will not run][so-why-psscor4-not-run]

## Books

- [Advanced .NET Debugging][book-advanced-not-debugging]

[proc-dump]: https://docs.microsoft.com/en-us/sysinternals/downloads/procdump
[sysinternals]: https://docs.microsoft.com/en-us/sysinternals/
[windows-development-kit]: https://msdn.microsoft.com/en-us/windows/hardware/hh852365.aspx
[win-dbg-store]: https://www.microsoft.com/en-au/store/p/windbg-preview/9pgjgd53tn86
[psscor4]: http://www.microsoft.com/download/en/details.aspx?id=21255
[sosex-32]: http://www.stevestechspot.com/downloads/sosex_32.zip
[sosex-64]: http://www.stevestechspot.com/downloads/sosex_64.zip
[code-project-win-dbg-tutorial]: http://www.codeproject.com/Articles/6084/Windows-Debuggers-Part-1-A-WinDbg-Tutorial
[locating-dlls]: https://msdn.microsoft.com/en-us/library/windows/hardware/ff540665(v=vs.85).aspx
[new-commands-sos]: http://blogs.msdn.com/b/tess/archive/2010/03/01/new-commands-in-sos-for-net-4-0-part-1.aspx
[so-windbg-symbols-resolution]: http://stackoverflow.com/questions/471733/windbg-symbol-resolution
[kb-troubleshooting-asp-net]: https://support.microsoft.com/en-us/help/892277/troubleshooting-asp-net-using-windbg-and-the-sos-extension
[so-learn-win-dbg]: https://stackoverflow.com/questions/138334/starting-to-learn-windbg
[so-why-psscor4-not-run]: https://stackoverflow.com/questions/25980945/why-psscor4-command-will-not-run
[book-advanced-not-debugging]: https://www.amazon.com/Advanced-NET-Debugging-Mario-Hewardt/dp/0321578899/
