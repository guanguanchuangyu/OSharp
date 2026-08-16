using System.ComponentModel;

using OSharp.Core.Packs;
using OSharp.Entity;
using OSharp.Entity.SqlServer;

namespace G2Cy.WebApi.Startups;

[DependsOnPacks(typeof(SqlServerEntityFrameworkCorePack))]
[Description("SQL Server DefaultDbContext migration pack")]
public class SqlServerDefaultDbContextMigrationPack : MigrationPackBase<DefaultDbContext>
{
    public override int Order => 2;

    protected override DatabaseType DatabaseType => DatabaseType.SqlServer;

    protected override DefaultDbContext CreateDbContext(IServiceProvider scopedProvider)
    {
        return new DesignTimeDefaultDbContextFactory(scopedProvider).CreateDbContext(Array.Empty<string>());
    }
}
