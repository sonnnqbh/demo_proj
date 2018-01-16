using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;

public partial class Administrator_MDoanhNghiep : System.Web.UI.Page
{
    Bussiness obj = new Bussiness();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
                {
                    if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals("admin"))
                        btnUSave.Visible = false;
                    hfPopupUpdate.Value = "0";
                    LoadUserGroup(0);
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
        int doanhnghiepid = int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString());
        List<Doanhnghiep> lsdn = null;
        if (doanhnghiepid == 0)
        {
            lsdn = obj.GetDoanhNghiep(1);
        }
        else
        {
            lsdn = obj.GetDoanhNghiep(1, doanhnghiepid, true);
        }

        GvgroupUser.DataSource = lsdn;
        GvgroupUser.DataBind();
    }
    private Doanhnghiep LayNoiDung()
    {
        Doanhnghiep objdn = new Doanhnghiep();
        objdn.TenDN = txtTenDN.Text.Trim();
        objdn.DiaChi = txtDiaChi.Text.Trim();
        objdn.DienThoai = txtDienThoai.Text.Trim();
        objdn.Email = txtEmail.Text.Trim();
        objdn.CONTRACTID = txtcontractid.Text.Trim();
        objdn.LABELID = txtlabelid.Text.Trim();
        objdn.TEMPLATEID = txttemplateid.Text.Trim();
        objdn.CONTRACTIDQC = txtcontractid0.Text.Trim();
        objdn.LABELIDQC = txtlabelid0.Text.Trim();
        objdn.TEMPLATEIDQC = txttemplateid0.Text.Trim();
        objdn.APIUSER = txtApiUser.Text.Trim();
        objdn.APIPASS = txtApiPass.Text.Trim();
        objdn.ParamQC = txtparam0.Text.Trim();
        objdn.GhiChu = txtGhiChu.Text.Trim();
        objdn.DonviID = 1;
        objdn.HoatDong = chkhoatdong.Checked;
        objdn.NhanTinCoDau = chAllowMessageSign.Checked;
        objdn.Param = txtparam.Text.Trim();
        if (txtGionhantindk.Text == "")
        {
            txtGionhantindk.Text = "0";
        }
        objdn.GioNhanTinDK = int.Parse(txtGionhantindk.Text.Trim());
        if (txtgionhantinsn.Text == "")
        {
            txtgionhantinsn.Text = "0";
        }
        objdn.GioNhanTinSN = int.Parse(txtgionhantinsn.Text.Trim());
        objdn.NoiDungNTBD = txtnoidungtinnhandk.Text.Trim();
        objdn.NoiDungNTSN = txtnoidungtinnhansn.Text.Trim();
        objdn.NoiDungNTCS = txtnoidungtinnhancs.Text.Trim();
        if (txtsongayntcs.Text.Equals(""))
            objdn.SoNgayNTCS = 0;
        else
            objdn.SoNgayNTCS = int.Parse(txtsongayntcs.Text.Trim());
        return objdn;
    }
    private void Cleartext()
    {
        txtTenDN.Text = "";
        txtDiaChi.Text = "";
        txtDienThoai.Text = "";
        txtEmail.Text = "";
        txtcontractid.Text = "";
        txtlabelid.Text = "";
        txttemplateid.Text = "";
        txtApiPass.Text = "";
        txtApiUser.Text = "";

        txtGionhantindk.Text = "";
        txtgionhantinsn.Text = "";
        txtcontractid0.Text = "";
        txtlabelid0.Text = "";
        txttemplateid0.Text = "";
        txtparam0.Text = "";
        chkhoatdong.Checked = true;
        chAllowMessageSign.Checked = false;
        txtGhiChu.Text = "";
        txtparam.Text = "";

        txtnoidungtinnhancs.Text = "";
        txtnoidungtinnhandk.Text = "";
        txtnoidungtinnhansn.Text = "";

    }
    private void ShowData(int index)
    {
        if (index > -1)
        {
            int id = Convert.ToInt32(GvgroupUser.DataKeys[index].Value);
            //lbnhomid.Text = id.ToString();
            List<Doanhnghiep> lsdn = obj.GetDoanhNghiepTheoID(id);
            if (lsdn != null)
                if (lsdn.Count > 0)
                {
                    txtTenDN.Text = lsdn[0].TenDN;
                    txtDiaChi.Text = lsdn[0].DiaChi;
                    txtDienThoai.Text = lsdn[0].DienThoai;
                    txtEmail.Text = lsdn[0].Email;
                    txtcontractid.Text = lsdn[0].CONTRACTID;
                    txtlabelid.Text = lsdn[0].LABELID;
                    txttemplateid.Text = lsdn[0].TEMPLATEID;

                    txtcontractid0.Text = lsdn[0].CONTRACTIDQC;
                    txtlabelid0.Text = lsdn[0].LABELIDQC;
                    txttemplateid0.Text = lsdn[0].TEMPLATEIDQC;
                    txtApiUser.Text = lsdn[0].APIUSER;
                    txtApiPass.Text = lsdn[0].APIPASS;
                    txtparam0.Text = lsdn[0].ParamQC;
                    txtparam.Text = lsdn[0].Param;
                    chkhoatdong.Checked = bool.Parse(lsdn[0].HoatDong.ToString());
                    chAllowMessageSign.Checked = bool.Parse(lsdn[0].NhanTinCoDau.ToString());
                    txtGhiChu.Text = lsdn[0].GhiChu;
                    txtparam.Text = lsdn[0].Param;
                    txtGionhantindk.Text = lsdn[0].GioNhanTinDK.ToString();
                    txtgionhantinsn.Text = lsdn[0].GioNhanTinSN.ToString();
                    txtnoidungtinnhandk.Text = lsdn[0].NoiDungNTBD.ToString();
                    txtnoidungtinnhansn.Text = lsdn[0].NoiDungNTSN.ToString();
                    txtnoidungtinnhancs.Text = lsdn[0].NoiDungNTCS.ToString();
                    txtsongayntcs.Text = lsdn[0].SoNgayNTCS.ToString();

                }
        }
        else
        {
            Cleartext();
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

    protected void btnUSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            if (Bussiness.InsertDN(LayNoiDung()))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!!');", true);
                LoadUserGroup(0);
                Cleartext();
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi khi thêm mới. vui lòng kiểm tra lại dữ liệu..!!');", true);
        }
        else
        {
            if (Bussiness.UpdateDN(LayNoiDung(), int.Parse(hfPopupUpdate.Value)))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật doanh nghiệp thành công !');", true);
                LoadUserGroup(0);
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi cập nhật doanh nghiệp !');", true);
        }
    }

    protected void btnXoadongy_Click(object sender, EventArgs e)
    {
        if (Bussiness.DeleteDN(int.Parse(hfPopupDelete.Value)))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xóa doanh nghiệp thành công !');", true);
            LoadUserGroup(0);
           // Cleartext();
        }
        else ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi xóa doanh nghiệp !');", true);
    }


    protected void btnBoQua_ServerClick(object sender, EventArgs e)
    {
        Cleartext();
        hfPopupUpdate.Value = "0";
    }

    protected void btnXoa_ServerClick(object sender, EventArgs e)
    {

    }
}