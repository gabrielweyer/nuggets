# Nuggets

This is where I record the tips, tricks and tools (free unless indicated otherwise :moneybag:) I've accumulated over the years.

## Tips and tricks

- [Cake build][cake-build] - demonstrate a basic build of a `.NET` `NuGet` package using [Cake][cake]
- [Git][git-tutorial] - getting started with `Git` on `Windows`
- [Markdown][markdown-tutorial] - writing nice `Markdown`
- [PowerShell][powershell-tutorial] - pretend you know `PowerShell`
- [SSH key pair][ssh-key-pair-tutorial] - generate / import a `SSH` key pair
- [TLS certificate][tls-certificate-tutorial] - generate a `TLS` server certificate on `Windows` and `macOS`
- [Visual Studio Code][vs-code-guide] - `Visual Studio Code` configuration and extensions
- [WinDbg][windbg-tutorial] - a brief guide (i.e. you are on your own)
- [WireMock][wiremock-tutorial] - mock `HTTP` server

## Practices

- `.NET`
  - [Coding convention][dotnet-coding-conventions] - easily enforceable `.NET` coding convention
  - [Layout][dotnet-project-layout] - layout of a `.NET` project
- [Pull Request][pull-request-guidelines] - guidelines for easier to review Pull Requests
- [Code review][code-review-guidelines] - guidelines for valuable code reviews
- [Documentation][documentation-guidelines] - help your future self
- [Logging][logging-guidelines] - an insider guide
- [Security][security-guidelines] - it doesn't matter until it does
- [The way we work][the-way-we-work] - agree as a team on the importance of each task
- [SQL conventions][sql-conventions] - readable `SQL`
- Azure
  - [Azure naming conventions][azure-naming-conventions] - consistent Azure resources name
  - [Azure role assignment][azure-role-assignment] - hardcode assignment name for easier troubleshooting

## ASP.NET Core and Angular cookbook

- [Mitigate CSRF][mitigate-csrf]
- [SPA routing][spa-routing]

## Instant nuggets

### Finding Application Insights instance using Instrumentation Key

You found a lone binary on a forgotten server and are wondering where the telemetry is going to? Fear not, with the command below you'll be able to find the Application Insights resource in no time:

```powershell
Get-AzResource -ExpandProperties -ResourceType 'microsoft.insights/components' | Select -ExpandProperty Properties | Where InstrumentationKey -eq '{InstrumentationKey}' | Select Name
```

### Clear HSTS in Chrome

Navigate to `chrome://net-internals/#hsts`

## Software for developers on Windows

- [Azure Data Studio][azure-data-studio] - A lightweight replacement for SQL Server Management Studio (`Windows`, `macOS` and `Linux`)
- [Azure Storage Explorer][azure-storage-explorer] - Manage `Azure Storage Accounts` (`Windows`, `macOS` and `Linux`)
- [Azurite][azurite] - Azure storage emulator (`Windows`, `macOS` and `Linux`)
- [Cosmos DB emulator][cosmos-db-emulator] - Azure Cosmos DB emulator (`Windows`)
- [dotPeek][dot-peek] - Decompiler (`Windows`)
  - [Navigate to compiled source][dot-peek-navigate-compiled] when used with `ReSharper`
  - [Symbol server][dot-peek-symbol-server]
- :moneybag: [dotUltimate][dotultimate] - a **paid** suite of .NET tools
  - Includes:
    - [dotMemory][dotmemory] - memory profiling
    - [dotTrace][dottrace] - performance profiling
    - [ReSharper][resharper] - extension for `Visual Studio`. Find and fix errors and code smells; navigate and refactor; run unit tests (`Windows`)
    - [Rider][rider] - cross-platform `.NET` `IDE` (`Windows`, `macOS` and `Linux`), replaced `Visual Studio` as my `IDE` of choice
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
- [NuGet Package Explorer][nuget-package-explorer] - Explore the content of a `NuGet` package (`Windows`)
- [Log Parser][logparser] - `CLI` mainly used to query `IIS` logs (`Windows`)
- [Open Broadcaster Software][open-broadcaster-software] - Free and open source software for video recording and live streaming (`Windows`, `macOS` and `Linux`)
- [P4Merge][p4-merge] - Merge tool and diff tool (`Windows`, `macOS` and `Linux`)
  - I'm using it as a `merge.tool` and `diff.tool` in `Git` and wrote a [tutorial][p4-merge-tutorial] on how to configure it
- [Paint.NET][paint-dotnet] - image and photo editing (`Windows`)
  - :moneybag: Buy it on the [Windows Store][paint-dotnet-store] to support `Paint.NET`
- [PerfView][perfview] - CPU and memory performance-analysis tool (`Windows`)
- [Postman][postman] - A graphical `HTTP` client (`Windows`, `macOS` and `Linux`)
- [RegExr][regexr] - A website to test Regular Expressions
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
  - Read my [guide][vs-code-guide]
- [WinDbg][windbg] - The `Windows` Debugger (`Windows`)
  - For the rare occasions when you need to go thermonuclear
  - Also available in preview in the [store][windbg-store]
  - I wrote a *succint* [tutorial][windbg-tutorial] for `WinDbg`
- [WinDirStat][win-dir-stat] - Disk usage statistics viewer (`Windows`)
- [Windows Magnifier][windows-magnifier] - Magnifier makes part or all of your screen bigger so you can see words and images better (`Windows`)
- [WireMock][wiremock] - Mock `HTTP` server (`Windows`, `macOS` and `Linux`)
  - I wrote a [tutorial][wiremock-tutorial] for `WireMock`
- [Windows Subsystem for Linux][wsl] - Lets developers run `Linux` environments - including most command-line tools, utilities, and applications - directly on `Windows`, unmodified, without the overhead of a virtual machine (`Windows`)
- [Windows Terminal][windows-terminal] - a modern terminal for Windows (`Windows`)

## .NET libraries

- [Fluent Assertion][fluent-assertions] assertions for automated tests
- [FluentValidation][fluentvalidation] extensible validation library

[cake-build]: https://github.com/gabrielweyer/cake-build
[cake]: https://cakebuild.net/
[wiremock-tutorial]: docs/wiremock/README.md
[azure-storage-explorer]: https://azure.microsoft.com/en-au/features/storage-explorer/
[dot-peek]: https://www.jetbrains.com/decompiler/
[fiddler]: https://www.telerik.com/fiddler
[debugging-with-fiddler]: https://ericlaw.gumroad.com/l/dwf2
[dot-peek-symbol-server]: https://www.jetbrains.com/help/decompiler/Using_product_as_a_Symbol_Server.html
[dot-peek-navigate-compiled]: https://www.jetbrains.com/help/decompiler/Navigation_and_Search__Navigating_to_External_Sources.html
[git]: https://git-scm.com/downloads
[graphi-ql]: https://github.com/graphql/graphiql
[linqpad]: https://www.linqpad.net/
[linqpad-developer]: https://www.linqpad.net/Purchase.aspx
[nuget-package-explorer]: https://github.com/NuGetPackageExplorer/NuGetPackageExplorer
[p4-merge]: https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge
[postman]: https://www.getpostman.com/
[dotultimate]: https://www.jetbrains.com/dotnet/
[dottrace]: https://www.jetbrains.com/help/profiler/Introduction.html
[dotmemory]: https://www.jetbrains.com/help/dotmemory/Introduction.html
[rider]: https://www.jetbrains.com/rider/
[screen-to-gif]: https://www.screentogif.com/
[blog]: https://gabrielweyer.net/
[sysinternals]: https://docs.microsoft.com/en-us/sysinternals/
[autoruns]: https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns
[procmon]: https://docs.microsoft.com/en-us/sysinternals/downloads/procmon
[process-explorer]: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
[proc-dump]: https://docs.microsoft.com/en-us/sysinternals/downloads/procdump
[visual-studio-code]: https://code.visualstudio.com/
[windbg]: https://docs.microsoft.com/en-au/windows-hardware/drivers/debugger/debugger-download-tools
[windbg-store]: https://www.microsoft.com/en-au/store/p/windbg-preview/9pgjgd53tn86
[win-dir-stat]: https://windirstat.net/
[wiremock]: https://wiremock.org/
[wsl]: https://docs.microsoft.com/en-us/windows/wsl/install
[git-tutorial]: docs/git/README.md
[ms-build-structured-log]: https://github.com/KirillOsenkov/MSBuildStructuredLog
[p4-merge-tutorial]: docs/git/README.md#difftool-and-mergetool
[windbg-tutorial]: docs/windbg/README.md
[vs-code-guide]: docs/vs-code/README.md
[service-bus-explorer]: https://github.com/paolosalvatori/ServiceBusExplorer
[windows-magnifier]: https://support.microsoft.com/en-au/windows/use-magnifier-to-make-things-on-the-screen-easier-to-see-414948ba-8b1c-d3bd-8615-0e5e32204198
[open-broadcaster-software]: https://obsproject.com/
[perfview]: https://github.com/Microsoft/perfview
[logparser]: https://www.microsoft.com/en-us/download/details.aspx?id=24659
[paint-dotnet]: https://www.getpaint.net/
[paint-dotnet-store]: https://www.microsoft.com/store/apps/9NBHCS1LX4R0?ocid=badge
[markdown-tutorial]: docs/markdown/README.md
[mail-hog]: https://github.com/mailhog/MailHog
[powershell-tutorial]: docs/powershell/README.md
[fluent-assertions]: https://fluentassertions.com/
[fluentvalidation]: https://fluentvalidation.net/
[resharper]: https://www.jetbrains.com/resharper/
[pull-request-guidelines]: docs/code-review/README.md
[ssh-key-pair-tutorial]: docs/ssh-key-pair/README.md
[tls-certificate-tutorial]: docs/tls/README.md
[dotnet-coding-conventions]: docs/dotnet/coding-convention/README.md
[dotnet-project-layout]: docs/dotnet/layout/README.md
[code-review-guidelines]: docs/code-review/README.md
[documentation-guidelines]: docs/documentation/README.md
[logging-guidelines]: docs/logging/README.md
[security-guidelines]: docs/security/README.md
[the-way-we-work]: docs/the-way-we-work/README.md
[mitigate-csrf]: docs/aspnet-core/csrf/README.md
[spa-routing]: docs/aspnet-core/spa-routing/README.md
[sql-conventions]: docs/sql/README.md
[azure-naming-conventions]: docs/azure/naming/README.md
[azure-role-assignment]: docs/azure/role-assignment/README.md
[azure-data-studio]: https://azure.microsoft.com/en-au/services/developer-tools/data-studio/
[azurite]: https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=visual-studio-code
[cosmos-db-emulator]: https://docs.microsoft.com/en-us/azure/cosmos-db/local-emulator?tabs=ssl-netstd21
[windows-terminal]: https://www.microsoft.com/en-au/p/windows-terminal/9n0dx20hk701?rtc=1&activetab=pivot:overviewtab
[regexr]: https://regexr.com/
