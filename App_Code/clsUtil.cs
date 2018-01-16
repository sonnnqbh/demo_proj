using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for clsUtil
/// </summary>
public class clsUtil
{
	public clsUtil()
	{
		//
		// TODO: Add constructor logic here
		//
	}
	public void LoadCombobox(DropDownList dropdown, DataSet ds)
	{
		if (ds.Tables[0].Rows.Count > 0)
		{
			dropdown.Items.Add(new ListItem("Select ...", ""));
			for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
			{
				dropdown.Items.Add(new ListItem(ds.Tables[0].Rows[i][1].ToString(), ds.Tables[0].Rows[i][0].ToString()));
			}
		}
		else
		{

		}
	}
	public string ConvertToUnsign(string str)
	{
		string[] signs = new string[] {
			"aAeEoOuUiIdDyY",
			"áàạảãâấầậẩẫăắằặẳẵ",
			"ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",
			"éèẹẻẽêếềệểễ",
			"ÉÈẸẺẼÊẾỀỆỂỄ",
			"óòọỏõôốồộổỗơớờợởỡ",
			"ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
			"úùụủũưứừựửữ",
			"ÚÙỤỦŨƯỨỪỰỬỮ",
			"íìịỉĩ",
			"ÍÌỊỈĨ",
			"đ",
			"Đ",
			"ýỳỵỷỹ",
			"ÝỲỴỶỸ"
	   };
		for (int i = 1; i < signs.Length; i++)
		{
			for (int j = 0; j < signs[i].Length; j++)
			{
				str = str.Replace(signs[i][j], signs[0][i - 1]);
			}
		}
		return str;
	}
}