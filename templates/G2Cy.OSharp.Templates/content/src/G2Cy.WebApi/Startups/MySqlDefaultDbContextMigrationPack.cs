using System.ComponentModel;

using OSharp.Core.Packs;
using OSharp.Entity;
using OSharp.Entity.MySql;

namespace G2Cy.WebApi.Startups;

[DependsOnPacks(typeof(MySqlEntityFrameworkCorePack))]
[Description("MySQL DefaultDbContext migration pack")]
public class MySqlDefaultDbContextMigrationPack : MigrationPackBase<DefaultDbContext>
{
    public override int Order => 2;

    protected override DatabaseType DatabaseType => DatabaseType.MySql;

    protected override DefaultDbContext CreateDbContext(IServiceProvider scopedProvider)
    {
        return new DesignTimeDefaultDbContextFactory(scopedProvider).CreateDbContext(Array.Empty<string>());
    }
}
