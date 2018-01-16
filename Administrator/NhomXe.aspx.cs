using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;

public partial class Administrator_NhomXe : System.Web.UI.Page
{
    Bussiness obj = new Bussiness();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {

                if (!IsPostBack)
                {
                    LoadDonVi();
                    BindComBox();
                    hfPopupUpdate.Value = "0";
                }
            }

        }
        catch
        {
            Response.Redirect(AppUrls.LOGIN);
        }
    }
    private void BindComBox()
    {
        List<Doanhnghiep> lsdn = null;
        if (IsAdmin())
        {
            lsdn = obj.GetDoanhNghiep(1, true);
        }
        else
            lsdn = obj.GetDoanhNghiep(1, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()), true);

        DrpDoanhNghiep.DataSource = lsdn;
        DrpDoanhNghiep.DataValueField = "ID";
        DrpDoanhNghiep.DataTextField = "TenDN";
        DrpDoanhNghiep.DataBind();
        DrpDoanhNghiep.Items.Insert(0, new ListItem("-- Chọn doanh nghiệp, tổ chức --", ""));

        List<CauHinh> lscauhinh = obj.GetCauHinh();
        DrpCauHinh.DataSource = lscauhinh;
        DrpCauHinh.DataValueField = "ID";
        DrpCauHinh.DataTextField = "GhiChu";
        DrpCauHinh.DataBind();
        DrpCauHinh.Items.Insert(0, new ListItem("-- Chọn cau hinh nhan tin--", ""));

    }
    private void LoadDonVi()
    {
        List<Nhomxe> lsdon = null;
        if (IsAdmin())
        {
            lsdon = obj.GetNhomXe();
        }
        else
            lsdon = obj.GetNhomXeByDN(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));

        GvgroupUser.DataSource = lsdon;
        GvgroupUser.DataBind();
    }
    private bool IsAdmin()
    {
        if (AppSessionInfo.CurrentUser.TenDangNhap != null)
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {
                if (obj.GetIDNhom(int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString())) == 1)
                    return true;
            }
            else
                Response.Redirect(AppUrls.LOGIN);

        return false;

    }
    private void ShowData(int index)
    {
        if (index > -1)
        {
            int id = Convert.ToInt32(GvgroupUser.DataKeys[index].Value);
            List<Nhomxe> lskh = obj.GetNhomXe(id);

            if (lskh != null)
                if (lskh.Count > 0)
                {
                    txttennhom.Text = lskh[0].TenNhom.Trim();
                    //DrpCauHinh.SelectedIndex = DrpCauHinh.Items.IndexOf(DrpCauHinh.Items.FindByValue(lskh[0].IDCauHinh.ToString()));
                    DrpDoanhNghiep.SelectedIndex = DrpDoanhNghiep.Items.IndexOf(DrpDoanhNghiep.Items.FindByValue(lskh[0].IDDoanhNghiep.ToString()));
                    CheckBox1.Checked = bool.Parse(lskh[0].TrangThai.ToString());
                    txtghichu.Text = lskh[0].Ghichu.Trim();
                    //chkNhanTinDK.Checked = bool.Parse(lskh[0].NhanTinDK.ToString());
                }

        }
        else
        {
            // Reset();
        }
    }
    private Nhomxe LayDonVi()
    {
        Nhomxe objkh = new Nhomxe();

        //objkh.IDCauHinh = int.Parse(DrpCauHinh.SelectedValue);
        objkh.TenNhom = txttennhom.Text.Trim();
        objkh.IDDoanhNghiep = int.Parse(DrpDoanhNghiep.SelectedValue);
        objkh.TrangThai = CheckBox1.Checked;
        //objkh.NhanTinDK = chkNhanTinDK.Checked;
        objkh.Ghichu = txtghichu.Text.Trim();
        return objkh;

    }
    private void cleartext()
    {
        DrpCauHinh.SelectedValue = "";
        DrpDoanhNghiep.SelectedValue = "";
        txttennhom.Text = "";
        txtghichu.Text = "";
        chkNhanTinDK.Checked = false;
        hfPopupUpdate.Value = "0";
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            if (obj.InsertNhomXe(LayDonVi()))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!!');", true);
                LoadDonVi();
                cleartext();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi khi thêm mới. vui lòng kiểm tra lại dữ liệu..!!');", true);
            }
        }
        else
        {
            if (Bussiness.UpdateNhomXe(LayDonVi(), int.Parse(hfPopupUpdate.Value)))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật thông tin thành công!!');", true);
                LoadDonVi();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi khi cập nhật!');", true);
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        cleartext();
    }

    protected void GvgroupUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int ID = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName.Equals("editRecord"))
        {
            hfPopupUpdate.Value = ID.ToString();
            List<Nhomxe> lskh = obj.GetNhomXe(ID);
            txttennhom.Text = lskh[0].TenNhom.Trim();
            //DrpCauHinh.SelectedIndex = DrpCauHinh.Items.IndexOf(DrpCauHinh.Items.FindByValue(lskh[0].IDCauHinh.ToString()));
            DrpDoanhNghiep.SelectedIndex = DrpDoanhNghiep.Items.IndexOf(DrpDoanhNghiep.Items.FindByValue(lskh[0].IDDoanhNghiep.ToString()));
            CheckBox1.Checked = bool.Parse(lskh[0].TrangThai.ToString());
            txtghichu.Text = lskh[0].Ghichu.Trim();
            //ShowData(index);
        }
        else if (e.CommandName.Equals("deleteRecord"))
        {
            hfPopupDelete.Value = ID.ToString();

            lbxacnhanxoa.Text = "Đồng ý xóa bản ghi?";

            mpeDelete.Show();
        }
        else if (e.CommandName.Equals("detailRecord"))
        {
            hfPopUpDetail.Value = ID.ToString();
            List<KhachHang> lskh = obj.GetKhachHang(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()), true, ID);
            GvKhachHang.DataSource = lskh;
            GvKhachHang.DataBind();
            mpeDetail.Show();
        }
    }

    protected void btnXoadongy_Click(object sender, EventArgs e)
    {
        try
        {
            int id = int.Parse(hfPopupDelete.Value);
            int iddoanhnghiep = int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString());

            if (Bussiness.CheckExistKH(id, iddoanhnghiep))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Còn tồn tại nhân viên trong nhóm !');", true);  
            }
            else
            {
                if (Bussiness.DeleteNhomKH(id, iddoanhnghiep))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xóa nhóm khách hàng thành công!!');", true);
                    LoadDonVi();
                    cleartext();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi xóa!!');", true);
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}