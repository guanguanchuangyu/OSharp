using Microsoft.Extensions.DependencyInjection;

using OSharp.Entity;

namespace G2Cy.WebApi.Startups;

public class DesignTimeDefaultDbContextFactory : DesignTimeDbContextFactoryBase<DefaultDbContext>
{
    public DesignTimeDefaultDbContextFactory()
        : base(null!)
    { }

    public DesignTimeDefaultDbContextFactory(IServiceProvider serviceProvider)
        : base(serviceProvider)
    { }

    protected override IServiceProvider CreateDesignTimeServiceProvider()
    {
        IServiceCollection services = new ServiceCollection();
        Startup startup = new();
        startup.ConfigureServices(services);
        return services.BuildServiceProvider();
    }
}
