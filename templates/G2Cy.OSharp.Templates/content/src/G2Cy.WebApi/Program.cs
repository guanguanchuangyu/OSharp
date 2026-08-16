using G2Cy.WebApi;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

Startup startup = new();
startup.ConfigureServices(builder.Services);

WebApplication app = builder.Build();
startup.Configure(app);
app.Run();
