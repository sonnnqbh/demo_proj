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

public partial class Administrator_ChangePass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!Roles_User.CheckOldPass(int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString()), txtOldPass.Text))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Mật khẩu cũ không đúng!');", true);
        }
        else
        {
            if (Roles_User.UpdatePass(int.Parse(AppSessionInfo.CurrentUser.NguoiDungID.ToString()), txtNewPass.Text) == "1")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Thành công!','success','Cập nhật thành công!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "alertMessage('Cảnh báo!','warning','Có lỗi khi cập nhật!');", true);
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
}