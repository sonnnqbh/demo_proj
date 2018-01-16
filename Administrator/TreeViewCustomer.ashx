<%@ WebHandler Language="C#" Class="TreeViewCustomer" %>

using System;
using System.Web;
using VNPTQuangBinh.Common;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Bussiness.BO;
using System.Data;
using System.Collections.Generic;

public class TreeViewCustomer : IHttpHandler {
    public Bussiness objbn = new Bussiness();
    public List<NhanTin> lsnhantin = null;
    public List<Donvi> lsdv = null;
    public string tendv = "";
    public List<Doanhnghiep> lsdn = null;

    public void ProcessRequest (HttpContext context) {
        //string ID = context.Request.QueryString["IDTest"];
        string isAdmin = context.Request.QueryString["isAdmin"];
        string iddoanhnghiep = context.Request.QueryString["idDoanhNghiep"];
        string idrole = context.Request.QueryString["roleid"];
        string idnguoidung = context.Request.QueryString["nguoidungid"];
        string json = GetTreedata(isAdmin, iddoanhnghiep, idrole, idnguoidung);
        context.Response.ContentType = "text/json";
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }
    private string GetTreedata(string isAdmin, string idDoanhNghiep, string idrole, string idnguoidung)
    {
        lsdv = objbn.GetDonVi(true);
        List<Doanhnghiep> lsdn = null;
        if(isAdmin == "1")
        {
            lsdn = objbn.GetDoanhNghiep(int.Parse(lsdv[0].ID.ToString()), true);
        }
        else
        {
            lsdn = objbn.GetDoanhNghiep(int.Parse(lsdv[0].ID.ToString()),int.Parse(idDoanhNghiep), true);
        }

        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[] {
            new DataColumn("Id"),
            new DataColumn("Text"),
            new DataColumn("ParentId")
        });
        if (lsdn!=null)
        {
            if (lsdn.Count > 0)
            {
                for(int i = 0; i < lsdn.Count; i++)
                {
                    dt.Rows.Add(lsdn[i].ID.ToString(), lsdn[i].TenDN.ToString(), 0);
                    if (idrole != "0")
                    {
                        DataSet dsNhomXe = objbn.GetNhomXeByDNNguoiDungID(int.Parse(idDoanhNghiep.ToString()), int.Parse(idnguoidung.ToString()));
                        if (dsNhomXe != null)
                        {
                            if (dsNhomXe.Tables[0].Rows.Count > 0)
                            {
                                for (int j = 0; j < dsNhomXe.Tables[0].Rows.Count; j++)
                                {
                                    dt.Rows.Add(dsNhomXe.Tables[0].Rows[j]["ID"].ToString() + "_NX", dsNhomXe.Tables[0].Rows[j]["TenNhom"].ToString(), int.Parse(lsdn[i].ID.ToString()));
                                    List<KhachHang> lskh = objbn.GetKhachHang(int.Parse(lsdn[i].ID.ToString()), true, int.Parse(dsNhomXe.Tables[0].Rows[j]["ID"].ToString()));
                                    if(lskh != null)
                                    {
                                        if(lskh.Count > 0)
                                        {
                                            for(int h = 0; h < lskh.Count; h++)
                                            {
                                                dt.Rows.Add(lskh[h].ID.ToString() + "_KH", lskh[h].TenKhachHang.ToString() + " (" + lskh[h].DienThoai.ToString().Trim() + ")", dsNhomXe.Tables[0].Rows[j]["ID"].ToString() + "_NX");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else
                    { 
                        List<Nhomxe> lsnhomxe = objbn.GetNhomXeByDN(int.Parse(lsdn[i].ID.ToString()));
                        if(lsnhomxe != null)
                        {
                            if(lsnhomxe.Count > 0)
                            {
                                for(int j = 0; j < lsnhomxe.Count; j++)
                                {
                                    dt.Rows.Add(lsnhomxe[j].ID.ToString() + "_NX", lsnhomxe[j].TenNhom.ToString(), int.Parse(lsdn[i].ID.ToString()));
                                    List<KhachHang> lskh = objbn.GetKhachHang(int.Parse(lsdn[i].ID.ToString()), true, lsnhomxe[j].ID);
                                    if(lskh != null)
                                    {
                                        if(lskh.Count > 0)
                                        {
                                            for(int h = 0; h < lskh.Count; h++)
                                            {
                                                dt.Rows.Add(lskh[h].ID.ToString() + "_KH", lskh[h].TenKhachHang.ToString() + " (" + lskh[h].DienThoai.ToString().Trim() + ")", lsnhomxe[j].ID.ToString() + "_NX");
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        Node root = new Node { id = lsdv[0].TenDonVi.Trim(), children = { }, text = lsdv[0].TenDonVi.Trim(), icon = "fa fa-folder-open fa-lg" };
        DataView view = new DataView(dt);
        view.RowFilter = "ParentId LIKE '0'";
        foreach (DataRowView kvp in view)
        {
            string parentId = kvp["Id"].ToString();
            Node node = new Node { id = kvp["Id"].ToString(), text = kvp["text"].ToString(), icon = "fa fa-users text-primary fa-lg" };
            root.children.Add(node);
            AddChildItems(dt, node, parentId);
        }
        return (new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(root));
    }

    private void AddChildItems(DataTable dt, Node parentNode, string ParentId)
    {
        DataView viewItem = new DataView(dt);
        viewItem.RowFilter = "ParentId LIKE '" + ParentId + "'";
        foreach (DataRowView childView in viewItem)
        {
            Node node = new Node { id = childView["Id"].ToString(), text = childView["text"].ToString(), icon = "fa fa-user text-danger fa-lg" };
            parentNode.children.Add(node);
            string pId = childView["Id"].ToString();
            AddChildItems(dt, node, pId);
        }
    }
    class Node
    {
        public Node()
        {
            children = new List<Node>();
        }

        public string id { get; set; }
        public string text { get; set; }
        public List<Node> children { get; set; }
        public string icon { get; set; }
    }
}