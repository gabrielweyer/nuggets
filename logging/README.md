# Logging, an insider guide

Use **structured logging**. In the `.NET` ecosystem the library I recommend is [Serilog][serilog].

This guide is mostly paraphrasing the excellent writing of [Nicholas Blumhardt][nicholas-blumhardt] as I wanted to have everything in a single place.

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

- Don't attach your debugger when developping, logging events should be sufficient. This will allow you to increase the quality of logging over time.

## Message Template Recommendations

**Fluent Style Guideline** - good events use the names of properties as content within the message. This improves readability and makes events more compact.

```csharp
Log.Warning("Disk quota {Quota} MB exceeded by {User}", quota, user);
```

**Sentences vs. fragments** - log event messages are fragments, not sentences; avoid a trailing period/full stop when possible.

**Templates vs. messages** - `Serilog` events have a message template associated, _not_ a message. Treating the string parameter to log methods as a message, as in the case below, will degrade performance and consume cache memory.

```csharp
// Don't:
Log.Information("The time is " + DateTime.Now);
```

Instead, _always_ use template properties to include variables in messages:

```csharp
// Do:
Log.Information("The time is {Now}", DateTime.Now);
```

**Property Naming** - Property names should use `PascalCase`.

## Log Event Levels

What do they mean?

1. **Verbose** - tracing information and debugging minutiae; generally only switched on in unusual situations
    - Might log `PII`
1. **Debug** - internal control flow and diagnostic state dumps to facilitate pinpointing of recognised problems
1. **Information** - events of interest or that have relevance to outside observers; the default enabled minimum logging level
1. **Warning** - indicators of possible issues or service/functionality degradation
1. **Error** - indicating a failure within the application or connected system
1. **Fatal** - critical errors causing complete failure of the application

## Recommended enrichers

- [Serilog.Exceptions][enricher-exceptions]
- [Serilog.Enrichers.Demystify][enricher-demystify]

## References

- [Serilog tutorial][serilog-tutorial]
- [Structured logging concepts in .NET][structured-logging-dotnet]
- [Writing Log Events][writing-log-events]
- [Serilog ASP.NET Core quick start template][serilog-aspnet-core-guide]
- [Sample ASP.NET Core application using Serilog and Application Insights][serilog-aspnet-core-app-insights]

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
