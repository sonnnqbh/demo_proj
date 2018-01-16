using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SMS_Portal.Startup))]
namespace SMS_Portal
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
