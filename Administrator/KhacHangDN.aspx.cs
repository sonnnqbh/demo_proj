using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Bussiness.DAL;
using Excel = Microsoft.Office.Interop.Excel;
using System.IO;
using System.Data;
using System.Reflection;
using System.Runtime.InteropServices;

public partial class Administrator_KhacHangDN : System.Web.UI.Page
{
    Bussiness obj = new Bussiness();
    public static int status = 0;
    public static int tranghientai = 0;

    int stt = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!AppSessionInfo.CurrentUser.TenDangNhap.Equals(""))
            {
                if (!IsPostBack)
                {
                    LoadGrid(0);
                    hfPopupUpdate.Value = "0";
                    Checkbox1.Checked = true;
                    txtSearch.Text = "";
                    BindComBox();
                    loadNhom();
                }

            }
        }
        catch
        {
            Response.Redirect(AppUrls.LOGIN);
        }
    }
    private void LoadGrid(int index)
    {
        try
        {
            List<KhachHang> lsnhantin = null;
            DataSet dsKH = new DataSet();
            if (AppSessionInfo.CurrentUser.DoanhNghiepID != null)
            {
                if (!AppSessionInfo.CurrentUser.DoanhNghiepID.ToString().Equals(""))
                {
                    int doanhnghiepid = int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString());
                    if (doanhnghiepid != 0)
                        dsKH = obj.GetDsKhachHang(doanhnghiepid, true);
                    else
                        dsKH = obj.GetDsKhachHang(true);

                }
            }
            else
            {
                lsnhantin = obj.GetKhachHang(true);
            }
            if (lsnhantin != null)
            {
                if (lsnhantin.Count > 0)
                {
                    //lbnhomid0.Text = lsnhantin.Count.ToString();
                }
                //else
                //    lbnhomid0.Text = "0";
            }
            //else
            //    lbnhomid0.Text = "0";

            GvgroupUser.DataSource = dsKH;
            GvgroupUser.PageIndex = index;
            GvgroupUser.DataBind();
        }
        catch(Exception ex)
        {
            return;
        }
    }
    private void ShowData(int index)
    {
        if (index > -1)
        {
            int id = Convert.ToInt32(GvgroupUser.DataKeys[index].Value);
            List<KhachHang> lskh = obj.GetKhachHang(id);

            if (lskh != null)
                if (lskh.Count > 0)
                {
                    txthovaten.Text = lskh[0].TenKhachHang.Trim();
                    txtGhiChu.Text = lskh[0].GhiChu.Trim();
                    txtdienthoai.Text = lskh[0].DienThoai.Trim();
                    Checkbox1.Checked = bool.Parse(lskh[0].HoatDong.ToString());
                    DrpDoanhNghiep.SelectedIndex = DrpDoanhNghiep.Items.IndexOf(DrpDoanhNghiep.Items.FindByValue(lskh[0].DoanhNghiepID.ToString()));
                    Drpnhomxe.SelectedIndex = Drpnhomxe.Items.IndexOf(Drpnhomxe.Items.FindByValue(lskh[0].IDNhom.ToString()));
                    txtNgay.Text = lskh[0].Ngaysinh.Trim();
                    if (string.IsNullOrEmpty(lskh[0].NgayMuaXe))
                        txtNgayMuaXe.Text = "";
                    else
                        txtNgayMuaXe.Text = lskh[0].NgayMuaXe;

                    txtnhanxe.Text = lskh[0].nhanxe.Trim();
                    txtkhungxe.Text = lskh[0].KhungXe.Trim();

                }

        }
        else
        {
            Reset();
        }
    }
    private void Reset()
    {
        txthovaten.Text = "";
        txtGhiChu.Text = "";
        txtdienthoai.Text = ""; txtkhungxe.Text = ""; txtnhanxe.Text = ""; txtNgay.Text = ""; txtNgayMuaXe.Text = "";
        DrpDoanhNghiep.SelectedValue = "";
        Drpnhomxe.SelectedValue = "";
        hfPopupUpdate.Value = "0";
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

    }
    private KhachHang LayKhachHang()
    {
        KhachHang objkh = new KhachHang();
        objkh.DienThoai = txtdienthoai.Text.Trim();
        objkh.DoanhNghiepID = int.Parse(DrpDoanhNghiep.SelectedValue);
        objkh.GhiChu = txtGhiChu.Text.Trim();
        objkh.TenKhachHang = txthovaten.Text.Trim();
        objkh.HoatDong = Checkbox1.Checked;
        objkh.Ngaysinh = txtNgay.Text.Trim();
        objkh.NgayMuaXe = txtNgayMuaXe.Text.Trim();
        objkh.nhanxe = txtnhanxe.Text.Trim();
        objkh.KhungXe = txtkhungxe.Text.Trim();
        objkh.IDNhom = int.Parse(Drpnhomxe.SelectedValue);
        return objkh;

    }
    private KhachHang LayKhachHangNew()
    {
        KhachHang objkh = new KhachHang();
        objkh.DienThoai = txtdienthoai.Text.Trim();
        objkh.DoanhNghiepID = int.Parse(DrpDoanhNghiep.SelectedValue);
        objkh.GhiChu = txtGhiChu.Text.Trim();
        objkh.TenKhachHang = txthovaten.Text.Trim();
        objkh.HoatDong = Checkbox1.Checked;
        objkh.Ngaysinh = txtNgay.Text.Trim();
        objkh.NgayMuaXe = txtNgayMuaXe.Text.Trim();
        objkh.Lan1 = false;
        objkh.Lan2 = false;
        objkh.Lan3 = false;
        objkh.Lan4 = false;
        objkh.Lan5 = false;
        objkh.Lan6 = false;
        objkh.nhanxe = txtnhanxe.Text.Trim();
        objkh.IDNhom = int.Parse(Drpnhomxe.SelectedValue);
        objkh.NhanTinSN = "";
        objkh.KhungXe = txtkhungxe.Text.Trim();
        return objkh;

    }
    private void loadNhom()
    {
        List<Nhomxe> lsnhomxe = null;
        if (IsAdmin())
        {
            lsnhomxe = obj.GetNhomXe();
        }
        else
            lsnhomxe = obj.GetNhomXeByDN(int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));
        Drpnhomxe.DataSource = lsnhomxe;
        Drpnhomxe.DataValueField = "ID";
        Drpnhomxe.DataTextField = "TenNhom";
        Drpnhomxe.DataBind();
        Drpnhomxe.Items.Insert(0, new ListItem("-- Chọn Nhóm Khách Hàng --", ""));
    }
    private void clearText()
    {
        txtdienthoai.Text = "";
        txtGhiChu.Text = "";
        txthovaten.Text = "";
        txtNgay.Text = "";
        txtNgayMuaXe.Text = "";
        txtnhanxe.Text = "";
        txtkhungxe.Text = "";
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
    protected void GvgroupUser_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        //GridViewRow gvrow = GvgroupUser.Rows[index];
        if (e.CommandName.Equals("editRecord"))
        {
            hfPopupUpdate.Value = GvgroupUser.DataKeys[index].Value.ToString();
            ShowData(index);
        }
        else if (e.CommandName.Equals("deleteRecord"))
        {
            hfPopupDelete.Value = GvgroupUser.DataKeys[index].Value.ToString();
            List<KhachHang> lskh = obj.GetKhachHang(int.Parse(hfPopupDelete.Value));
            lbxacnhanxoa.Text = "Đồng ý xóa <b>" + lskh[0].TenKhachHang.ToString() + "</b>";

            mpeDelete.Show();
        }
    }

    protected void btnUSave_Click(object sender, EventArgs e)
    {
        if (hfPopupUpdate.Value == "0")
        {
            try
            {
                if (Bussiness.cHECKKhachHang_ExcludeDoanhNghiep(txtdienthoai.Text.Trim(), txtkhungxe.Text.Trim(), int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString())))
                {
                    if (Bussiness.InsertKH(LayKhachHangNew()))
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Nhập mới khách hàng thành công !');", true);
                        LoadGrid(0);
                        clearText();
                    }
                    else
                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi nhập mới, vui lòng xem lại nội dung!');", true);
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Lỗi trùng số khung và số điện thoại khách hàng!');", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        else
        {
            if (Bussiness.cHECKKhachHang(txtdienthoai.Text.Trim(), txtkhungxe.Text.Trim(), int.Parse(hfPopupUpdate.Value)))
            {
                if (Bussiness.UpdateKH(LayKhachHang(), int.Parse(hfPopupUpdate.Value)))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Đã sửa đổi thành công !');", true);
                    LoadGrid(tranghientai);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Đã tồn tài số khung và số điện thoại khách hàng!');", true);
            }
        }
    }

    protected void btnBoQua_ServerClick(object sender, EventArgs e)
    {
        Reset();
    }

    protected void btnXoa_ServerClick(object sender, EventArgs e)
    {

    }

    protected void btnExportToExxcel_ServerClick(object sender, EventArgs e)
    {
        string path = string.Concat(Server.MapPath("~/Upload/" + FileUpload1.FileName));
        if (!IsAdmin())
            if (!path.Equals(""))
            {
                string sl = "0";
                FileUpload1.SaveAs(path);

                DataTable dt = Bussiness.uploadexcel(path, int.Parse(AppSessionInfo.CurrentUser.DoanhNghiepID.ToString()));

                if (dt.Rows.Count > 0)
                    if (dt.Rows.Count == 1)
                    {
                        sl = dt.Rows[0]["count"].ToString();
                    }
                    else
                    {
                        if (int.Parse(dt.Rows[0]["count"].ToString()) < 2)
                        {
                            sl = "0";
                        }
                        else
                            if (int.Parse(dt.Rows[0]["count"].ToString()) > dt.Rows.Count)
                        {
                            sl = (int.Parse(dt.Rows[0]["count"].ToString()) - dt.Rows.Count - 1).ToString();
                        }
                        else
                        {

                            sl = (int.Parse(dt.Rows[0]["count"].ToString()) - dt.Rows.Count).ToString();
                        }


                    }
                
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Đã thêm mới "+ sl +" dòng !');", true);
                LoadGrid(0);
                if (dt.Rows.Count != 1)
                    ExportToExcel(dt);


            }
    }

    protected void btnExportToExxcel0_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect("KhachHang_NT.xls");
    }

    protected void btnXoadongy_Click(object sender, EventArgs e)
    {
        try
        {
            int id = int.Parse(hfPopupDelete.Value);


            if (Bussiness.DeleteKH(id))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Đã xóa thành công !');", true);
                LoadGrid(tranghientai);
                Reset();
            }


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void GvgroupUser_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        LoadGrid(0);
        GvgroupUser.PageIndex = e.NewPageIndex;   //trang hien tai

        GvgroupUser.DataBind();
        tranghientai = e.NewPageIndex;
    }

    protected void btnCheckByNS_ServerClick(object sender, EventArgs e)
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
        List<KhachHang> lsnhomxe = obj.KiemTraNS(doanhnghiepid);
        GvgroupUser.DataSource = lsnhomxe;

        GvgroupUser.DataBind();

    }

    protected void btnCheckByNM_ServerClick(object sender, EventArgs e)
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
        List<KhachHang> lsnhomxe = obj.KiemTraNM(doanhnghiepid);
        GvgroupUser.DataSource = lsnhomxe;

        GvgroupUser.DataBind();
    }

    protected void btnCheckByPhone_ServerClick(object sender, EventArgs e)
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
        List<KhachHang> lsnhomxe = obj.KiemTraSDT(doanhnghiepid);
        GvgroupUser.DataSource = lsnhomxe;

        GvgroupUser.DataBind();
    }

    protected void btnSearch_ServerClick(object sender, EventArgs e)
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
        try
        {
            status = 1;
            //List<KhachHang> lsKhachHang = null;
            DataSet lsKhachHang = new DataSet();
            lsKhachHang = obj.SearchKHByAllPara(txtSearch.Text.Trim(), doanhnghiepid);
            GvgroupUser.DataSource = lsKhachHang;
            GvgroupUser.DataBind();
            if (lsKhachHang != null)
            {
                if (lsKhachHang.Tables[0].Rows.Count > 0)
                {
                    lbnhomid0.Text = lsKhachHang.Tables[0].Rows.Count.ToString();
                }
                else
                {
                    lbnhomid0.Text = "0";
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void ExportToExcelKH(DataTable dt)
    {

        //khoi tao header
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.ClearHeaders();
        HttpContext.Current.Response.Buffer = true;
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=Khachhang.xls");

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
            for (int j = 0; j < columnscount; j++)
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

    protected void btnExportAllKH_ServerClick(object sender, EventArgs e)
    {
        //string filename = "DSKhachHang_" + DateTime.Now.Year.ToString();
        //string sPathMau = Server.MapPath("fileExcelMau\\");
        //string sPath = Server.MapPath("fileExport\\");
        //if (!Directory.Exists(sPath))   // CHECK IF THE FOLDER EXISTS. IF NOT, CREATE A NEW FOLDER.
        //{
        //    Directory.CreateDirectory(sPath);
        //}
        //Excel.Application xlAppToExport = new Excel.Application();
        //Excel.Workbook wb = xlAppToExport.Workbooks.Open(sPathMau + "FileMauKH.xlsx");
        //Excel.Worksheet xlWorkSheetToExport = default(Excel.Worksheet);
        //xlWorkSheetToExport = (Excel.Worksheet)xlAppToExport.Sheets["Sheet1"];
        //File.Delete(sPath + "" + filename + ".xlsx"); // DELETE THE FILE BEFORE CREATING A NEW ONE.
        //                                             // ADD A WORKBOOK USING THE EXCEL APPLICATION.
        //List<KhachHang> lskh = null;
        //lskh = obj.GetKhachHang(true);
        //int iRowCnt = 7;
        //for (int i = 0; i < 500; i++)
        //{
        //    xlWorkSheetToExport.Cells[iRowCnt, 1] = lskh[i].ID.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 2] = lskh[i].TenKhachHang.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 3] = lskh[i].DienThoai.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 4] = lskh[i].Ngaysinh.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 5] = lskh[i].DoanhNghiepID.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 6] = lskh[i].GhiChu.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 7] = lskh[i].HoatDong.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 8] = lskh[i].NgayMuaXe.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 9] = lskh[i].Lan1.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 10] = lskh[i].Lan2.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 11] = lskh[i].Lan3.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 12] = lskh[i].Lan4.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 13] = lskh[i].Lan5.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 14] = lskh[i].Lan6.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 15] = lskh[i].nhanxe.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 16] = lskh[i].IDNhom.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 17] = lskh[i].NhanTinSN.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 18] = lskh[i].KhungXe.ToString();
        //    xlWorkSheetToExport.Cells[iRowCnt, 19] = "1";
        //    iRowCnt = iRowCnt + 1;
        //}
        //xlWorkSheetToExport.SaveAs(sPath + "" + filename + ".xlsx");
        //ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Xuất dữ liệu thành công!');", true);
        //// CLEAR.
        //wb.Close(true, sPathMau + "FileMauKH.xlsx", Missing.Value);
        //xlAppToExport.Quit();
        //KillExcel(xlAppToExport);
        //xlAppToExport = null;
        //xlWorkSheetToExport = null;
        //Response.AppendHeader("Content-Disposition", "attachment; filename="+ filename + ".xlsx");
        //Response.TransmitFile(sPath + "" + filename + ".xlsx");
        //Response.End();
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
        DataSet ds = Bussiness.GetTimKiem("", doanhnghiepid);
        ExportToExcelKH(ds.Tables[0]);
    }

    [DllImport("User32.dll")]
    public static extern int GetWindowThreadProcessId(IntPtr hWnd, out int ProcessId);
    public void KillExcel(Excel.Application theApp)
    {
        int id = 0;
        IntPtr intptr = new IntPtr(theApp.Hwnd);
        System.Diagnostics.Process p = null;
        try
        {
            GetWindowThreadProcessId(intptr, out id);
            p = System.Diagnostics.Process.GetProcessById(id);
            if (p != null)
            {
                p.Kill();
                p.Dispose();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public static void WriteAttachment(string FileName, string FileType, string content)
    {
        HttpResponse Response = System.Web.HttpContext.Current.Response;
        Response.ClearHeaders();
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + FileName);
        Response.ContentType = FileType;
        Response.Write(content);
        Response.End();
    }

    
}