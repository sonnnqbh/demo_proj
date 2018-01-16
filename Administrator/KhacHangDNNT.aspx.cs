using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Common;

public partial class Administrator_KhacHangDNNT : System.Web.UI.Page
{
    Bussiness obj = new Bussiness();
    int stt = 1;
    public static int tranghientai = 0;
    public static int Doanhnghiepid = 0;
    public List<NhanTin> lsnhantin = null;
    public string get_stt()
    {
        return Convert.ToString(stt++);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {

                if (!IsPostBack)
                {
                    if (AppSessionInfo.CurrentUser.DoanhNghiepID != null)
                    {
                        if (!AppSessionInfo.CurrentUser.DoanhNghiepID.ToString().Equals(""))
                        {
                            Doanhnghiepid = int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString());

                        }
                    }
                    else
                        Doanhnghiepid = 0;
                    LoadGrid(0, 1000, "NhanTinExcel");

                }

            }
        }
        catch
        {
            Response.Redirect(AppUrls.LOGIN);
        }
        
    }
    private void LoadGrid(int index, int soluong, string loainhantin)
    {
        if (IsAdmin())
            lsnhantin = obj.GetTinNhan();
        else
        {
            lsnhantin = obj.GetTinNhan(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()), soluong, loainhantin);
        }
        this.GvgroupUser.DataSource = lsnhantin;
        this.GvgroupUser.PageIndex = 0;
        this.GvgroupUser.DataBind();
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

    protected void btnExportToExxcel_ServerClick(object sender, EventArgs e)
    {
        string path = string.Concat(Server.MapPath("~/Upload/NhanTin/" + FileUpload1.FileName));
        if (!FileUpload1.FileName.Equals(""))
        {
            string sl = "0";
            FileUpload1.SaveAs(path);
            List<Donvi> lsdv = obj.GetDonVi(true);
            if (lsdv != null)
                if (lsdv.Count > 0)
                {
                    DataTable dt = Bussiness.NhanTinExcel(path, Doanhnghiepid, 1, lsdv[0].AGENTID.Trim(), lsdv[0].APIUSER.Trim(), lsdv[0].APIPASS.Trim());
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Đã nhắn tin vui lòng kiểm tra file trả về để xem lỗi nếu có.!');", true);
                    // LoadGrid(0);
                    if (dt.Rows.Count > 1)
                        ExportToExcel(dt);

                }
        }
        else
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Vui lòng chọn file để nhắn tin!!');", true);
        LoadGrid(0, 1000, "NhanTinExcel");
    }

    protected void btnExportToExxcel0_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("../Upload/NhanTin/NhanTin.xls");
    }

    private void ExportToExcel(DataTable dt)
    {

        //khoi tao header
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=DSKH_Loi_import.xls");

        HttpContext.Current.Response.Charset = System.Text.UTF8Encoding.UTF8.EncodingName.ToString();
        HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Unicode;
        HttpContext.Current.Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
        // HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
        //sets font
        HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Arial;'>");
        HttpContext.Current.Response.Write("<BR><BR><BR>");

        HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' " +
          "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
          "style='font-size:10.0pt; font-family:Arial; background:white;'> <TR>");

        int columnscount = dt.Columns.Count;


        foreach (DataColumn dc in dt.Columns)
        {
            HttpContext.Current.Response.Write("<Td>");

            HttpContext.Current.Response.Write("<B>");
            HttpContext.Current.Response.Write(dc.ColumnName);
            HttpContext.Current.Response.Write("</B>");
            HttpContext.Current.Response.Write("</Td>");

        }

        HttpContext.Current.Response.Write("</TR>");


        foreach (DataRow dr in dt.Rows)
        {
            HttpContext.Current.Response.Write("<TR>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                HttpContext.Current.Response.Write("<Td>");
                HttpContext.Current.Response.Write(dr[j].ToString());
                HttpContext.Current.Response.Write("</Td>");
            }

            HttpContext.Current.Response.Write("</TR>");

        }

        HttpContext.Current.Response.Write("</Table>");
        HttpContext.Current.Response.Write("</font>");
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();
    }
}