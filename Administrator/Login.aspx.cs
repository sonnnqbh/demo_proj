using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Common;

public partial class Administrator_Login : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		try
		{
			AppCookieInfo.RemoveAllCookies();
			AppSessionInfo.CurrentUser = null;
			Session.Clear();
			CookieHelper.RemoveCookie(AppCookieKeys.USERID);
		}
		catch (Exception)
		{
			Response.Redirect(AppUrls.LOGIN);
			throw;
		}
	}
	public string RootURL
	{
		get
		{
			return URLHelper.RootURL;
		}
	}
	protected void btnSignIn_Click(object sender, EventArgs e)
	{
		Session.Clear();
		CookieHelper.RemoveCookie(AppCookieKeys.USERID);
		ProcessLogin();
	}

	private void ProcessLogin()
	{
        if (txtUserNameOrEmail.Text != "" && txtPassWord.Text != "")
        {
            DHQB_NguoiDung user = NguoiDungController.GetUserByLoginName(txtUserNameOrEmail.Text.Trim());
            try
            {
                if (user != null)
                {
                    if ((bool)user.IsBlock)
                    {
                        lblError.Text = "Tài khoản này đang khóa.";
                        return;
                    }
                    if (user.MatKhau != txtPassWord.Text.Trim())
                    {
                        lblError.Visible = true;
                        lblError.Text = "Mật khẩu đăng nhập không đúng.";
                        lblError.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                    AppSessionInfo.CurrentUser = user;
                    AppSessionInfo.sesionID = "";
                    if (AppRequestInfo.RETURL_URL != "-1" && AppRequestInfo.RETURL_URL.Length > 0)
                        Response.Redirect(HttpUtility.UrlDecode(AppRequestInfo.RETURL_URL));
                    else
                        Response.Redirect("Default.aspx?catid=1");
                }
                else
                {
                    lblError.Visible = true;
                    lblError.Text = "Tài khoản đăng nhập không hợp lệ.";
                    lblError.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else
        {

        }
    }
}