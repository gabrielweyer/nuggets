# SPA routing

I like separating the `SPA` and `API` codebase (they could still live in the same repository but in different directories). If you do end up deploying the `SPA` in the `wwwroot/` directory of the `API`

```csharp
public class SpaRoutingMiddleware
{
    private readonly RequestDelegate _next;

    public SpaRoutingMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public Task InvokeAsync(HttpContext context)
    {
        if (IsGetMethod(context) && !IsApiPath(context) && !HasExtension(context))
        {
            context.Request.Path = "/index.html";
        }

        return _next(context);
    }

    private static bool IsGetMethod(HttpContext context)
    {
        return context.Request.Method == HttpMethods.Get;
    }

    private static bool IsApiPath(HttpContext context)
    {
        return context.Request.Path.StartsWithSegments("/api");
    }

    private static bool HasExtension(HttpContext context)
    {
        if (!context.Request.Path.HasValue)
            return false;

        var startIndex = context.Request.Path.Value.LastIndexOf('.');

        return startIndex >= 0;
    }
}
```
