# Serilog quick start

## Add Nuget packages

```posh
dotnet add package Serilog
dotnet add package Serilog.AspNetCore
dotnet add package Serilog.Sinks.Console
dotnet add package Serilog.Settings.Configuration
dotnet add package Serilog.Enrichers.Demystify --version 0.1.0-dev-00011
```
## Create or modify `appsettings.json`

If there is an existing `appsettings.json`, delete the `Logging` section.

Then add:

```json
"Serilog": {
  "MinimumLevel": {
    "Default": "Verbose",
    "Override": {
      "Microsoft": "Information",
      "System": "Information"
    }
  }
}
```

## Add extension method

You can add it in the same file than `Program.cs` (this is the only place where it'll be used).

```csharp
internal static class ConfigurationRootExtensions
{
    internal static LogEventLevel GetLoggingLevel(this IConfigurationRoot configuration, string keyName, LogEventLevel defaultLevel = LogEventLevel.Warning)
    {
        try
        {
            return configuration.GetValue($"Serilog:{keyName}", LogEventLevel.Warning);
        }
        catch (Exception)
        {
            return defaultLevel;
        }
    }
}
```

## Modify Program.cs

Benefits:

- **Will log startup errors**
- Can inject different `Configuration` when testing (if you want to)
- Writes to the `Console` when running on `Kestrel` in `Development`

Turn the body of `BuildWebHost` into:

```csharp
var webHostBuilder = WebHost.CreateDefaultBuilder(args);

var contentRoot = webHostBuilder.GetSetting("contentRoot");
var environment = webHostBuilder.GetSetting("ENVIRONMENT");

var isDevelopment = EnvironmentName.Development.Equals(environment);

var configuration = new ConfigurationBuilder()
	.SetBasePath(contentRoot)
	.AddJsonFile("appsettings.json", false, false)
	.AddEnvironmentVariables()
	.Build();

var serilogLevel = configuration.GetLoggingLevel("MinimumLevel:Default");

var loggerConfiguration = new LoggerConfiguration()
	.ReadFrom.Configuration(configuration)
	.Enrich.WithDemystifiedStackTraces();

if (isDevelopment)
{
	loggerConfiguration = loggerConfiguration.WriteTo.LiterateConsole(serilogLevel);
}

var logger = loggerConfiguration.CreateLogger();

try
{
	logger.Information("Starting Host...");

	return webHostBuilder
		.UseStartup<Startup>()
		.UseConfiguration(configuration)
		.UseSerilog(logger, true)
		.Build();
}
catch (Exception ex)
{
	logger.Fatal(ex, "Host terminated unexpectedly");
	throw;
}
```
