using System.ComponentModel;

using OSharp.Core.Packs;
using OSharp.Entity;
using OSharp.Entity.PostgreSql;

namespace G2Cy.WebApi.Startups;

[DependsOnPacks(typeof(NpgsqlEntityFrameworkCorePack))]
[Description("PostgreSQL DefaultDbContext migration pack")]
public class NpgsqlDefaultDbContextMigrationPack : MigrationPackBase<DefaultDbContext>
{
    public override int Order => 2;

    protected override DatabaseType DatabaseType => DatabaseType.PostgreSql;

    protected override DefaultDbContext CreateDbContext(IServiceProvider scopedProvider)
    {
        return new DesignTimeDefaultDbContextFactory(scopedProvider).CreateDbContext(Array.Empty<string>());
    }
}
