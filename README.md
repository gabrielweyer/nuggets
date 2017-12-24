# Nuggets

This is where I record the tip, tricks and tools I've accumulated over the years.

- [Cake build][cake-build] - demonstrate a basic build of a `.NET Core` `NuGet` package using [Cake][cake]
- [ngrok][ngrok] - expose a local server behind a NAT or firewall to the internet.
- [Serilog ASP.NET Core quick start][serilog-aspnet-core] - configure `Serilog` in `ASP.NET Core` like a boss
- [VSTS Linux build agent][vsts-linux-agent] - provision a `Linux` `Docker` `VSTS` build agent with the `AWS CLI` capability.
  - Becoming less relevant since `VSTS` offers [Linux hosted agents][linux-hosted-agents] and `Amazon` released [AWS Tools for Microsoft Visual Studio Team Services][aws-tools].
- [WireMock][wire-mock] - mock HTTP server.

[linux-hosted-agents]: https://github.com/Microsoft/vsts-agent-docker/blob/master/ubuntu/16.04/standard/Dockerfile
[aws-tools]: https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-vsts-tools
[cake-build]: https://github.com/gabrielweyer/cake-build
[cake]: https://cakebuild.net/
[ngrok]: ngrok/ngrok.md
[serilog-aspnet-core]: serilog-aspnet-core/serilog-aspnet-core.md
[vsts-linux-agent]: https://github.com/gabrielweyer/vsts-linux-build-agent
[wire-mock]: wire-mock/wire-mock.md
