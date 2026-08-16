using G2Cy.WebApi.Startups;

using OSharp.AspNetCore.Routing;
using OSharp.AutoMapper;
using OSharp.Entity;
using OSharp.Hosting.Authorization;
using OSharp.Hosting.Identity;
using OSharp.Hosting.Infos;
using OSharp.Hosting.Systems;
using OSharp.Log4Net;
using OSharp.MiniProfiler;
using OSharp.Swagger;

namespace G2Cy.WebApi;

public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddDatabaseDeveloperPageExceptionFilter();
        services.AddOSharp()
            .AddPack<Log4NetPack>()
            .AddPack<AutoMapperPack>()
            .AddPack<EndpointsPack>()
            .AddPack<MiniProfilerPack>()
            .AddPack<SwaggerPack>()
            .AddPack<SystemsPack>()
            .AddPack<AuthenticationPack>()
            .AddPack<FunctionAuthorizationPack>()
            .AddPack<DataAuthorizationPack>()
#if (mysql)
            .AddPack<MySqlDefaultDbContextMigrationPack>()
#endif
#if (mssql)
            .AddPack<SqlServerDefaultDbContextMigrationPack>()
#endif
#if (sqlite)
            .AddPack<SqliteDefaultDbContextMigrationPack>()
#endif
#if (pgsql)
            .AddPack<NpgsqlDefaultDbContextMigrationPack>()
#endif
#if (oracle)
            .AddPack<OracleDefaultDbContextMigrationPack>()
#endif
            .AddPack<AuditPack>()
            .AddPack<InfosPack>();

        services.AddSingleton<IEntityBatchConfiguration, PropertyCommentConfiguration>();
        services.AddSingleton<IEntityBatchConfiguration, PropertyUtcDateTimeConfiguration>();
    }

    public void Configure(WebApplication app)
    {
        if (app.Environment.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
            app.UseMigrationsEndPoint();
        }
        else
        {
            app.UseHttpsRedirection();
        }

        app.UseDefaultFiles()
            .UseStaticFiles();
        app.UseOSharp();
    }
}
