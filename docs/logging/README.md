# Logging, an insider guide

Use **structured logging**. In the `.NET` ecosystem the library I recommend is [Serilog][serilog].

This guide is mostly paraphrasing the excellent writing of [Nicholas Blumhardt][nicholas-blumhardt] as I wanted to have everything in a single place.

## Contents

- [High level guidance](#high-level-guidance)
- [Message Template](#message-template)
- [Event Levels](#event-levels)
- [Enrichers](#enrichers)

## High level guidance

- Don't log beginning / end of functions / requests
  - Don't use logging for performance timing
- Use a [Sink][provided-sinks] that supports structured events
- Don't repeat the same property over and over again in a unit of work. Instead use a [scoped property][enrichment]

```csharp
// Don't:
Log.Information("[{TransactionId}] - Processing...", transactionId, ...);
```

```csharp
// Do:
using(LogContext.PushProperty("TransactionId", transactionId))
{
    Log.Information("Processing...", ...);
}
```

- Associate log events with a build version (I tend to use [InformationalVersion][informational-version] as it doesn't have technical limitations). This comes in handy when tracing back an `Exception` to a specific version of the code. I also record additional metadata:
  - `Application Name` (i.e `CatsApi`, `DogsWorker`...): great to restricts events to a single app when querying
  - `Host` (i.e `RD00155DF084AD`): sometimes containers / VMs do go rogue
- Don't attach your debugger when developping, logging events should be sufficient. This will allow you to increase the quality of logging over time
- Correlate events across system boundaries (via a `CorrelationId` for example)
  - That includes queue messages
- Use centralized logging, all your systems should be logging in one place
  - Prefer a service rather than something you have to manage yourself
- Don't use the same storage for your production data and your logs
- [Destructure][destructuring-operator] objects wisely
- Consider retention
  - For audit purpose
  - Typical support incident period

## Message Template

**Fluent Style Guideline** - good events use the names of properties as content within the message. This improves readability and makes events more compact.

```csharp
Log.Warning("Disk quota {DiskQuota} MB exceeded by {User}", quota, user);
```

**Sentences vs. fragments** - log event messages are fragments, not sentences; avoid a trailing period/full stop when possible.

**Templates vs. messages** - `Serilog` events have a message template associated, _not_ a message. Treating the string parameter to log methods as a message, as in the case below, will degrade performance and consume cache memory (this is true for `Seq` but it will also hamper your querying abilities in other logging backend).

```csharp
// Don't:
Log.Information("The time is " + DateTime.Now);
```

Instead, _always_ use template properties to include variables in messages:

```csharp
// Do:
Log.Information("The time is {Now}", DateTime.Now);
```

**Property Naming** - Property names should use `PascalCase`. Avoid generic property names as they'll be harder to query, a good rule of thumb is that the name should be meaningful when taken outside of context.

| Avoid | Prefer |
| - | - |
| `{Uri}` | `{PaymentGatewayUri}` |
| `{Id}` | `{AppointmentId}` |
| `{Revision}` | `{SpaceStationBlueprintRevision}` |
| `{Endpoint}` | `{BlobStorageEndpoint}` |
| `{Type}` | `{SapMessageType}` |
| `{Version}` | `{DesignDocumentVersion}` |

## Event Levels

What do they mean?

1. **Verbose** - very low-level debugging/internal information
    - Might log `PII`
1. **Debug** - low level, control logic, diagnostic information
1. **Information** - non "internals" information / black box (**not how but what**)
1. **Warning** - possible issues or service/functionality degradation
1. **Error** - unexpected failure within the application or connected systems
1. **Fatal** - critical errors causing complete failure of the application

```csharp
Log.Verbose("Calculated {CheckDigit} for {CardNumber}", check, card);
Log.Debug("Applying VIP discount for {Customer}", customer);
Log.Information("New {Order} placed by {Customer}", order, customer);
Log.Warning(exception, "Failed to save new {Order}, retrying in {Wait} milliseconds", order, retryDelay);
Log.Error("Failed to save new {Order}", order);
Log.Fatal("Unhandled exception, application is terminating.");
```

## Enrichers

- [Serilog.Exceptions][enricher-exceptions]
- [Serilog.Enrichers.Demystify][enricher-demystify]

## References

- [Serilog tutorial][serilog-tutorial]
- [Structured logging concepts in .NET][structured-logging-dotnet]
- [Writing Log Events][writing-log-events]
- [Serilog ASP.NET Core quick start template][serilog-aspnet-core-guide]
- [Sample ASP.NET Core application using Serilog and Application Insights][serilog-aspnet-core-app-insights]
- [Modern Structured Logging With Serilog and Seq][pluralsight-serilog-seq] (requires a Pluralsight subscription)

[serilog-tutorial]: https://blog.getseq.net/serilog-tutorial/
[structured-logging-dotnet]: https://nblumhardt.com/2016/06/structured-logging-concepts-in-net-series-1/
[writing-log-events]: https://github.com/serilog/serilog/wiki/Writing-Log-Events
[serilog]: https://serilog.net/
[provided-sinks]: https://github.com/serilog/serilog/wiki/Provided-Sinks
[enrichment]: https://github.com/serilog/serilog/wiki/Enrichment
[enricher-exceptions]: https://github.com/RehanSaeed/Serilog.Exceptions
[enricher-demystify]: https://github.com/nblumhardt/serilog-enrichers-demystify
[serilog-aspnet-core-guide]: serilog-aspnet-core/README.md
[serilog-aspnet-core-app-insights]: https://github.com/gabrielweyer/aspnet-core-app-insights
[nicholas-blumhardt]: https://twitter.com/nblumhardt
[destructuring-operator]: https://github.com/serilog/serilog/wiki/Structured-Data#preserving-object-structure
[pluralsight-serilog-seq]: https://www.pluralsight.com/courses/modern-structured-logging-serilog-seq
[informational-version]: https://docs.microsoft.com/en-us/dotnet/api/system.reflection.assemblyinformationalversionattribute.informationalversion?view=netcore-2.0#System_Reflection_AssemblyInformationalVersionAttribute_InformationalVersion
