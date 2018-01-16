using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Common;
using System.Web.Services;

public partial class Administrator_NhanTin : System.Web.UI.Page
{
    public static Bussiness objbn = new Bussiness();
    public List<NhanTin> lsnhantin = null;
    public static List<Donvi> lsdv = null;
    public string isAdmin = "0";
    public string idDoanhNghiep = "";
    public string idrole = "0";
    public string idnguoidung = "0";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {
                lsdv = objbn.GetDonVi(true);
                LoadGird();
            }
            else
            {
                Response.Redirect(AppUrls.LOGIN);
            }
        }
        catch
        {
            Response.Redirect(AppUrls.LOGIN);
        }
    }

    private void LoadGird()
    {
        if (IsAdmin())
            lsnhantin = objbn.GetTinNhan();
        else
        {
            lsnhantin = objbn.GetTinNhan(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));
        }
        if(AppSessionInfo.CurrentUser.RoleID.ToString() == "2")
        {
            idrole = AppSessionInfo.CurrentUser.RoleID.ToString();
            idnguoidung = AppSessionInfo.CurrentUser.NguoiDungID.ToString();
            lsnhantin = objbn.GetTinNhan(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()), int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString()));
        }
        gvGroups.DataSource = lsnhantin;
        gvGroups.PageIndex = 0;
        gvGroups.DataBind();
    }
    private bool IsAdmin()
    {
        if (AppSessionInfo.CurrentUser.TenDangNhap != null)
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {
                idDoanhNghiep = AppSessionInfo.CurrentUser.DoanhNghiepID.ToString();
                if (objbn.GetIDNhom(int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString())) == 1)
                {
                    isAdmin = "1";
                    return true;
                }
            }
            else
                Response.Redirect(AppUrls.LOGIN);

        return false;

    }

    private string ChuyenNgay(string ht)
    {
        string tem1, tem2, tem3;

        tem1 = ht.Substring(0, 2);
        tem2 = ht.Substring(3, 2);
        tem3 = ht.Substring(5, 5);
        string ngaythangnam = tem2 + "/" + tem1 + tem3;
        return ngaythangnam;
    }
    private void ExportToExcel(DataTable dt)
    {

        //khoi tao header
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=BaoCaoNT.xls");

        // HttpContext.Current.Response.Charset = System.Text.UTF8Encoding.UTF8.EncodingName.ToString();
        HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Unicode;
        HttpContext.Current.Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble());
        // HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
        //sets font
        HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Arial;'>");
        HttpContext.Current.Response.Write("<BR><BR><BR>");
        //sets the table border, cell spacing, border color, font of the text, background, foreground, font height
        HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' " +
          "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
          "style='font-size:10.0pt; font-family:Arial; background:white;'> <TR>");
        //am getting my grid's column headers
        int columnscount = dt.Columns.Count;// GridView_Result.Columns.Count;
                                            //write in new column

        foreach (DataColumn dc in dt.Columns)
        {
            HttpContext.Current.Response.Write("<Td>");
            //Get column headers  and make it as bold in excel columns
            HttpContext.Current.Response.Write("<B>");
            HttpContext.Current.Response.Write(dc.ColumnName);
            HttpContext.Current.Response.Write("</B>");
            HttpContext.Current.Response.Write("</Td>");

            // sTab = "\t";
        }

        //    HttpContext.Current.Response.Write("<Td>");
        //   //Get column headers  and make it as bold in excel columns
        //   HttpContext.Current.Response.Write("<B>");
        //   HttpContext.Current.Response.Write("Loại NT");
        //   HttpContext.Current.Response.Write("</B>");
        //   HttpContext.Current.Response.Write("</Td>");

        //   HttpContext.Current.Response.Write("<Td>");
        //   HttpContext.Current.Response.Write("<B>");
        //   HttpContext.Current.Response.Write("Dien Thoai");
        //   HttpContext.Current.Response.Write("</B>");
        //   HttpContext.Current.Response.Write("</Td>");

        //   HttpContext.Current.Response.Write("<Td>");
        //   HttpContext.Current.Response.Write("<B>");
        //   HttpContext.Current.Response.Write("Noi Dung");
        //   HttpContext.Current.Response.Write("</B>");
        //   HttpContext.Current.Response.Write("</Td>");

        //HttpContext.Current.Response.Write("<Td>");
        //   HttpContext.Current.Response.Write("<B>");
        //   HttpContext.Current.Response.Write("Ngay gui");
        //   HttpContext.Current.Response.Write("</B>");
        //   HttpContext.Current.Response.Write("</Td>");

        //HttpContext.Current.Response.Write("<Td>");
        //   HttpContext.Current.Response.Write("<B>");
        //   HttpContext.Current.Response.Write("Trang Thai Gui");
        //   HttpContext.Current.Response.Write("</B>");
        //   HttpContext.Current.Response.Write("</Td>");

        HttpContext.Current.Response.Write("</TR>");


        foreach (DataRow dr in dt.Rows)
        {
            HttpContext.Current.Response.Write("<TR>");
            for (int j = 0; j < 5; j++)
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

    protected void btnXuatBCNT_Click(object sender, EventArgs e)
    {
        int doanhnghiepid = 0;
        if (AppSessionInfo.CurrentUser.DoanhNghiepID != null)
        {
            if (!AppSessionInfo.CurrentUser.DoanhNghiepID.ToString().Equals(""))
            {
                doanhnghiepid = int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString());
            }
        }
        else
        {
            Response.Redirect(AppUrls.LOGIN);
        }

        string ngaybd = "", ngaykt = "";

        if (txtNgayBD.Text.Trim().Length == 10 && txtNgayKT.Text.Trim().Length == 10)
        {
            ngaybd = ChuyenNgay(txtNgayBD.Text);
            ngaykt = ChuyenNgay(txtNgayKT.Text);

            DataTable dt = Bussiness.GetBaoCaoNT(ngaybd, ngaykt, doanhnghiepid).Tables["nhantin"];
            ExportToExcel(dt);
            //DataSet ds1 = Bussiness.GetTimKiemTheoNgayXuat("15/09/2016", 1);
            //ExportToExcelKH(ds1.Tables[0]);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Nhập ngày không đúng định dạng..!!');", true);
        }
    }


    [WebMethod]
    public static string XuatNhanTinQC(string idNodes)
    {
        //khoi tao header
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=DachSachNT.xls");

        HttpContext.Current.Response.Charset = "UTF-8";
        // HttpContext.Current.Response.ContentEncoding = System.Text.ASCIIEncoding.Unicode;
        HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
        //sets font
        HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Arial;'>");
        HttpContext.Current.Response.Write("<BR><BR><BR>");
        //sets the table border, cell spacing, border color, font of the text, background, foreground, font height
        HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' " +
          "borderColor='#000000' cellSpacing='0' cellPadding='0' " +
          "style='font-size:10.0pt; font-family:Arial; background:white;'> <TR>");
        //am getting my grid's column headers
        int columnscount = 2;// GridView_Result.Columns.Count;
                             //write in new column
        HttpContext.Current.Response.Write("<Td>");
        //Get column headers  and make it as bold in excel columns
        HttpContext.Current.Response.Write("<B>");
        HttpContext.Current.Response.Write("So dien thoai");
        HttpContext.Current.Response.Write("</B>");
        HttpContext.Current.Response.Write("</Td>");
        //HttpContext.Current.Response.Write("<Td>");
        ////Get column headers  and make it as bold in excel columns
        //HttpContext.Current.Response.Write("<B>");
        //HttpContext.Current.Response.Write("ten");
        //HttpContext.Current.Response.Write("</B>");
        //HttpContext.Current.Response.Write("</Td>");
        HttpContext.Current.Response.Write("</TR>");

        string[] nodes = idNodes.Split(',');
        for (int i = 0; i < nodes.Length; i++)
        {
            int index = nodes[i].IndexOf("_KH");
            if (index != -1)
            {
                string node = nodes[i].Remove(index, 3);
                List<KhachHang> lskh = objbn.GetKhachHang(int.Parse(node));
                string sdt = lskh[0].DienThoai;
                sdt = "84" + sdt.Remove(0, 1);
                HttpContext.Current.Response.Write("<TR>");

                HttpContext.Current.Response.Write("<Td>");
                HttpContext.Current.Response.Write(sdt.ToString().Trim());
                HttpContext.Current.Response.Write("</Td>");

                //HttpContext.Current.Response.Write("<Td>");
                //HttpContext.Current.Response.Write(lskh[0].TenKhachHang);
                //HttpContext.Current.Response.Write("</Td>");
                //HttpContext.Current.Response.Write("</TR>");
            }
        }
        HttpContext.Current.Response.Write("</Table>");
        HttpContext.Current.Response.Write("</font>");
        HttpContext.Current.Response.Flush();
        HttpContext.Current.Response.End();

        return "Export thành công";
    }

    [WebMethod]
    public static string SendMessage(string idNodes, string message)
    {
        if (message == "")
        {
            return "Vui lòng nhập nội dung tin nhắn";
        }
        else
        {
            if (message.Length > 450)
            {
                return "Tin nhắn quá dài!";
            }
            else
            { 
                if (idNodes == "")
                {
                    return "Vui lòng chọn khách hàng cần nhắn tin";
                }
                else
                {
                    string[] nodes = idNodes.Split(',');
                    string tem = "";
                    for (int i = 0; i < nodes.Length; i++)
                    {
                        int index = nodes[i].IndexOf("_KH");
                        if (index != -1)
                        {
                            string node = nodes[i].Remove(index, 3);
                            List<KhachHang> lskh = objbn.GetKhachHang(int.Parse(node));
                            string sdt = lskh[0].DienThoai;
                            sdt = "84" + sdt.Remove(0, 1);
                            string[] param = new string[1];
                            //param[0] = UnicodeUtility.UnicodeToKoDau(message.Trim());
                            //param[0] = message.Trim();
                            int idDoanhnghiep = int.Parse(lskh[0].DoanhNghiepID.ToString());
                            List<Doanhnghiep> lsdn = objbn.GetDoanhNghiep(lsdv[0].ID, idDoanhnghiep, true);
                            if (lsdn[0].NhanTinCoDau == true)
                            {
                                param[0] = message.Trim();
                            }
                            else
                            {
                                param[0] = UnicodeUtility.UnicodeToKoDau(message.Trim());
                            }
                            tem = SendSMS.sendByList("111", lsdn[0].LABELID, lsdn[0].TEMPLATEID, "0", "1", "", sdt, lsdv[0].AGENTID, lsdn[0].APIUSER, lsdn[0].APIPASS, "QB_CS", lsdn[0].CONTRACTID, param);
                            GhiLog(LayNoiDungLog("", sdt, param[0], AppSessionInfo.CurrentUser.TenDangNhap, Xuly(tem), idDoanhnghiep));
                        }
                    }
                    return "Send message success!!!";
                }
            }
        }
    }

    private static NhanTin LayNoiDungLog(string ten, string dienthoai, string noidung, string nguoicapnhat, string trangthai, int doanhnghiepid)
    {
        NhanTin lsnhantin = new NhanTin();
        lsnhantin.DienThoai = dienthoai;
        lsnhantin.DoanhNghiepID = doanhnghiepid;
        lsnhantin.NgaycapNhat = DateTime.Now;
        lsnhantin.NguoiCapNhat = nguoicapnhat;
        lsnhantin.NoiDung = noidung;
        if (AppSessionInfo.CurrentUser.RoleID.ToString() == "2")
        {
            lsnhantin.NguoiDungID = int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString());
        }
        lsnhantin.Ten = ten;
        lsnhantin.TrangThai = trangthai;
        lsnhantin.LoaiNhanTin = 1;

        return lsnhantin;
    }

    private static void GhiLog(NhanTin obj)
    {
        try
        {
            bool ghilog = objbn.InsertNhanTin(obj);
        }
        catch
        {
            return;
        }
    }

    private static string Xuly(string chuoi)
    {
        try
        {
            string tem = "", tem1 = "<ERROR_DESC>", tem2 = "</ERROR_DESC>", temp3 = "";
            int startpos = chuoi.IndexOf(tem1) + 12, endpos = chuoi.IndexOf(tem2), dodai = chuoi.Length;
            if (chuoi.Length > endpos)
            {
                tem = chuoi.Substring(endpos);
                temp3 = chuoi.Substring(startpos, dodai - tem.Length - startpos);

            }
            return temp3;

        }
        catch
        {
            return "";
        }

        return "";
    }
}