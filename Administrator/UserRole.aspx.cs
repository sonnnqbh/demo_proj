using System;
using System.Web.Services;

public partial class Administrator_UserRole : System.Web.UI.Page
{
    public string strTest = "";
    protected void Page_Load(object sender, EventArgs e)
	{

    }
    [WebMethod]
    public static string SendMessage(string idKH)
    {
        string[] kh = idKH.Split(',');
        return "Hello " + kh[0] + "The Current Time is: " + DateTime.Now.ToString();
    }

    protected void drlTest_SelectedIndexChanged(object sender, EventArgs e)
    {
        strTest = drlTest.SelectedValue.ToString();
    }
}