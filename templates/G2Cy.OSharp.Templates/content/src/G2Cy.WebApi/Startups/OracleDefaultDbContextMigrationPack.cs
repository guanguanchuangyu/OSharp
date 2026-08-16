using System.ComponentModel;

using OSharp.Core.Packs;
using OSharp.Entity;
using OSharp.Entity.Oracle;

namespace G2Cy.WebApi.Startups;

[DependsOnPacks(typeof(OracleEntityFrameworkCorePack))]
[Description("Oracle DefaultDbContext migration pack")]
public class OracleDefaultDbContextMigrationPack : MigrationPackBase<DefaultDbContext>
{
    public override int Order => 2;

    protected override DatabaseType DatabaseType => DatabaseType.Oracle;

    protected override DefaultDbContext CreateDbContext(IServiceProvider scopedProvider)
    {
        return new DesignTimeDefaultDbContextFactory(scopedProvider).CreateDbContext(Array.Empty<string>());
    }
}
