using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Administrator_ManagerSupplier : System.Web.UI.Page
{
	clsDb objDb = new clsDb();
	DataSet ds_sup = new DataSet();
	protected void Page_Load(object sender, EventArgs e)
	{
		LoadSupplier();
	}

	private void LoadSupplier()
	{
		string sql = "Select * from [Supplier]";
		ds_sup = objDb.GetCommand(sql);
		gvSupplier.DataSource = ds_sup.Tables[0];
		gvSupplier.DataBind();
	}

	protected void btnInsert_ServerClick(object sender, EventArgs e)
	{
		txtSupplierName.Text = "";
		txtSupplierAddress.Text = "";
		txtSupplierAccount.Text = "";
		txtSupplierEmail.Text = "";
		txtSupplierLevel.Text = "";
		txtSupplierPhone.Text = "";
		hfPopupUpdate.Value = "0";
		mpeUpdate.Show();
	}

	protected void gvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
	{
		int index = Convert.ToInt32(e.CommandArgument);
		GridViewRow gvrow = gvSupplier.Rows[index];
		if (e.CommandName.Equals("editRecord"))
		{
			hfPopupUpdate.Value = gvSupplier.DataKeys[index].Value.ToString();
			txtSupplierName.Text = HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString();
			txtSupplierAddress.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text).ToString();
			txtSupplierAccount.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text).ToString();
			txtSupplierLevel.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text).ToString();
			txtSupplierPhone.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text).ToString();
			txtSupplierEmail.Text = HttpUtility.HtmlDecode(gvrow.Cells[6].Text).ToString();
			mpeUpdate.Show();
		}
		else if (e.CommandName.Equals("deleteRecord"))
		{
			hfPopupDelete.Value = gvSupplier.DataKeys[index].Value.ToString();

			lbxacnhanxoa.Text = "Đồng ý xóa <b>" + HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString() + "</b>";

			mpeDelete.Show();
		}
	}
	protected void btnUSave_Click(object sender, EventArgs e)
	{
		if (hfPopupUpdate.Value == "0")
		{
			if (txtSupplierLevel.Text == "")
			{
				txtSupplierLevel.Text = "0";
			}
			string sql_insert = "Insert into [Supplier] (SupplierName, SupplierAddress, SupplierAccount, SupplierLevel, SupplierPhone, SupplierEmail, DateAdded) values (N'" + txtSupplierName.Text.Trim() + "', N'" + txtSupplierAddress.Text.Trim() + "', N'" + txtSupplierAccount.Text.Trim() + "', " + txtSupplierLevel.Text + ", '" + txtSupplierPhone.Text + "', N'" + txtSupplierEmail.Text + "', GETDATE())";
			if (objDb.DbCommand(sql_insert) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!');", true);
			}
			LoadSupplier();
		}
		else
		{
			int _idUpdate = int.Parse(hfPopupUpdate.Value);
			string sql_update = "Update [Supplier] set SupplierName = N'" + txtSupplierName.Text.Trim() + "', SupplierAddress = N'" + txtSupplierAddress.Text.Trim() + "', SupplierAccount = N'" + txtSupplierAccount.Text.Trim() + "', SupplierLevel = " + txtSupplierLevel.Text + ", SupplierPhone = '" + txtSupplierPhone.Text + "', SupplierEmail = '" + txtSupplierEmail.Text + "', DateUpdated = GETDATE() where SupplierID = " + _idUpdate;
			if (objDb.DbCommand(sql_update) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật thành công!');", true);
			}
			LoadSupplier();
		}
	}

	protected void btnXoadongy_Click(object sender, EventArgs e)
	{

	}
}