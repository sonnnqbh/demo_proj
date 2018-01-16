<%@ WebHandler Language="C#" Class="LoadTreeForRole" %>

using System;
using System.Web;
using VNPTQuangBinh.Bussiness.DAL;
using VNPTQuangBinh.Bussiness.BO;
using System.Data;
using System.Collections.Generic;

public class LoadTreeForRole : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string nhomquyenid = context.Request.QueryString["nhomquyenid"];
        string json = GetTreedata(nhomquyenid);
        context.Response.ContentType = "text/json";
        context.Response.Write(json);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }
    private string GetTreedata(string id)
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[] {
            new DataColumn("Id"),
            new DataColumn("Text"),
            new DataColumn("ParentId"),
            new DataColumn("State")
        });
        if (id == "")
        {
            Node root = new Node { id = "0", text = "Chọn nhóm quyền", state = new states { hidden = true} };
            return (new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(root));
        }
        else
        {
            DataSet ds = Roles_User.GetRolesDetail();
            DataSet dsRolechidl1 = Roles_User.GetRoleChidl1(int.Parse(id));
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                dt.Rows.Add(ds.Tables[0].Rows[i]["quyenid"].ToString(), ds.Tables[0].Rows[i]["tenquyen"].ToString(), 0, false);
                DataSet dschidl1 = Roles_User.GetRoleChidl(Convert.ToInt32(ds.Tables[0].Rows[i][0].ToString()));
                if (dschidl1.Tables[0].Rows.Count > 0)
                {
                    for (int k = 0; k < dschidl1.Tables[0].Rows.Count; k++)
                    {
                        bool isChecked = false;
                        for (int h = 0; h < dsRolechidl1.Tables[0].Rows.Count; h++)
                        {
                            if (dsRolechidl1.Tables[0].Rows[h]["QuyenID"].ToString() == dschidl1.Tables[0].Rows[k][0].ToString())
                            {
                                isChecked = true;
                                break;
                            }
                        }
                        dt.Rows.Add(dschidl1.Tables[0].Rows[k]["quyenid"].ToString(), dschidl1.Tables[0].Rows[k]["tenquyen"].ToString(), ds.Tables[0].Rows[i]["quyenid"].ToString(), isChecked);
                    }
                }
            }
            Node root = new Node { id = "root", children = { }, text = "Quyền", state = new states { opened = true}, icon = "fa fa-folder-open fa-lg" };
            DataView view = new DataView(dt);
            view.RowFilter = "ParentId LIKE '0'";
            foreach (DataRowView kvp in view)
            {
                string parentId = kvp["Id"].ToString();
                Node node = new Node { id = kvp["Id"].ToString(), text = kvp["text"].ToString(), state = new states { opened = true, selected = bool.Parse(kvp["State"].ToString()) }, icon = "fa fa-users text-primary fa-lg" };
                root.children.Add(node);
                AddChildItems(dt, node, parentId);
            }
            return (new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(root));
        }
    }
    private void AddChildItems(DataTable dt, Node parentNode, string ParentId)
    {
        DataView viewItem = new DataView(dt);
        viewItem.RowFilter = "ParentId LIKE '" + ParentId + "'";
        foreach (DataRowView childView in viewItem)
        {
            Node node = new Node { id = childView["Id"].ToString(), text = childView["text"].ToString(), state = new states { opened = true, selected = bool.Parse(childView["State"].ToString()) }, icon = "fa fa-user text-danger fa-lg" };
            parentNode.children.Add(node);
            string pId = childView["Id"].ToString();
            AddChildItems(dt, node, pId);
        }
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