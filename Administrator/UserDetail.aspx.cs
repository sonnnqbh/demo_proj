using System;
using System.Web.UI;
using System.Data;

public partial class Administrator_UserDetail : System.Web.UI.Page
{
	clsDb objDb = new clsDb();
	string userID = "";
	protected void Page_Load(object sender, EventArgs e)
	{
		userID = Request.QueryString["UserID"].ToString();
		if (!IsPostBack)
		{
			LoadUserInfo(userID);
		}
	}

	private void LoadUserInfo(string userID)
	{
		string sql = "Select * from [User] where UserID=" + userID;
		DataSet ds = new DataSet();
		try
		{
			ds = objDb.GetCommand(sql);
			if (ds.Tables[0].Rows.Count > 0)
			{
				txtUserEmail.Text = ds.Tables[0].Rows[0]["UserEmail"].ToString();
				txtFirstName.Text = ds.Tables[0].Rows[0]["UserFirstName"].ToString();
				txtLastName.Text = ds.Tables[0].Rows[0]["UserLastName"].ToString();
				txtUserAddress.Text = ds.Tables[0].Rows[0]["UserAddress"].ToString();
				if (ds.Tables[0].Rows[0]["UserActived"].ToString() == "1")
				{
					txtUserActived.Checked = true;
				}
				else
				{
					txtUserActived.Checked = false;
				}
				if (ds.Tables[0].Rows[0]["IsAdministration"].ToString() == "1")
				{
					txtAdministrator.Checked = true;
				}
				else
				{
					txtAdministrator.Checked = false;
				}
				txtUserIP.Text = ds.Tables[0].Rows[0]["UserIP"].ToString();
				txtUserPhone.Text = ds.Tables[0].Rows[0]["UserPhone"].ToString();
			}
		}
		catch (Exception ex)
		{
			throw ex;
		}
	}

	protected void btnUpdateProfile_Click(object sender, EventArgs e)
	{
		UpdateProfile(userID);
	}
	private void UpdateProfile(string userID)
	{
		int isActive, isAdminstrator;
		if (txtUserActived.Checked)
		{
			isActive = 1;
		}
		else
		{
			isActive = 0;
		}
		if (txtAdministrator.Checked)
		{
			isAdminstrator = 1;
		}
		else
		{
			isAdminstrator = 0;
		}
		string sql = "Update [User] set UserFirstName = N'" + txtFirstName.Text.Trim() + "', UserLastName = N'" + txtLastName.Text.Trim() + "', UserAddress = N'" + txtUserAddress.Text.Trim() + "', UserActived = " + isActive + ", IsAdministration = " + isAdminstrator + ", UserIP = '" + txtUserIP.Text.Trim() + "', UserPhone = '" + txtUserPhone.Text.Trim() + "' where UserID =" + userID;
		if (objDb.DbCommand(sql) == "0")
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(@"<script type='text/javascript'>");
			sb.Append("alert('Update profile is successful!');");
			sb.Append(@"</script>");
			ScriptManager.RegisterClientScriptBlock(this, GetType(), "", sb.ToString(), false);
		}
	}

	protected void btnChangePass_Click(object sender, EventArgs e)
	{
		string sql_checkOldPassword = "Select UserPassword from [User] where UserID =" + userID;
		DataSet ds = new DataSet();
		ds = objDb.GetCommand(sql_checkOldPassword);
		if (txtOldPassword.Text != ds.Tables[0].Rows[0][0].ToString())
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(@"<script type='text/javascript'>");
			sb.Append("alert('Old Password is not correct!');");
			sb.Append(@"</script>");
			ScriptManager.RegisterClientScriptBlock(this, GetType(), "", sb.ToString(), false);
		}
		else
		{
			string sql_changePass = "Update [User] set UserPassword = '" + txtNewPassword.Text + "' where UserID =" + userID;
			if (objDb.DbCommand(sql_changePass) == "0")
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				sb.Append(@"<script type='text/javascript'>");
				sb.Append("alert('Change password successful!');");
				sb.Append(@"</script>");
				ScriptManager.RegisterClientScriptBlock(this, GetType(), "", sb.ToString(), false);
			}
		}
	}
}