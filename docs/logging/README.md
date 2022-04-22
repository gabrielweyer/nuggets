# Logging, an insider guide

Use **structured logging**. When using .NET / .NET5+ I recommend using the [built-in logging providers][dotnet-logging]. If you're using the `.NET` full framework, the library I recommend is [Serilog][serilog].

This guide is mostly paraphrasing the excellent writing of [Nicholas Blumhardt][nicholas-blumhardt] as I wanted to have everything in a single place.

## Contents

- [High level guidance](#high-level-guidance)
- [Message Template](#message-template)
- [Event Levels](#event-levels)
- [Exceptions](#exceptions)

## High level guidance

- Don't attach your debugger when developping, logging events should be sufficient. This will allow you to increase the quality of logging over time
- Use a [logging provider][logging-provider] that supports structured events
  - If you're at least partially hosting in Azure, I recommend using the [Application Insights provider][application-insights-provider]
- Associate log events with a build version (I tend to use [InformationalVersion][informational-version] as it doesn't have technical limitations). This comes in handy when tracing back an `Exception` to a specific version of the code. I also record additional metadata:
  - `Application Name` (i.e. `CatsApi`, `DogsWorker`...): great to restricts events to a single app when querying
  - `Environment`: `local`, `uat`, `prod`...
  - `Host` (i.e. `RD00155DF084AD`): sometimes containers / VMs do go rogue
- Correlate events across system boundaries (via a `CorrelationId` for example)
  - That includes queue messages
  - This comes out of the box with Application Insights
- Use centralized logging, all your systems should be logging in one place
  - Prefer a service rather than something you're hosting yourself
  - If you host yourself, don't use the same storage for your production data and your logs
- Don't repeat the same property over and over again in a unit of work. Instead use a [log scope][log-scope]

```csharp
// Don't:
_l.LogInformation("[{TransactionId}] - Processing...", transactionId, ...);
```

```csharp
// Do:
using(_l.BeginScope(new Dictionary<string, object> {["TransactionId"] = transactionId}))
{
    _l.LogInformation("Processing...", ...);
}
```

- Consider retention
  - For audit purpose
  - Typical support incident period
- Don't log beginning / end of functions / requests
  - Don't use logging for performance timing

## Message Template

**Fluent Style Guideline** - good events use the names of properties as content within the message. This improves readability and makes events more compact.

```csharp
_l.LogWarning("Disk quota {DiskQuota} MB exceeded by {UserId}", quota, userId);
```

**Sentences vs. fragments** - log event messages are fragments, not sentences; avoid a trailing period/full stop when possible.

**Templates vs. messages** - Log events have a message template associated, _not_ a message. Treating the string parameter to log methods as a message, as in the case below, will hamper your querying abilities.

```csharp
// Don't:
_l.LogInformation($"Deleted user {userId}");
```

Instead, _always_ use template properties to include variables in messages:

```csharp
// Do:
_l.LogInformation("Deleted user {UserId}", userId);
```

**Property Naming** - Property names should use `PascalCase`. Avoid generic property names as they'll be harder to query, a good rule of thumb is that the name should be meaningful when taken outside of context.

| Avoid        | Prefer                                |
| ------------ | ------------------------------------- |
| `{Uri}`      | `{PaymentGatewayUri}`                 |
| `{Id}`       | `{AppointmentId}`                     |
| `{Revision}` | `{SpaceStationBlueprintRevision}`     |
| `{Endpoint}` | `{DataProtectionBlobStorageEndpoint}` |
| `{Type}`     | `{SapMessageType}`                    |
| `{Version}`  | `{DesignDocumentVersion}`             |

## Event Levels

What do they mean?

1. **Trace** - very low-level debugging/internal information (might log Personally Identifiable Information)
    - These will be logged to Application Insights Live Metrics
1. **Debug** - low level, control logic, diagnostic information (**how and why**)
1. **Information** - non "internals" information / black box (**not how but what**)
1. **Warning** - possible issues or service/functionality degradation
1. **Error** - unexpected failure within the application or connected systems
1. **Critical** - critical errors causing complete failure of the application

```csharp
_l.LogTrace("Calculated {CheckDigit} for {CardNumber}", check, card);
_l.LogDebug("Applied VIP discount for {CustomerId}", customerId);
_l.LogInformation("New {OrderId} placed by {CustomerId}", orderId, customerId);
_l.LogWarning(exception, "Failed to save new {OrderId}, retrying in {SaveOrderRetryDelay} milliseconds", orderId, retryDelay);
_l.LogError("Failed to save new {OrderId}", orderId);
_l.LogCritical("Unhandled exception, application is terminating.");
```

## Exceptions

Log exception instances instead of the `Message` only. This gives us access to the stack trace and the inner exception(s).

Prefer:

```csharp
_l.LogError(ex, "Could not authorise payment for order {OrderId}", orderId);
```

Avoid:

```csharp
_l.LogError($"Failed to process, error: {ex.Message}");
```

When catching and swallowing an exception, consider logging the exception instead of a log message only. This will provided us more contact as to what went wrong.

Prefer:

```csharp
catch (Exception ex)
{
    _logger.LogWarning(ex, "Some action went wrong");
}
```

Avoid:

```csharp
catch
{
    _logger.LogWarning("Some action went wrong");
}
```

## References

- [Logging in .NET][dotnet-logging]
- [Serilog tutorial][serilog-tutorial]
- [Structured logging concepts in .NET][structured-logging-dotnet]
- [Writing Log Events][writing-log-events]
- [Modern Structured Logging With Serilog and Seq][pluralsight-serilog-seq] (requires a Pluralsight subscription)
- [code-with-engineering-playbook - Logging][code-with-engineering-playbook-logging]
- [code-with-engineering-playbook - Logs vs Metrics][code-with-engineering-playbook-logs-vs-metrics]

[code-with-engineering-playbook-logs-vs-metrics]: https://microsoft.github.io/code-with-engineering-playbook/observability/log-vs-metric.html
[code-with-engineering-playbook-logging]: https://microsoft.github.io/code-with-engineering-playbook/observability/pillars/logging.html
[serilog-tutorial]: https://blog.getseq.net/serilog-tutorial/
[structured-logging-dotnet]: https://nblumhardt.com/2016/06/structured-logging-concepts-in-net-series-1/
[writing-log-events]: https://github.com/serilog/serilog/wiki/Writing-Log-Events
[serilog]: https://serilog.net/
[nicholas-blumhardt]: https://twitter.com/nblumhardt
[pluralsight-serilog-seq]: https://www.pluralsight.com/courses/modern-structured-logging-serilog-seq
[informational-version]: https://docs.microsoft.com/en-us/dotnet/api/system.reflection.assemblyinformationalversionattribute.informationalversion?view=netcore-2.0#System_Reflection_AssemblyInformationalVersionAttribute_InformationalVersion
[dotnet-logging]: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-5.0
[logging-provider]: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-5.0#built-in-logging-providers-1
[application-insights-provider]: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-5.0#azure-application-insights-1
[log-scope]: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/logging/?view=aspnetcore-5.0#log-scopes-1
