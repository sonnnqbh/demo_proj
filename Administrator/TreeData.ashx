<%@ WebHandler Language="C#" Class="TreeData" %>

using System;
using System.Web;
using System.Data;

public class TreeData : IHttpHandler {
    
    public void ProcessRequest(HttpContext context)
    {
 
        string json = GetTreedata();
        context.Response.ContentType = "text/json";
        context.Response.Write(json);
    }
 
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
 
    private string GetTreedata()
    {
        DataTable dt = new DataTable();
        dt.Columns.AddRange(new DataColumn[] {
                new DataColumn("Id"),
                new DataColumn("Text"),
                new DataColumn("ParentId")
             
        });
        dt.Rows.Add(1, "IT", 0);
        dt.Rows.Add(2, "David", 1);
        dt.Rows.Add(3, "Jhon", 1);
        dt.Rows.Add(4, "HR", 0);
        dt.Rows.Add(5, "Kevin", 4);
        dt.Rows.Add(6, "Marry", 4);
        dt.Rows.Add(7, "Marketing", 0);
        dt.Rows.Add(8, "Todd", 7);
        dt.Rows.Add(9, "Andrea", 7);
        dt.Rows.Add(10, "Adam", 7);
 
        Node root = new Node { id = "root", children = { }, text = "root" };
        DataView view = new DataView(dt);
        view.RowFilter = "ParentId=0";
        foreach (DataRowView kvp in view)
        {
            string parentId = kvp["Id"].ToString();
            Node node = new Node { id = kvp["Id"].ToString(), text = kvp["text"].ToString() };
            root.children.Add(node);
            AddChildItems(dt, node, parentId);
 
        }
        return (new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(root));
    }
 
    private void AddChildItems(DataTable dt, Node parentNode, string ParentId)
    {
        DataView viewItem = new DataView(dt);
        viewItem.RowFilter = "ParentId=" + ParentId;
        foreach (DataRowView childView in viewItem)
        {
            Node node = new Node { id = childView["Id"].ToString(), text = childView["text"].ToString() };
            parentNode.children.Add(node);
            string pId = childView["Id"].ToString();
            AddChildItems(dt, node, pId);
        }
    }
 
    class Node
    {
        public Node()
        {
            children = new System.Collections.Generic.List<Node>();
        }
 
        public string id { get; set; }
        public string text { get; set; }
        public System.Collections.Generic.List<Node> children { get; set; }
    }

}