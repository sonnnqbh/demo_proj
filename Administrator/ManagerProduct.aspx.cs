using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using VNPTQuangBinh.Common;

public partial class Administrator_ManagerProduct : System.Web.UI.Page
{
	clsDb objDb = new clsDb();
	clsUtil objUtil = new clsUtil();
	DataSet ds = new DataSet();
	public string[] imgUrls;
	public int totalPic = 0;
	protected void Page_Load(object sender, EventArgs e)
	{
		LoadProducts();
	}
	private static string RootURL
	{
		get
		{
			return URLHelper.RootURL;
		}
	}
	private void LoadProducts()
	{
		string sql = "Select P.ProductID, P.ProductSKU, P.ProductName, P.ProductPrice, P.ProductShortDesc, I.PictureURL as URLImage from [Product] P left join [ProductPicture] I on P.ProductID = I.ProductID and I.IsPresentPicture = 1 ";
		ds = objDb.GetCommand(sql);
		gvProducts.DataSource = ds.Tables[0];
		gvProducts.DataBind();
	}

	protected void btnXoadongy_Click(object sender, EventArgs e)
	{

	}

	protected void btnUSave_Click(object sender, EventArgs e)
	{
		if (hfPopupUpdate.Value == "0")
		{
			string sku = "";
			sku = objUtil.ConvertToUnsign(txtProductName.Text.Trim()) + "_" + objUtil.ConvertToUnsign(drlProductCategory.SelectedItem.Text) + "_" + DateTime.Now.Second.ToString() + DateTime.Now.Year.ToString();
			string sql_insert = "Insert into [Product] (ProductSKU, ProductName, ProductPrice, ProductShortDesc, ProductLongDesc, ProductCategoryID, DateAdded) values ('" + sku + "', N'" + txtProductName.Text.Trim() + "', " + txtProductPrice.Text + ", N'" + txtProductShortDesc.Text.Trim() + "', N'" + txtProductLongDesc.Text.Trim() + "', " + drlProductCategory.SelectedValue + ", GETDATE())";
			if (objDb.DbCommand(sql_insert) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới sản phẩm thành công!');", true);
			}
		}
		else
		{
			int _idUpdate = int.Parse(hfPopupUpdate.Value);
			string sql_update = "Update [Product] set ProductName = N'" + txtProductName.Text.Trim() + "', ProductPrice = " + txtProductPrice.Text + ", ProductShortDesc = N'" + txtProductShortDesc.Text.Trim() + "', ProductLongDesc = N'" + txtProductLongDesc.Text.Trim() + "', ProductCategoryID = " + drlProductCategory.SelectedValue.ToString() + ", ProductUpdateDate = GETDATE() where ProductID = " + _idUpdate;
			if (objDb.DbCommand(sql_update) == "0")
			{
				ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật sản phẩm thành công!');", true);
			}
		}
		LoadProducts();
	}

	protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
	{
		int index = Convert.ToInt32(e.CommandArgument);
		GridViewRow gvrow = gvProducts.Rows[index];
		if (e.CommandName.Equals("editRecord"))
		{
			drlProductCategory.Items.Clear();
			LoadCurrentCbx();
			hfPopupUpdate.Value = gvProducts.DataKeys[index].Value.ToString();
			string sql_select = "Select * from [Product] where ProductID = " + hfPopupUpdate.Value;
			DataSet ds_current = new DataSet();
			ds_current = objDb.GetCommand(sql_select);
			txtProductName.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text).ToString();
			txtProductPrice.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text).ToString();
			drlProductCategory.SelectedValue = ds_current.Tables[0].Rows[0]["ProductCategoryID"].ToString();
			txtProductShortDesc.Text = HttpUtility.HtmlDecode(gvrow.Cells[5].Text).ToString();
			txtProductLongDesc.Text = ds_current.Tables[0].Rows[0]["ProductLongDesc"].ToString();
			mpeUpdate.Show();
		}
		else if (e.CommandName.Equals("deleteRecord"))
		{
			hfPopupDelete.Value = gvProducts.DataKeys[index].Value.ToString();

			lbxacnhanxoa.Text = "Đồng ý xóa <b>" + HttpUtility.HtmlDecode(gvrow.Cells[2].Text).ToString() + "</b>";

			mpeDelete.Show();
		}
		else if (e.CommandName.Equals("addPicture"))
		{
			hfPopupAddImage.Value = gvProducts.DataKeys[index].Value.ToString();
			string sql_select = "Select * from [Product] where ProductID = " + hfPopupAddImage.Value;
			DataSet ds_current = new DataSet();
			ds_current = objDb.GetCommand(sql_select);
			txtProName.Text = ds_current.Tables[0].Rows[0]["ProductName"].ToString();
			mpeAddImage.Show();
		}
		else if (e.CommandName.Equals("showAlbum"))
		{
			hfAlbum.Value = gvProducts.DataKeys[index].Value.ToString();
			string sql_select = "Select * from [ProductPicture] where ProductID = " + hfAlbum.Value;
			DataSet ds_img = new DataSet();
			ds_img = objDb.GetCommand(sql_select);
			if (ds_img.Tables[0].Rows.Count > 0)
			{
				totalPic = ds_img.Tables[0].Rows.Count;
				imgUrls = new string[ds_img.Tables[0].Rows.Count];
				for (int i = 0; i < ds_img.Tables[0].Rows.Count; i++)
				{
					imgUrls[i] = ds_img.Tables[0].Rows[i]["PictureURL"].ToString();
				}
			}
			mpeShowAlbum.Show();
		}
	}

	protected void btnInsert_ServerClick(object sender, EventArgs e)
	{
		txtProductName.Text = "";
		txtProductPrice.Text = "";
		txtProductShortDesc.Text = "";
		txtProductLongDesc.Text = "";
		drlProductCategory.Items.Clear();
		LoadCurrentCbx();
		hfPopupUpdate.Value = "0";
		mpeUpdate.Show();
	}

	private void LoadCurrentCbx()
	{
		string sql_combo = "Select CategoryID, CategoryName from [Category]";
		DataSet ds_combo = new DataSet();
		ds_combo = objDb.GetCommand(sql_combo);
		objUtil.LoadCombobox(drlProductCategory, ds_combo);
	}

	protected void btnUpload_ServerClick(object sender, EventArgs e)
	{
		string fileType = "";
		if (myFileUpload.HasFile)
		{
			fileType = Path.GetExtension(myFileUpload.PostedFile.FileName).ToLower();
			if (fileType == ".jpg" || fileType == ".png")
			{
				string fileName = myFileUpload.PostedFile.FileName;
				string uploadPath = Server.MapPath("files\\uploads\\" + fileName);
				//string uploadPath = RootURL + "Administrator/files/uploads/" + fileName;
				if (File.Exists(uploadPath))
				{
					File.Delete(uploadPath);
				}
				myFileUpload.SaveAs(uploadPath);
			}
		}
	}

	protected void btnAddImage_Click(object sender, EventArgs e)
	{
		string fileType = "";
		if (myFileUpload.HasFile)
		{
			fileType = Path.GetExtension(myFileUpload.PostedFile.FileName).ToLower();
			if (fileType == ".jpg" || fileType == ".png")
			{
				string fileName = myFileUpload.PostedFile.FileName;
				string PictureURL = "files\\uploads\\" + fileName;
				string uploadPath = Server.MapPath(PictureURL);
				
				if (File.Exists(uploadPath))
				{
					File.Delete(uploadPath);
				}
				myFileUpload.SaveAs(uploadPath);
				if (cbxIsPresentImage.Checked)
				{
					cbxIsPresentImage.Value = "1";
				}
				else
				{
					cbxIsPresentImage.Value = "0";
				}
				DataSet ds_temp = new DataSet();
				ds_temp = objDb.GetCommand("Select * from [ProductPicture] where PictureURL = '" + PictureURL + "' and ProductID = " + hfPopupAddImage.Value);
				if (ds_temp.Tables[0].Rows.Count <= 0)
				{
					string sql_insert = "Insert into [ProductPicture] (ProductID, PictureURL, IsPresentPicture, Position, DateAdded) values (" + hfPopupAddImage.Value + ", N'" + PictureURL + "', " + cbxIsPresentImage.Value + ", " + txtImagePosition.Text + ", GETDATE())";
					if (objDb.DbCommand(sql_insert) == "0")
					{
						ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm ảnh thành công!');", true);
					}
					LoadProducts();
				}
				else
				{
					ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Đã có ảnh này!');", true);
					mpeAddImage.Show();
				}
			}
		}
		//mpeAddImage.Show();
	}

	protected void btnAddAndContinue_Click(object sender, EventArgs e)
	{

	}

	
}