using System.ComponentModel;

using OSharp.Core.Packs;
using OSharp.Entity;
using OSharp.Entity.Sqlite;

namespace G2Cy.WebApi.Startups;

[DependsOnPacks(typeof(SqliteEntityFrameworkCorePack))]
[Description("SQLite DefaultDbContext migration pack")]
public class SqliteDefaultDbContextMigrationPack : MigrationPackBase<DefaultDbContext>
{
    public override int Order => 2;

    protected override DatabaseType DatabaseType => DatabaseType.Sqlite;

    protected override DefaultDbContext CreateDbContext(IServiceProvider scopedProvider)
    {
        return new DesignTimeDefaultDbContextFactory(scopedProvider).CreateDbContext(Array.Empty<string>());
    }
}
