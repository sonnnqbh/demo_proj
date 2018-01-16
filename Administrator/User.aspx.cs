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

public partial class Administrator_User : System.Web.UI.Page
{
    Bussiness obj = new Bussiness();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (AppSessionInfo.CurrentUser.NguoiDungID != 0)
            {
                if (!IsPostBack)
                {
                    if (Isadmin())
                    {
                        LoadUser(0, 0);
                        LoadData.loadCommbox(cboNhomquyen, LoadUserGroup(), "NhomID", "TenNhom");
                        cboNhomquyen.Items.Insert(0, new ListItem("-- Chon nhom nguoi dung", ""));
                        LoadDoanhNghiep();
                    }
                    else
                    {
                        LoadUser(0, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));
                        LoadData.loadCommbox(cboNhomquyen, LoadUserGroup(), "NhomID", "TenNhom");
                        cboNhomquyen.Items.Insert(0, new ListItem("-- Chon nhom nguoi dung", ""));
                        LoadDoanhNghiep();
                    }
                }
            }
            else
                Response.Redirect(AppUrls.LOGIN);
        }
        catch (Exception) { Response.Redirect(AppUrls.LOGIN); }
    }
    private void LoadDoanhNghiep()
    {
        List<Doanhnghiep> lsdn = null;
        if (Isadmin())
        {
            lsdn = obj.GetDoanhNghiep(1, true);
        }
        else
            lsdn = obj.GetDoanhNghiep(1, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()), true);

        cboDoanhNghiep.DataSource = lsdn;
        cboDoanhNghiep.DataValueField = "ID";
        cboDoanhNghiep.DataTextField = "TenDN";
        cboDoanhNghiep.DataBind();
        cboDoanhNghiep.Items.Insert(0, new ListItem("-- Chọn doanh nghiệp, tổ chức --", ""));




    }
    private bool Isadmin()
    {
        if (AppSessionInfo.CurrentUser.TenDangNhap.Equals("admin"))
        {
            return true;
        }

        else
            return false;
    }
    protected DataTable LoadUserGroup()
    {
        return Roles_User.GetUserGroup().Tables[0];
    }
    protected void LoadUser(int index, int doanhnghiepid)
    {

        DataSet ds = new DataSet();
        if (doanhnghiepid == 0)
            ds = Users.GetUser();
        else
            ds = Users.GetUser(doanhnghiepid);

        GvUser.DataSource = ds.Tables[0]; ;
        GvUser.DataBind();
        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    GvUser.SelectedIndex = index;
        //    //ShowData(index);

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
            int id = Convert.ToInt32(GvUser.DataKeys[index].Value);
            DataTable dt = new DataTable();
            dt = Users.GetUserID(id).Tables[0];
            txtTendangnhap.Text = dt.Rows[0]["TenDangNhap"].ToString();
            txtMatKhau.Text = dt.Rows[0]["MatKhau"].ToString();
            cboDoanhNghiep.SelectedIndex = cboDoanhNghiep.Items.IndexOf(cboDoanhNghiep.Items.FindByValue(dt.Rows[0]["DoanhNghiepID"].ToString()));

        }
        else
        {
            txtTendangnhap.Text = "";
            txtMatKhau.Text = "";
        }
    }
    protected void btnInsert_ServerClick(object sender, EventArgs e)
    {
        txtTendangnhap.Text = "";
        txtMatKhau.Text = "";
        cboDoanhNghiep.SelectedValue = "";
        cboNhomquyen.SelectedValue = "";
        hfPopupUpdate.Value = "0";
        mpeUpdate.Show();
    }

    protected void GvUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow gvrow = GvUser.Rows[index];
        if (e.CommandName.Equals("editRecord"))
        {
            hfPopupUpdate.Value = GvUser.DataKeys[index].Value.ToString();
            DataTable dt = new DataTable();
            dt = Users.GetUserID(int.Parse(hfPopupUpdate.Value)).Tables[0];
            DataTable dtNhomquyen = Roles_User.GetComboxGroup(int.Parse(hfPopupUpdate.Value)).Tables[0];
            txtTendangnhap.Text = dt.Rows[0]["TenDangNhap"].ToString();
            txtMatKhau.Text = dt.Rows[0]["MatKhau"].ToString();
            cboNhomquyen.SelectedIndex = cboNhomquyen.Items.IndexOf(cboNhomquyen.Items.FindByValue(dtNhomquyen.Rows[0]["NhomID"].ToString()));
            cboDoanhNghiep.SelectedIndex = cboDoanhNghiep.Items.IndexOf(cboDoanhNghiep.Items.FindByValue(dt.Rows[0]["DoanhNghiepID"].ToString()));
            mpeUpdate.Show();
        }
        else if (e.CommandName.Equals("deleteRecord"))
        {
            hfPopupDelete.Value = GvUser.DataKeys[index].Value.ToString();

            lbxacnhanxoa.Text = "Đồng ý xóa <b>" + HttpUtility.HtmlDecode(gvrow.Cells[1].Text).ToString() + "</b>";

            mpeDelete.Show();
        }
    }

    protected void btnUSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            try
            {
                if (Users.InsertUser(txtTendangnhap.Text, txtMatKhau.Text, int.Parse(cboNhomquyen.SelectedValue.ToString()), int.Parse(cboDoanhNghiep.SelectedValue.ToString()), 1) != "0")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!');", true);
                    if (Isadmin())
                        LoadUser(0, 0);
                    else
                        LoadUser(0, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));
                }
                else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi thêm mới!');", true);
            }
            catch (Exception ex) { throw ex; }
        }
        else
        {
            if (Users.UpdateUser(int.Parse(hfPopupUpdate.Value), int.Parse(cboNhomquyen.SelectedValue.ToString()), txtTendangnhap.Text, txtMatKhau.Text, int.Parse(cboDoanhNghiep.SelectedValue.ToString())) != "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật thành công!');", true);
                if (Isadmin())
                    LoadUser(0, 0);
                else
                    LoadUser(0, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));

            }
            else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi cập nhật!');", true);
        }
    }

    protected void btnXoadongy_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt = Users.GetUserID(int.Parse(hfPopupDelete.Value)).Tables[0];
        if (dt.Rows[0]["RoleID"].ToString() == "0" && dt.Rows[0]["DoanhNghiepID"].ToString() == "0")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Tài khoản Admin, không được phép xóa!');", true);
        }
        else
        {
            if (Users.DeleteUser(int.Parse(hfPopupDelete.Value)) != "0")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xóa thành công!');", true);
                if (Isadmin())
                    LoadUser(0, 0);
                else
                    LoadUser(0, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));
            }
            else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi xóa!');", true);
        }
    }
}