# WinDbg

`WinDbg` is a beast, this guide will barely touch the surface but hopefully it will be enough to get you started.

## Contents

- [Write a memory dump](#write-a-memory-dump)
- [Download and install WinDbg](#download-and-install-windbg)
- [Analysing the dump on another machine](#analysing-the-dump-on-another-machine)
- [Open a memory dump](#open-a-memory-dump)
  - [Configure the symbols](#configure-the-symbols)
  - [Configure the source](#configure-the-source)
- [Recommended extensions](#recommended-extensions)
- [Commands](#commands)
  - [WinDbg](#windbg-commands) / [SOS](#sos-commands) / [SOSEX](#sosex-commands) / [MEX](#mex-commands)
  - [Working with managed memory](#working-with-managed-memory)
  - [Working with unmanaged memory](#working-with-unmanaged-memory)
  - [Working with exceptions](#working-with-exceptions)
  - [Working with threads](#working-with-threads)
  - [Working with code](#working-with-code)
  - [Who is holding the lock](#who-is-holding-the-lock)
- [Troubleshooting](#troubleshooting)

### Guides

- [WinDbg Preview][windbg-preview-guide]
- [Write a memory dump in an Azure App Service](write-dump-azure-app-service.md)

## Write a memory dump

The first step is to write a **memory dump**. I recommend using [ProcDump][proc-dump] from [Sysinternals][sysinternals]. You can set up rules to write a dump when certain conditions are met (i.e. exception thrown, CPU usage, memory usage...). The common use case is to write a dump using a `PID`:

```posh
procdump64.exe -r -a -ma <process-id>
```

- `-ma`: write a 'Full' dump file
- `-r`: dump using a clone
- `-a`: avoid outage

:clipboard: you can use a process name instead of a `PID`:

```posh
procdump64.exe -ma <process-name>
```

:rotating_light: when running `ProcDump` for the first time you'll need to accept the `Sysinternals` license agreement:

```posh
procdump64.exe -accepteula -ma <process-id>
```

:rotating_light: if you decide to use something else don't forget you need a **full** dump (instead of a **mini** dump).

## Download and install `WinDbg`

You can get `WinDbg` by getting the `WinDbg Preview` from the store (`Windows 10 Anniversary Update` only) or installing the `Windows 10 SDK`.

### Store

If you're running `Windows 10 Anniversary Update` you can install `WinDbg Preview` from the [store][windbg-store]. I wrote a [guide][windbg-preview-guide] about `WinDbg Preview`.

### Windows 10 SDK

Download the [Windows 10 SDK][windows-10-sdk].

In the installation wizard, select `Debugging Tools for Windows` and clear all the other components.

![Debugging Tools for Windows](assets/debugging-tools-windows.png)

`WinDbg` comes in two flavours: `x86` and `x64`. Both will be installed, when loading a dump make sure you select the one matching the bitness of your process.

## Analysing the dump on another machine

You'll need to get the following `DLL`s from the machine where the dump was written:

- `mscordacwks.dll`
- `SOS.dll`

They're located in the proper version of the `.NET framework`: `C:\Windows\Microsoft.NET\`. [Debugging Managed Code Using the Windows Debugger][locating-dlls] has a detailed guide.

Once you've downloaded the two `DLL`s you need to load them in `WinDbg`:

- For `SOS`: `.load C:\path-to-dll\SOS.dll`
- For `mscordacwks`: `.cordll -lp C:\directory-in-which-mscordacwks-is-located`
  - Do not include `mscordacwks.dll` in the path (i.e. if the location is `C:\dlls\mscordacwks.dll` the command should be `.cordll -lp C:\dlls`)

## Open a memory dump

`File` -> `Open Crash Dump...`

When opening the dump `WinDbg` will display the following information:

![Open memory dump](assets/windbg-load-dump.png)

Ensure you're working with a **full** dump and that `sympath` is as expected.

## Configure the symbols

**sympath**: the location(s) where `WinDbg` will look for `symbols`.

Having `symbols` will make the debugging experience much nicer. When building, either publish your `PDB`s to a `symbols` server or store them as artifacts. Then when needed copy them to `C:\symbols\local` (or whatever you set your `sympath` to).

You can view the value of `sympath` by issuing the following command:

```text
.sympath
```

You can set `sympath` via a **setting**, **during the debugging session** or via an **environment variable**. If you want to know more, you can read [Symbol path for Windows debuggers][symbol-path-windows-debuggers].

### Setting

- Open the `File` menu -> Select `Symbol File Path ...`
- Enter the below in the textbox, select `Reload` and click `Ok`

```text
C:\symbols\local;srv*C:\symbols\microsoft*https://msdl.microsoft.com/download/symbols
```

`File` -> `Save Workspace` will persist your `sympath`!

### During the session

You can load the `symbols` during the session:

```text
.sympath C:\symbols\local;srv*C:\symbols\microsoft*https://msdl.microsoft.com/download/symbols
.reload
```

### Environment variable

- **Variable name**: `_NT_SYMBOL_PATH`
- **Variable value**: `C:\symbols\local;srv*C:\symbols\microsoft*https://msdl.microsoft.com/download/symbols`

## Configure the source

- Open the `File` menu -> Select `Source File Path ...`
- Enter the below in the textbox, select `Reload` and click `Ok`

```text
C:\symbols\source
```

`File` -> `Save Workspace` will persist your `srcpath`!

## Recommended extensions

`WinDbg` is a bit dry but luckily extensions provide nifty commands.

### SOS

Load the `CLR` debugging extensions. Informally known as [Son of Strike][so-son-of-strike].

#### Full framework

```text
.loadby sos clr
```

:clipboard: `SOS` has been superseded by `Psscor4` for the full framework (`.NET 4.0` and below).

#### `.NET Core`

```text
.loadby sos coreclr
```

### Psscor4

`Psscor4` is a superset of `SOS`. Most of the added functionality helps you identify issues in `ASP.NET`. `Psscor4` does **not** support:

- `.NET 4.5` and higher
- `.NET Core`

For these frameworks you'll have to stick with `SOS`.

Download [Psscor4][psscor4]. You need to "install" it, but it will actually extract it somewhere of your choosing. Extract it to a temporary folder and copy the `x64` / `x86` `DLL`s to their respective folders:

- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x64\winext`
- `C:\Program Files (x86)\Windows Kits\10\Debuggers\x86\winext`

If you can't find this path, look for `windbg.exe` (`where.exe /R C:\ windbg.exe`).

#### Load Psscor4

```text
.load psscor4
```

### SOSEX

My favourite and the masterpiece of Steve Johnson.

Download links:

- [x86][sosex-32]
- [x64][sosex-64]

Copy the `DLL`s in the same folder than `Psscor4`.

#### Load SOSEX

```text
.load sosex
```

### MEX

Download [MEX][mex].

#### Load MEX

```text
.load mex
```

## Commands

- regular commands (e.g.: `k`) debug processes
- dot commands (e.g.: `.sympath`)  control the debugger
- extension commands (e.g.: `!handle`) come from `WinDbg` extensions

### `WinDbg` commands

:star2: Get latest exception:

```text
!analyze -v
```

Objects per generation:

```text
!FinalizeQueue
```

List of drivers:

```text
lm t.lon
```

#### Shortcuts

- **Exiting current operation**: `Ctrl + Break key`
- **Focus textbox**: `ALT + 1`

#### Session settings

Will add hyperlinks you can click instead of having to type the commands yourself (might be on by default in latest versions):

```text
.prefer_dml 1
```

### `SOS` commands

:star2: List `SOS` commands

```text
!sos.help
```

### `SOSEX` commands

:star2: List `SOSEX` commands

```text
!sosex.help
```

:turtle: Build an index heap and make searching in the heap faster:

```text
!sosex.bhi
```

List the content of the finalization queue:

```text
!sosex.finq
```

Freachable queue:

```text
!sosex.frq
```

Detect deadlocks:

```text
!sosex.dlk
```

Displays the fields of an object or type, optionally recursively:

```text
!sosex.mdt address
```

### `MEX` commands

List `MEX` commands

```text
!mex.help
```

:star2: ASP.NET: short history of requests which have run and currently running requests

```text
!mex.aspxpagesext
```

## Working with managed memory

Get all the objects in the managed heaps. Bigger objects are at the bottom:

```text
!dumpheap -stat
```

Once you identified a problematic type:

```text
!dumpheap -type Full.Namespace.Type
```

What's keeping an object alive:

```text
!gcroot <address>
```

See managed heaps:

```text
!eeheap -gc
```

## Working with unmanaged memory

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
!mex.dumpallexceptions
# Or if you're lazy:
!mex.dae
# Or if you want to see all types having "Exception" in their name:
!dumpheap -type Exception -stat
```

## Working with threads

:star2: List managed threads with what they're currently doing

```text
!mex.mthreads
```

Alternatively you can use `!sos.threads`

The first column is the thread `ID` which then can be used for all the commands below (i.e. in this case we're interested in thread `142`).

See what a managed thread is doing:

```text
~142e !sos.CLRStack
```

See what an unmanaged thread is doing:

```text
~142k
```

Switch to thread:

```text
~142s
```

:star2: :turtle: Group threads by unique stacks

```text
!mex.us
```

This command is great to identify all the threads doing the same thing (and potentially being blocked at the same point).

## Working with code

Disassemble:

```text
!U \d <address>
```

Displays a disassembly around the current instruction with interleaved source, `IL` and `ASM` code:

```text
!sosex.mu <address>
```

## Who is holding the lock

```text
0:000> !syncblk
Index         SyncBlock MonitorHeld Recursion Owning Thread Info          SyncBlock Owner
   52 20ee3118          229         2 20fc6ba0 9628  42   0a13ee8c System.Object
# Abbreviated
```

The third column (`MonitorHeld`) indicates how many threads are trying to acquire the same lock. In this case it is `(229 - 1) / 2 = 114`. You can read more about it in this `SO` [answer][so-monitor-held].

## Troubleshooting

`WinDbg` errors can be a bit cryptic. In this section I say `no more!`

### SOS mismatch

You might get an error when trying to load `SOS`:

```text
0:000> .loadby sos clr
The call to LoadLibrary(D:\Windows\Microsoft.NET\Framework\v4.0.30319\sos) failed, Win32 error 0n126
    "The specified module could not be found."
Please check your debugger configuration and/or network access.
```

This dump has been written on an Azure Web App and the path is pointing to a hard-drive somewhere in the cloud.

- Download the `SOS.dll` from the folder included in the error (`D:\Windows\Microsoft.NET\Framework\v4.0.30319\` in this case)
- Load the `SOS.dll` using this command: `.load C:\path-to-dll\SOS.dll`

### mscordacwks mismatch

You can see which `mscordacwks.dll` is loaded:

```text
0:000> .cordll
CLR DLL status: Loaded DLL c:\symbols\mscordacwks_x86_x86_4.7.2563.00.dll\5A334E146eb000\mscordacwks_x86_x86_4.7.2563.00.dll
```

### Missing command

```text
0:000> !runaway2
No export runaway2 found
```

You need to load the extension containing this command. A quick Google will identify the name of the extension.

### Bitness mismatch

This is what happens when you open a `32-bit` memory dump with `WinDbg (X64)`:

```text
0:000> .load C:\dumps\SOS.dll
The call to LoadLibrary(C:\dumps\SOS.dll) failed, Win32 error 0n193
    "%1 is not a valid Win32 application."
Please check your debugger configuration and/or network access.
```

Use `WinDbg (X86)` instead.

### OutOfMemoryException

`System.ExecutionEngineException`, `System.StackOverflowException` and `System.OutOfMemoryException` are created as soon as the process starts. This means that you will always see them on the heap even if they haven't been thrown.

See [Why do I see ExecutionEngineException, StackOverflowException and OutOfMemoryException on the heap?][why-eee-soe-oom].

### Symbols resolution

If some of your symbols are not loading as expected you can turn on debugging messages when `WinDbg` attempts to load symbols:

```text
!sym noisy
```

Once you're done, don't forget to reset it to its initial state:

```text
!sym quiet
```

## Concepts

- [Address and Address Range Syntax][address-range-syntax]

## References

- [SO - WinDbg symbols resolution][so-windbg-symbols-resolution]
- [SO - Why Psscor4 command will not run][so-why-psscor4-not-run]
- [Pinpointing a Static GC Root with SOS][pinpointing-static-root]
- [Tess Ferrandez - New commands in SOS for .NET 4.0][new-commands-sos]

## Books

- [Advanced .NET Debugging][book-advanced-not-debugging]

[proc-dump]: https://docs.microsoft.com/en-us/sysinternals/downloads/procdump
[sysinternals]: https://docs.microsoft.com/en-us/sysinternals/
[windows-10-sdk]: https://developer.microsoft.com/en-US/windows/downloads/windows-10-sdk
[windbg-store]: https://www.microsoft.com/en-au/store/p/windbg-preview/9pgjgd53tn86
[psscor4]: http://www.microsoft.com/download/en/details.aspx?id=21255
[sosex-32]: http://www.stevestechspot.com/downloads/sosex_32.zip
[sosex-64]: http://www.stevestechspot.com/downloads/sosex_64.zip
[locating-dlls]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/debugging-managed-code
[new-commands-sos]: http://blogs.msdn.com/b/tess/archive/2010/03/01/new-commands-in-sos-for-net-4-0-part-1.aspx
[so-windbg-symbols-resolution]: http://stackoverflow.com/questions/471733/windbg-symbol-resolution
[so-why-psscor4-not-run]: https://stackoverflow.com/a/25982368/57369
[book-advanced-not-debugging]: https://www.amazon.com/Advanced-NET-Debugging-Mario-Hewardt/dp/0321578899/
[address-range-syntax]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/address-and-address-range-syntax
[pinpointing-static-root]: http://blogs.microsoft.co.il/sasha/2012/02/07/pinpointing-a-static-gc-root-with-sos/
[so-son-of-strike]: https://stackoverflow.com/a/21363245/57369
[symbol-path-windows-debuggers]: https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/symbol-path
[mex]: https://www.microsoft.com/en-us/download/details.aspx?id=53304
[so-monitor-held]: https://stackoverflow.com/a/2203085/57369
[why-eee-soe-oom]: https://blogs.msdn.microsoft.com/tess/2009/08/10/why-do-i-see-executionengineexception-stackoverflowexception-and-outofmemoryexception-on-the-heap-when-debugging-net-applications/
[windbg-preview-guide]: windbg-preview.md
