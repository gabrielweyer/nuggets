# Nuggets

This is where I record the tip, tricks and tools I've accumulated over the years.

- [Cake build][cake-build] - demonstrate a basic build of a `.NET Core` `NuGet` package using [Cake][cake]
- [Git][git-tutotial] - Getting started with Git on Windows
- [ngrok][ngrok-tutorial] - expose a local server behind a NAT or firewall to the internet
- [Serilog ASP.NET Core quick start][serilog-aspnet-core] - configure `Serilog` in `ASP.NET Core` like a boss
- [VSTS Linux build agent][vsts-linux-agent] - provision a `Linux` `Docker` `VSTS` build agent with the `AWS CLI` capability
  - Becoming less relevant since `VSTS` offers [Linux hosted agents][linux-hosted-agents] and `Amazon` released [AWS Tools for Microsoft Visual Studio Team Services][aws-tools]
- [WireMock][wire-mock-tutorial] - mock HTTP server

## Software for developers on Windows

Those tools are free unless indicated otherwise.

- [Azure Storage Explorer][azure-storage-explorer] - Manage `Azure Storage Accounts` (Windows, macOS and Linux)
- [ConEmu][con-emu] - Windows console emulator with tabs (Windows)
- [Docker for Windows][docker-windows] - Containerization platform (Windows, macOS and Linux)
  - Requires Microsoft Windows 10 Professional or Enterprise 64-bit and Hyper-V
  - For unsupported OS you can use [Docker Toolbox][docker-toolbox] instead
- [dotPeek][dot-peek] - Decompiler (Windows)
  - [Navigate to compiled source][dot-peek-navigate-compiled] when used with ReSharper
  - [Symbol server][dot-peek-symbol-server]
- [Fiddler][fiddler] - HTTP debugging proxy server (Windows)
  - Requires an email address
  - Buy the book [Debugging with Fiddler, Second Edition][debugging-with-fiddler] by Eric Lawrence (the creator of Fiddler)
- [Git][git] - Distributed version control system (Windows, macOS and Linux)
  - [Git Credential Manager for Windows][git-credential-manager]
- [GraphiQL][graphi-ql] - A graphical interactive in-browser GraphQL IDE (Windows, macOS and Linux)
- [LINQPad][linq-pad] - Instantly test any C#/F#/VB snippet or program (Windows)
  - I highly recommend the **paid** [Developer Version][linq-pad-developer] which adds NuGet integration
  - LINQPad is maintained by Joseph Albahari an independent software developer
- [Microsoft Message Analyzer][microsoft-message-analyzer] - Capture, display, and analyze protocol messaging traffic (Windows)
  - [Operating Guide][microsoft-message-analyzer-operating-guide]
  - I covered Microsoft Message Analyzer in a [blog post][blog-netsh]
- [ngrok][ngrok] - Expose a local server behind a NAT or firewall to the internet (Windows, macOS and Linux)
  - I wrote a [tutorial][ngrok-tutorial] for ngrok
- [NuGet Package Explorer][nuget-package-explorer] - Create, update and deploy Nuget Packages with a GUI (Windows)
- [P4Merge][p4-merge] - Merge tool and diff tool (Windows, macOS and Linux)
  - I'm using it as a `merge.tool` and `diff.tool` in Git
- [Postman][postman] - A graphical HTTP Client (Windows, macOS and Linux)
- [ReSharper Ultimate][resharper-ultimate] - **Paid** extension for Visual Studio. Find and fix errors and code smells; navigate and refactor; run unit tests (Windows)
  - Includes:
    - [dotTrace][dot-trace] - performance profiling
    - [dotMemory][dot-memory] - memory profiling
- [Rider][rider] - **Paid** cross-platform .NET IDE (Windows, macOS and Linux)
  - Replaced Visual Studio as my IDE of choice
- [ScreenToGif][screen-to-gif] - Quick and small screen recorder (Windows)
  - This is what I use on my [blog][blog]
- [Sysinternals][sysinternals] - Manage, troubleshoot and diagnose your Windows systems and applications (Windows)
  - Most commonly used utilities:
    - [Process Monitor][procmon] - Shows real-time file system, Registry and process/thread activity
    - [Process Explorer][process-explorer] - List currently active processes
    - [ProcDump][proc-dump] - Process dump utility
- [Visual Studio Code][visual-studio-code] - Editor (Windows, macOS and Linux)
  - My editor of choice to edit markdown, `csproj`, Cake build... files
  - Recommended extensions: [markdownlint][markdownlint], [EditorConfig for VS Code][editor-config]
- [WinDbg][win-dbg] - The Windows Debugger (Windows)
  - For the rare occasions when you need to go thermonuclear
  - Also available in preview in the [store][win-dbg-store]
- [WinDirStat][win-dir-stat] - Disk usage statistics viewer (Windows)
- [WireMock][wire-mock] - Mock HTTP server (Windows, macOS and Linux)
  - I wrote a [tutorial][wire-mock-tutorial] for WireMock
- [Windows Subsystem for Linux][wsl] - Lets developers run Linux environments - including most command-line tools, utilities, and applications - directly on Windows, unmodified, without the overhead of a virtual machine (Windows)

[linux-hosted-agents]: https://github.com/Microsoft/vsts-agent-docker/blob/master/ubuntu/16.04/standard/Dockerfile
[aws-tools]: https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-vsts-tools
[cake-build]: https://github.com/gabrielweyer/cake-build
[cake]: https://cakebuild.net/
[ngrok-tutorial]: ngrok/ngrok.md
[serilog-aspnet-core]: serilog-aspnet-core/serilog-aspnet-core.md
[vsts-linux-agent]: https://github.com/gabrielweyer/vsts-linux-build-agent
[wire-mock-tutorial]: wire-mock/wire-mock.md
[azure-storage-explorer]: https://azure.microsoft.com/en-au/features/storage-explorer/
[con-emu]: https://conemu.github.io/
[docker-windows]: https://store.docker.com/editions/community/docker-ce-desktop-windows
[docker-toolbox]: https://docs.docker.com/toolbox/overview/
[dot-peek]: https://www.jetbrains.com/decompiler/
[fiddler]: https://www.telerik.com/fiddler
[debugging-with-fiddler]: https://gumroad.com/l/dwf2/
[dot-peek-symbol-server]: https://www.jetbrains.com/help/decompiler/Using_product_as_a_Symbol_Server.html
[dot-peek-navigate-compiled]: https://www.jetbrains.com/help/decompiler/Navigation_and_Search__Navigating_to_External_Sources.html
[git]: https://git-scm.com/downloads
[git-credential-manager]: https://github.com/Microsoft/Git-Credential-Manager-for-Windows
[graphi-ql]: https://github.com/graphql/graphiql
[linq-pad]: https://www.linqpad.net/
[linq-pad-developer]: https://www.linqpad.net/Purchase.aspx
[nuget-package-explorer]: https://github.com/NuGetPackageExplorer/NuGetPackageExplorer
[ngrok]: https://ngrok.com/
[p4-merge]: https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge
[postman]: https://www.getpostman.com/
[resharper-ultimate]: https://www.jetbrains.com/dotnet/
[dot-trace]: https://www.jetbrains.com/help/profiler/Introduction.html
[dot-memory]: https://www.jetbrains.com/help/dotmemory/Introduction.html
[rider]: https://www.jetbrains.com/rider/
[screen-to-gif]: http://www.screentogif.com/
[blog]: https://gabrielweyer.github.io/
[sysinternals]: https://docs.microsoft.com/en-us/sysinternals/
[procmon]: https://docs.microsoft.com/en-us/sysinternals/downloads/procmon
[process-explorer]: https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer
[proc-dump]: https://docs.microsoft.com/en-us/sysinternals/downloads/procdump
[visual-studio-code]: https://code.visualstudio.com/
[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[editor-config]: https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig
[win-dbg]: https://developer.microsoft.com/en-us/windows/hardware/download-windbg
[win-dbg-store]: https://www.microsoft.com/en-au/store/p/windbg-preview/9pgjgd53tn86
[win-dir-stat]: https://windirstat.net/
[wire-mock]: http://wiremock.org/
[microsoft-message-analyzer]: https://www.microsoft.com/en-au/download/details.aspx?id=44226
[microsoft-message-analyzer-operating-guide]: https://technet.microsoft.com/en-us/library/jj649776.aspx
[blog-netsh]: https://gabrielweyer.github.io/2016/07/16/capture-network-packets-with-netsh/
[wsl]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[git-tutotial]: git/git.md
