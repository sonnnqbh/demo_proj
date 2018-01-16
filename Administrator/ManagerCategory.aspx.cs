using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Administrator_ManagerCategory : System.Web.UI.Page
{
	clsDb objDb = new clsDb();
	DataSet ds_cat = new DataSet();
	protected void Page_Load(object sender, EventArgs e)
	{
		LoadCategory();
	}

	private void LoadCategory()
	{
		string sql = "Select * from [Category]";
		ds_cat = objDb.GetCommand(sql);
		gvCategory.DataSource = ds_cat.Tables[0];
		gvCategory.DataBind();
	}

	protected void btnInsert_ServerClick(object sender, EventArgs e)
	{
		txtCategoryName.Text = "";
		txtCategoryPosition.Text = "";
		txtQuanlity.Text = "";
		hfPopupUpdate.Value = "0";
		mpeUpdate.Show();
	}

	protected void gvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
	{
		int index = Convert.ToInt32(e.CommandArgument);
		GridViewRow gvrow = gvCategory.Rows[index];
		if (e.CommandName.Equals("editRecord"))
		{
			hfPopupUpdate.Value = gvCategory.DataKeys[index].Value.ToString();
			txtCategoryName.Text = HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString();
			txtCategoryPosition.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text).ToString();
			txtQuanlity.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
			mpeUpdate.Show();
		}
		else if (e.CommandName.Equals("deleteRecord"))
		{
			hfPopupDelete.Value = gvCategory.DataKeys[index].Value.ToString();

			lbxacnhanxoa.Text = "Đồng ý xóa <b>" + HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString() + "</b>";

			mpeDelete.Show();
		}
	}
	protected void btnUSave_Click(object sender, EventArgs e)
	{
		if (hfPopupUpdate.Value == "0")
		{
			if (txtCategoryPosition.Text == "")
			{
				txtCategoryPosition.Text = "0";
			}
			if (txtQuanlity.Text == "")
			{
				txtQuanlity.Text = "0";
			}
			string sql_insert = "Insert into [Category] (CategoryName, CategoryPosition, ProductsQuanlity, Dateadded) values (N'" + txtCategoryName.Text.Trim() + "', " + txtCategoryPosition.Text + ", " + txtQuanlity.Text + ", GETDATE())";
			if (objDb.DbCommand(sql_insert) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!');", true);
			}
			LoadCategory();
		}
		else
		{
			int _idUpdate = int.Parse(hfPopupUpdate.Value);
			string sql_update = "Update [Category] set CategoryName = N'" + txtCategoryName.Text.Trim() + "', CategoryPosition = " + txtCategoryPosition.Text + ", ProductsQuanlity = " + txtQuanlity.Text + ", DateUpdated = GETDATE() where CategoryID = " + _idUpdate;
			if (objDb.DbCommand(sql_update) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật thành công!');", true);
			}
			LoadCategory();
		}
	}

	protected void btnXoadongy_Click(object sender, EventArgs e)
	{
		string sql_delete = "Delete from [Category] where CategoryID = " + int.Parse(hfPopupDelete.Value);
		if (objDb.DbCommand(sql_delete) == "0")
		{
			ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xóa thành công!');", true);
		}
		else
		{
			System.Text.StringBuilder sb = new System.Text.StringBuilder();
			sb.Append(@"<script type='text/javascript'>");
			sb.Append("alert('Có lỗi trong quá trình xóa');");
			sb.Append(@"</script>");
			ScriptManager.RegisterClientScriptBlock(this, GetType(), "EditHideModalScript", sb.ToString(), false);
		}
		LoadCategory();
	}
}