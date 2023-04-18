using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(myMaintenance.Startup))]
namespace myMaintenance
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
