using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Common;

public partial class Administrator_CauHinhNT : System.Web.UI.Page
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
                    hfPopupUpdate.Value = "0";
                    LoadDonVi();
                }
            }

        }
        catch
        {
            Response.Redirect(AppUrls.LOGIN);
        }
    }
    private void LoadDonVi()
    {
        List<CauHinh> lsdonvi = obj.GetCauHinh();

        GvgroupCH.DataSource = lsdonvi;
        GvgroupCH.DataBind();
    }

    private void ShowData(int index)
    {
        if (index > -1)
        {
            int id = Convert.ToInt32(GvgroupCH.DataKeys[index].Value);
            List<CauHinh> lskh = obj.GetCauHinh(id);

            if (lskh != null)
                if (lskh.Count > 0)
                {
                    txtlan1.Text = lskh[0].lan1.ToString();
                    txtlan2.Text = lskh[0].lan2.ToString();
                    txtlan3.Text = lskh[0].lan3.ToString();
                    txtlan4.Text = lskh[0].lan4.ToString();
                    txtlan5.Text = lskh[0].lan5.ToString();
                    txtlan6.Text = lskh[0].lan6.ToString();
                    txtgionhantindk.Text = lskh[0].GioNhanTinDK.ToString();
                    txtgionhantinsn.Text = lskh[0].GioNhanTinSN.ToString();
                    CheckBox1.Checked = bool.Parse(lskh[0].Hoatdong.ToString());
                    txtghichu.Text = lskh[0].GhiChu.Trim();

                }

        }
        else
        {
            // Reset();
        }
    }

    protected void GvgroupCH_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        GridViewRow gvrow = GvgroupCH.Rows[index];
        if (e.CommandName.Equals("editRecord"))
        {
            hfPopupUpdate.Value = GvgroupCH.DataKeys[index].Value.ToString();
            ShowData(index);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            if (obj.InsertCauHInh(LayDonVi()))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Thêm mới thành công!!');", true);
                LoadDonVi();
                cleartext();
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi khi thêm mới. vui lòng kiểm tra lại dữ liệu..!!');", true);
        }
        else
        {
            if (Bussiness.UpdateCauHinh(LayDonVi(), int.Parse(hfPopupUpdate.Value)))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật cấu hình thành công !');", true);
                LoadDonVi();
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi cập nhật cấu hình !');", true);
        }
    }
    private CauHinh LayDonVi()
    {
        CauHinh objkh = new CauHinh();
        objkh.lan1 = int.Parse(txtlan1.Text.Trim());
        objkh.lan2 = int.Parse(txtlan2.Text.Trim());
        objkh.lan3 = int.Parse(txtlan3.Text.Trim());
        objkh.lan4 = int.Parse(txtlan4.Text.Trim());
        objkh.lan5 = int.Parse(txtlan5.Text.Trim());
        objkh.lan6 = int.Parse(txtlan6.Text.Trim());
        objkh.Hoatdong = CheckBox1.Checked;
        objkh.GioNhanTinDK = int.Parse(txtgionhantindk.Text.Trim());
        objkh.GioNhanTinSN = int.Parse(txtgionhantinsn.Text.Trim());
        objkh.GhiChu = txtghichu.Text.Trim();
        return objkh;

    }

    private void cleartext()
    {
        txtlan1.Text = "";
        txtlan2.Text = "";
        txtlan3.Text = "";
        txtlan4.Text = "";
        txtlan5.Text = "";
        txtlan6.Text = "";
        txtghichu.Text = "";
        txtgionhantindk.Text = "";
        txtgionhantinsn.Text = "";
        hfPopupUpdate.Value = "0";
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        cleartext();
    }
}