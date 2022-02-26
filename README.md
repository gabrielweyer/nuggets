# Nuggets

This is where I record the tips, tricks and tools (free unless indicated otherwise :moneybag:) I've accumulated over the years.

I'm also shamelessly promoting some of my projects that nobody else is using (indicated with :trollface:)

## Tips and tricks

- :trollface: [Cake build][cake-build] - demonstrate a basic build of a `.NET` `NuGet` package using [Cake][cake]
- [Cake Intellisense](docs/cake-intellisense/README.md) - Intellisense for `Cake` in `Visual Studio Code`
- [Git][git-tutorial] - getting started with `Git` on `Windows`
- [Markdown][markdown-tutorial] - writing nice `Markdown`
- [ngrok][ngrok-tutorial] - expose a local server behind a `NAT` or firewall to the internet
- [PowerShell][powershell-tutorial] - pretend you know `PowerShell`
- [Splunk](docs/splunk/README.md) - run `Splunk` locally
- [SSH key pair](docs/ssh-key-pair/README.md) - generate / import a `SSH` key pair
- [TLS certificate](docs/tls/README.md) - generate a `TLS` server certificate on `Windows` and `macOS`
- [Visual Studio Code][vs-code-tutorial] - `Visual Studio Code` configuration and extensions
- [WinDbg][windbg-tutorial] - a brief guide (i.e. you are on your own)
- [WireMock][wiremock-tutorial] - mock `HTTP` server

## Practices

- `.NET`
  - [Coding convention](docs/dotnet/coding-convention/README.md) - easily enforceable `.NET` coding convention
  - [Layout](docs/dotnet/layout/README.md) - layout of a `.NET` project
- [Code review](docs/code-review/README.md) - guidelines for valuable code reviews
- [Documentation](docs/documentation/README.md) - help your future self
- [Logging](docs/logging/README.md) - an insider guide
- [Security](docs/security/README.md) - it doesn't matter until it does
- [The way we work](docs/the-way-we-work/README.md) - agree as a team on the importance of each task

## ASP.NET Core and Angular cookbook

- [Mitigate CSRF](docs/aspnet-core/csrf/README.md)
- [SPA routing](docs/aspnet-core/spa-routing/README.md)

## Instant nuggets

### Clear HSTS in Chrome

Navigate to `chrome://net-internals/#hsts`

## Software for developers on Windows

- [Azure Storage Explorer][azure-storage-explorer] - Manage `Azure Storage Accounts` (`Windows`, `macOS` and `Linux`)
- [dotPeek][dot-peek] - Decompiler (Windows)
  - [Navigate to compiled source][dot-peek-navigate-compiled] when used with `ReSharper`
  - [Symbol server][dot-peek-symbol-server]
- [Fiddler][fiddler] - `HTTP` debugging proxy server (`Windows`)
  - Requires an **email address**
  - :moneybag: **Buy** the book [Debugging with Fiddler, Second Edition][debugging-with-fiddler] by Eric Lawrence (the creator of `Fiddler`)
- [Git][git] - Distributed version control system (`Windows`, `macOS` and `Linux`)
  - I wrote a `Git` [tutorial][git-tutorial]
- [GraphiQL][graphi-ql] - A graphical interactive in-browser `GraphQL` `IDE` (`Windows`, `macOS` and `Linux`)
- [LINQPad][linqpad] - Instantly test any `C#`/`F#`/`VB` snippet or program (`Windows`)
  - :moneybag: I highly recommend the **paid** [Developer Version][linqpad-developer] which adds `NuGet` integration (packages can still be restored in the free and pro editions)
  - `LINQPad` is maintained by Joseph Albahari an independent software developer
- [MailHog][mail-hog] - email testing tool for developers (`Windows`, `macOS` and `Linux`)
- [MSBuildStructuredLog][ms-build-structured-log] - A logger for `MSBuild` that records a structured representation of executed targets, tasks, property and item values (`Windows`)
- [ngrok][ngrok] - Expose a local server behind a `NAT` or firewall to the internet (`Windows`, `macOS` and `Linux`)
  - I wrote a [tutorial][ngrok-tutorial] for `ngrok`
- [NuGet Package Explorer][nuget-package-explorer] - Create, update and deploy `Nuget` packages with a `GUI` (`Windows`)
- [Log Parser][logparser] - `CLI` mainly used to query `IIS` logs (`Windows`)
- [Open Broadcaster Software][open-broadcaster-software] - Free and open source software for video recording and live streaming (`Windows`, `macOS` and `Linux`)
- [P4Merge][p4-merge] - Merge tool and diff tool (`Windows`, `macOS` and `Linux`)
  - I'm using it as a `merge.tool` and `diff.tool` in `Git` and wrote a [tutorial][p4-merge-tutorial] on how to configure it
- [Paint.NET][paint-dotnet] - image and photo editing (`Windows`)
  - :moneybag: Buy it on the [Windows Store][paint-dotnet-store] to support `Paint.NET`
- [PerfView][perfview] - CPU and memory performance-analysis tool (`Windows`)
- [Postman][postman] - A graphical `HTTP` client (`Windows`, `macOS` and `Linux`)
- :moneybag: [ReSharper Ultimate][resharper-ultimate] - **Paid** extension for `Visual Studio`. Find and fix errors and code smells; navigate and refactor; run unit tests (`Windows`)
  - Includes:
    - [dotTrace][dot-trace] - performance profiling
    - [dotMemory][dot-memory] - memory profiling
- :moneybag: [Rider][rider] - **Paid** cross-platform `.NET` `IDE` (`Windows`, `macOS` and `Linux`)
  - Replaced `Visual Studio` as my `IDE` of choice
- [ScreenToGif][screen-to-gif] - Quick and small screen recorder (`Windows`)
  - This is what I use on my [blog][blog]
- [Service Bus Explorer][service-bus-explorer] - Connect to a Service Bus namespace and administer messaging entities (`Windows`)
- [Sysinternals][sysinternals] - Manage, troubleshoot and diagnose your `Windows` systems and applications (`Windows`)
  - Most commonly used utilities:
    - [Autoruns][autoruns] - Shows what programs are configured to startup automatically when your system boots and you login
    - [ProcDump][proc-dump] - Process dump utility
    - [Process Explorer][process-explorer] - List currently active processes
    - [Process Monitor][procmon] - Shows real-time file system, registry and process/thread activity
- [Visual Studio Code][visual-studio-code] - Editor (`Windows`, `macOS` and `Linux`)
  - My editor of choice to edit markdown, `csproj`, `Cake build`... files
  - Read my [guide][vs-code-tutorial]
- [WinDbg][windbg] - The `Windows` Debugger (`Windows`)
  - For the rare occasions when you need to go thermonuclear
  - Also available in preview in the [store][windbg-store]
  - I wrote a *succint* [tutorial][windbg-tutorial] for `WinDbg`
- [WinDirStat][win-dir-stat] - Disk usage statistics viewer (`Windows`)
- [Windows Magnifier][windows-magnifier] - Magnifier makes part or all of your screen bigger so you can see words and images better (`Windows`)
- [WireMock][wiremock] - Mock `HTTP` server (`Windows`, `macOS` and `Linux`)
  - I wrote a [tutorial][wiremock-tutorial] for `WireMock`
- [Windows Subsystem for Linux][wsl] - Lets developers run `Linux` environments - including most command-line tools, utilities, and applications - directly on `Windows`, unmodified, without the overhead of a virtual machine (`Windows`)

## .NET libraries

Yes I know they're all mine. I might add some real ones at some point.

- :trollface: [Unsupported Types][unsupported-notes] - `Azure Table storage` supports a limited set of data types (namely `byte[]`, `bool`, `DateTime`, `double`, `Guid`, `int`, `long` and `string`). `Unsupported Types` allows to store unsupported data types

[cake-build]: https://github.com/gabrielweyer/cake-build
[cake]: https://cakebuild.net/
[ngrok-tutorial]: docs/ngrok/README.md
[wiremock-tutorial]: docs/wiremock/README.md
[azure-storage-explorer]: https://azure.microsoft.com/en-au/features/storage-explorer/
[dot-peek]: https://www.jetbrains.com/decompiler/
[fiddler]: https://www.telerik.com/fiddler
[debugging-with-fiddler]: https://gumroad.com/l/dwf2/
[dot-peek-symbol-server]: https://www.jetbrains.com/help/decompiler/Using_product_as_a_Symbol_Server.html
[dot-peek-navigate-compiled]: https://www.jetbrains.com/help/decompiler/Navigation_and_Search__Navigating_to_External_Sources.html
[git]: https://git-scm.com/downloads
[graphi-ql]: https://github.com/graphql/graphiql
[linqpad]: https://www.linqpad.net/
[linqpad-developer]: https://www.linqpad.net/Purchase.aspx
[nuget-package-explorer]: https://github.com/NuGetPackageExplorer/NuGetPackageExplorer
[ngrok]: https://ngrok.com/
[p4-merge]: https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge
[postman]: https://www.getpostman.com/
[resharper-ultimate]: https://www.jetbrains.com/dotnet/
[dot-trace]: https://www.jetbrains.com/help/profiler/Introduction.html
[dot-memory]: https://www.jetbrains.com/help/dotmemory/Introduction.html
[rider]: https://www.jetbrains.com/rider/
[screen-to-gif]: http://www.screentogif.com/
[blog]: https://gabrielweyer.net/
[sysinternals]: https://docs.microsoft.com/en-us/sysinternals/
[autoruns]: https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns
[procmon]: https://docs.microsoft.com/en-us/sysinternals/downloads/procmon
[process-explorer]: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
[proc-dump]: https://docs.microsoft.com/en-us/sysinternals/downloads/procdump
[visual-studio-code]: https://code.visualstudio.com/
[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[editor-config]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[windbg]: https://developer.microsoft.com/en-us/windows/hardware/download-windbg
[windbg-store]: https://www.microsoft.com/en-au/store/p/windbg-preview/9pgjgd53tn86
[win-dir-stat]: https://windirstat.net/
[wiremock]: http://wiremock.org/
[wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[git-tutorial]: docs/git/README.md
[ms-build-structured-log]: https://github.com/KirillOsenkov/MSBuildStructuredLog
[unsupported-notes]: https://github.com/gabrielweyer/unsupported-types
[p4-merge-tutorial]: docs/git/README.md#difftool-and-mergetool
[windbg-tutorial]: docs/windbg/README.md
[vs-code-tutorial]: docs/vs-code/README.md
[service-bus-explorer]: https://github.com/paolosalvatori/ServiceBusExplorer
[windows-magnifier]: https://support.microsoft.com/en-au/help/11542/windows-use-magnifier
[open-broadcaster-software]: https://obsproject.com/
[perfview]: https://github.com/Microsoft/perfview
[logparser]: https://www.microsoft.com/en-us/download/details.aspx?id=24659
[paint-dotnet]: https://www.getpaint.net/
[paint-dotnet-store]: https://www.microsoft.com/store/apps/9NBHCS1LX4R0?ocid=badge
[markdown-tutorial]: docs/markdown/README.md
[mail-hog]: https://github.com/mailhog/MailHog
[powershell-tutorial]: docs/powershell/README.md
