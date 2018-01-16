using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;

public partial class Administrator_Thietlap : System.Web.UI.Page
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
        List<Donvi> lsdonvi = obj.GetDonVi(true);
        if (lsdonvi != null)
            if (lsdonvi.Count > 0)
            {
                txttendonvi.Text = lsdonvi[0].TenDonVi;
                txtdienthoai.Text = lsdonvi[0].DienThoai;
                txtdiachi.Text = lsdonvi[0].Diachi;
                txtagentid.Text = lsdonvi[0].AGENTID;
                txtapiuser.Text = lsdonvi[0].APIUSER;
                txtapipass.Text = lsdonvi[0].APIPASS;
                txtusername.Text = lsdonvi[0].UserName;
                CheckBox1.Checked = bool.Parse(lsdonvi[0].HoatDong.ToString());
                lbnhomid.Text = lsdonvi[0].ID.ToString();
            }

    }
    private string KiemTraDuLieu()
    {
        try
        {

            if (txttendonvi.Text.Trim().Equals(""))
                return "Lỗi chưa nhập tên !!!";
            if (txtdienthoai.Text.Trim().Equals(""))
                return "Lỗi chưa nhập số điện thoại !!!";
            if (txtdiachi.Text.Trim().Equals(""))
                return "Lỗi chưa nhập địa chỉ !!!";
            if (txtagentid.Text.Trim().Equals(""))
                return "Lỗi chưa nhập AgentID !!!";
            if (txtapiuser.Text.Trim().Equals(""))
                return "Lỗi chưa nhập APIUSER !!!";
            if (txtapipass.Text.Trim().Equals(""))
                return "Lỗi chưa nhập APIPASS !!!";
            if (txtusername.Text.Trim().Equals(""))
                return "Lỗi chưa nhập Username đăng nhập hệ thống nhắn tin vinaphone !!!";
        }
        catch (Exception ex)
        {

            return "Lỗi không xác định";

        }

        return "ok";
    }
    private Donvi LayDonVi()
    {
        Donvi objkh = new Donvi();
        objkh.DienThoai = txtdienthoai.Text.Trim();
        objkh.Diachi = txtdiachi.Text.Trim();
        objkh.TenDonVi = txttendonvi.Text.Trim();
        objkh.AGENTID = txtagentid.Text.Trim();
        objkh.HoatDong = CheckBox1.Checked;
        objkh.APIPASS = txtapipass.Text.Trim();
        objkh.APIUSER = txtapiuser.Text.Trim();
        objkh.UserName = txtusername.Text.Trim();
        return objkh;

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


    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!lbnhomid.Text.Trim().Equals(""))
        {
            try
            {
                int id = int.Parse(lbnhomid.Text.Trim());

                if (KiemTraDuLieu().Equals("ok"))
                {
                    if (Bussiness.UpdateDV(LayDonVi(), id))
                    {
                        //lbThongbao.Text = "Đã cập nhật thông tin thành công!!";
                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Đã cập nhật thông tin thành công!!');", true);
                    }

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }
        else
            //lbThongbao.Text = "Vui lòng chọn dử liệu để sửa";
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Vui lòng chọn dử liệu để sửa');", true);
    }



    public string RootURL
    {
        get
        {
            return URLHelper.RootURL;
        }


    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
}