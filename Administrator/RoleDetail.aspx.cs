using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Common;

public partial class Administrator_RoleDetail : System.Web.UI.Page
{
    public DataSet ds = new DataSet();
    public static string nhomquyenid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (AppSessionInfo.CurrentUser.NguoiDungID != 0)
            {
                if (!IsPostBack)
                {
                    nhomquyenid = "";
                    BindComBox();
                }
            }
            else
                Response.Redirect(AppUrls.LOGIN);
        }
        catch (Exception) { Response.Redirect(AppUrls.LOGIN); }
    }

    private void BindComBox()
    {
        DataSet ds = Roles_User.GetGroupRoles();
        cboNhomquyen.DataSource = ds;
        cboNhomquyen.DataValueField = "NhomID";
        cboNhomquyen.DataTextField = "TenNhom";
        cboNhomquyen.DataBind();
        cboNhomquyen.Items.Insert(0, new ListItem("-- Chọn nhom quyen --",""));
    }

    protected void cboNhomquyen_SelectedIndexChanged(object sender, EventArgs e)
    {
        nhomquyenid = cboNhomquyen.SelectedValue;
    }

    protected void btnLuu_ServerClick(object sender, EventArgs e)
    {

    }
    #region Xoa quyen
    private static void RoleDelete()
    {
        DataSet dsRolechidl1 = Roles_User.GetRoleChidl1(int.Parse(nhomquyenid));
        if (dsRolechidl1.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < dsRolechidl1.Tables[0].Rows.Count; i++)
            {
                Roles_User.RoleDelete(int.Parse(dsRolechidl1.Tables[0].Rows[i]["QuyenID"].ToString()), int.Parse(nhomquyenid));
            }
        }
        
    }
    #endregion
    [WebMethod]
    public static string SendMessage(string idQuyens)
    {
        RoleDelete();
        try
        {
            string[] quyen = idQuyens.Split(',');
            for (int i = 0; i < quyen.Length; i++)
            {
                
                if (quyen[i] != "root")
                {
                    Roles_User.InsertGroupRole(int.Parse(nhomquyenid), int.Parse(quyen[i]));
                    int parentid = GetParentIdByQuyenId(int.Parse(quyen[i]));
                    if (parentid != 1)
                    {
                        if (!CheckExistParentNode(int.Parse(nhomquyenid), parentid))
                        {
                            Roles_User.InsertGroupRole(int.Parse(nhomquyenid), parentid);
                        }
                    }
                }
            }
            return "Cập nhật quyền thành công!!";
        }
        catch (Exception ex)
        {

            throw ex;
        }
        
    }

    public static int GetParentIdByQuyenId(int quyenid)
    {
        string sql = "Select * from DHQB_Quyen where QuyenID = " + quyenid;
        DataSet ds = SqlDataAccess.getDataFromSql(sql, "Quyen");
        return int.Parse(ds.Tables[0].Rows[0]["QuyenCha"].ToString());
    }

    public static bool CheckExistParentNode(int nhomquyen, int quyenid)
    {
        string sql = "Select * from DHQB_NhomQuyen where NhomID = " + nhomquyen + " and QuyenID = " + quyenid;
        DataSet ds = SqlDataAccess.getDataFromSql(sql, "Quyen");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
}