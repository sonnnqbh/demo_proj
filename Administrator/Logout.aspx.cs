using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;

public partial class Administrator_Logout : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		AppSessionInfo.CurrentUser = null;
		Response.Redirect(AppUrls.LOGIN);
	}
}