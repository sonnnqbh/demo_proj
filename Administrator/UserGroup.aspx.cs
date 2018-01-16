using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using System.Data;

public partial class Administrator_UserGroup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
                {
                    LoadUserGroup(0);
                    hfPopupUpdate.Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            Response.Redirect(AppUrls.LOGIN);
        }
    }

    protected void LoadUserGroup(int index)
    {
        DataSet ds = new DataSet();
        ds = Roles_User.GetUserGroup();
        GvgroupUser.DataSource = ds.Tables[0]; ;
        GvgroupUser.DataBind();
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    GvgroupUser.SelectedIndex = index;
        //    ShowData(index);
        //}
        //else
        //{
        //    ShowData(-1);
        //}
    }
    private void ShowData(int index)
    {
        if (index > -1)
        {
            int id = Convert.ToInt32(GvgroupUser.DataKeys[index].Value);
            DataTable dt = new DataTable();
            dt = Roles_User.GetGroup(id).Tables[0];
            txtTenQuyen.Text = dt.Rows[0]["TenNhom"].ToString();
            txtGhiChu.Text = dt.Rows[0]["MoTa"].ToString();
            cbxNhomQL.Checked = bool.Parse(dt.Rows[0]["IsGroupAdmin"].ToString());
        }
        else
        {
            txtTenQuyen.Text = "";
            txtGhiChu.Text = "";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            if (Roles_User.InsertUserGroup(txtTenQuyen.Text, txtGhiChu.Text, cbxNhomQL.Checked) != "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!!');", true);
                LoadUserGroup(0);
                clearText();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi khi thêm mới. vui lòng kiểm tra lại dữ liệu..!!');", true);
            }
        }
        else
        {
            if (Roles_User.UpdateUserGroup(int.Parse(hfPopupUpdate.Value), txtTenQuyen.Text, txtGhiChu.Text, cbxNhomQL.Checked) != "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật nhóm thành công!!');", true);
                LoadUserGroup(0);
            }
            else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi cập nhật!');", true);
        }
    }

    private void clearText()
    {
        txtTenQuyen.Text = "";
        txtGhiChu.Text = "";
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clearText();
    }

    protected void btnXoadongy_Click(object sender, EventArgs e)
    {
        if (Roles_User.CheckExistUserInGroup(int.Parse(hfPopupDelete.Value)) || Roles_User.CheckExistRoleInGroup(int.Parse(hfPopupDelete.Value)))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Còn tồn tại người dùng hoặc quyền thuộc nhóm!');", true);
        }
        else
        {
            if (Roles_User.DeleteUserGroup(int.Parse(hfPopupDelete.Value)) != "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xóa nhóm thành công!!');", true);
                LoadUserGroup(0);
            }
            else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi xóa!');", true);
        }
    }

    protected void GvgroupUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow gvrow = GvgroupUser.Rows[index];
        if (e.CommandName.Equals("editRecord"))
        {
            hfPopupUpdate.Value = GvgroupUser.DataKeys[index].Value.ToString();
            ShowData(index);
        }
        else if (e.CommandName.Equals("deleteRecord"))
        {
            hfPopupDelete.Value = GvgroupUser.DataKeys[index].Value.ToString();

            lbxacnhanxoa.Text = "Đồng ý xóa <b>" + HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString() + "</b>";

            mpeDelete.Show();
        }
    }
}