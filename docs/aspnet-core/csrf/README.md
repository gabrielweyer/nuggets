# Antiforgery with ASP.NET Core and Angular

If you use cookie-based authentication, then you are susceptible to `XSRF / CSRF`. The `ASP.NET Core` documentation has an [article][asp-net-core-anti-forgery] dedicated to preventing Cross-Site Request Forgery.

The goal of this guide is to demonstrate how to mitigate `CSRF` for a `SPA` using `Angular 6.x` and being the **only** consumer of an `API` using `ASP.NET Core 2.1`.

:rotating_light: you need to configure [data protection][data-protection] in order to be able to use antiforgery :rotating_light:

A common pattern for `SPA` applications is to retrieve some configuration via an initial call. In this example the configuration endpoint is available at `/api/spa/environment`. As it is recommended to [refresh the antiforgery tokens after authentication][refresh-tokens-after-authentication], we will set the antiforgery tokens when retrieving the configuration. We are doing this via a [middleware][middleware] to give us the flexibility to move it to another endpoint (or endpoints) if required.

```csharp
public class AngularAntiforgeryMiddleware
{
    // https://angular.io/guide/http#security-xsrf-protection
    public static string AngularCookieName = "XSRF-TOKEN";
    public static string AngularHeaderName = "X-XSRF-TOKEN";

    private readonly RequestDelegate _next;

    public AngularAntiforgeryMiddleware(RequestDelegate next)
    {
        _next = next ?? throw new ArgumentNullException(nameof(next));
    }

    public Task InvokeAsync(
        HttpContext httpContext,
        IAntiforgery antiforgery,
        ILogger<AngularAntiforgeryMiddleware> logger)
    {
        if (httpContext == null) throw new ArgumentNullException(nameof(httpContext));

        if (httpContext.Request.Path.StartsWithSegments("/api/spa/environment"))
        {
            logger.LogDebug("Writing antiforgery cookies");

            // This method provided by the framework writes a cookie that will be used
            // to validate the request (e.g. the cookie token should match the request
            // token)
            var tokens = antiforgery.GetAndStoreTokens(httpContext);

            // We need to write the cookie that will be used by Angular to set the
            // HTTP header
            httpContext.Response.Cookies.Append(
                AngularCookieName,
                tokens.RequestToken,
                new CookieOptions
                {
                    HttpOnly = false,
                    Secure = true,
                    SameSite = SameSiteMode.Strict
                });
        }

        return _next(httpContext);
    }
}
```

The other modifications take place in the `Startup.cs` file

```csharp
public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        // Abbreviated

        services
            .AddMvc(c =>
            {
                c.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
            })
            .AddAntiforgery(options =>
            {
                options.HeaderName = AngularAntiforgeryMiddleware.AngularHeaderName;
                options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
            });

        // Abbreviated
    }

    public void Configure(IApplicationBuilder app)
    {
        // Abbreviated

        app.UseMiddleware<AngularAntiforgeryMiddleware>();

        // Abbreviated
    }
}
```

[AutoValidateAntiforgeryTokenAttribute][auto-validate-anti-forgery-token] will validate **all** requests except for the following methods: `HEAD`, `TRACE`, `OPTIONS` and `GET`.

Nothing needs to be done in the `SPA` as we've [named the header and cookie following][angular-xsrf-protection] the `Angular` convention :sparkles:

## Troubleshooting

If you encounter issues with seemingly valid antiforgery tokens being rejected by `ASP.NET Core` you can set the verbosity of `Microsoft.AspNetCore.Mvc.ViewFeatures.Internal.AutoValidateAntiforgeryTokenAuthorizationFilter` to `Information`. Log events will be emitted at this level only when the validation fails.

[asp-net-core-anti-forgery]: https://docs.microsoft.com/en-us/aspnet/core/security/anti-request-forgery
[refresh-tokens-after-authentication]: https://docs.microsoft.com/en-us/aspnet/core/security/anti-request-forgery?view=aspnetcore-2.1#refresh-tokens-after-authentication
[middleware]: https://docs.microsoft.com/en-us/aspnet/core/fundamentals/middleware/?view=aspnetcore-2.1
[data-protection]: https://docs.microsoft.com/en-us/aspnet/core/security/data-protection/configuration/overview?view=aspnetcore-2.1&tabs=aspnetcore2x
[auto-validate-anti-forgery-token]: https://docs.microsoft.com/en-us/aspnet/core/security/anti-request-forgery?view=aspnetcore-2.1#automatically-validate-antiforgery-tokens-for-unsafe-http-methods-only
[angular-xsrf-protection]: https://angular.io/guide/http#security-xsrf-protection
