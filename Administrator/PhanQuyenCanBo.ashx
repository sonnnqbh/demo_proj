<%@ WebHandler Language="C#" Class="PhanQuyenCanBo" %>

using System;
using System.Web;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Bussiness.BO;
using VNPTQuangBinh.Common;
using System.Data;
using System.Collections.Generic;

public class PhanQuyenCanBo : IHttpHandler {
    public Bussiness objbn = new Bussiness();
    public void ProcessRequest (HttpContext context) {
        string nguoidungid = context.Request.QueryString["nguoidungid"];
        string doanhnghiepid = context.Request.QueryString["doanhnghiepid"];
        string json = GetTreedata(nguoidungid, doanhnghiepid);
        context.Response.ContentType = "text/json";
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }
    private string GetTreedata(string nguoidungid, string doanhnghiepid)
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[] {
            new DataColumn("Id"),
            new DataColumn("Text"),
            new DataColumn("ParentId"),
            new DataColumn("State")
        });
        List<Nhomxe> lsdon = null;
        lsdon = objbn.GetNhomXeByDN(int.Parse(doanhnghiepid.ToString()));
        List<NguoiDung_NhomKH> lsnd_nkh = objbn.GetNhomKHByNguoiDungID(int.Parse(nguoidungid.ToString()));
        for (int i = 0; i < lsdon.Count; i++)
        {
            bool isChecked = false;
            
            if (lsnd_nkh != null)
            {
                for (int j = 0; j < lsnd_nkh.Count; j++)
                {
                    if (lsnd_nkh[j].IdNhomKH.ToString() == lsdon[i].ID.ToString())
                    {
                        isChecked = true;
                        break;
                    }
                }
            }
            dt.Rows.Add(lsdon[i].ID, lsdon[i].TenNhom, 0, isChecked);

        }
        Node root = new Node { id = "root", children = { }, text = "Quyền nhắn tin", state = new states { opened = true}, icon = "fa fa-folder-open fa-lg" };
        DataView view = new DataView(dt);
        view.RowFilter = "ParentId LIKE '0'";
        foreach (DataRowView kvp in view)
        {
            string parentId = kvp["Id"].ToString();
            Node node = new Node { id = kvp["Id"].ToString(), text = kvp["text"].ToString(), state = new states { opened = true, selected = bool.Parse(kvp["State"].ToString()) }, icon = "fa fa-users text-primary fa-lg" };
            root.children.Add(node);
        }
        return (new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(root));
    }

    class states
    {
        public states()
        { }
        public bool opened { get; set; }
        public bool disabled { get; set; }
        public bool selected { get; set; }
        public bool hidden { get; set; }
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
        public states state { get; set; }
        public string icon { get; set; }
    }
}