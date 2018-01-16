<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="UserRole.aspx.cs" Inherits="Administrator_UserRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/treeview/style.min.css" rel="stylesheet" />
    <style type="text/css">
        .demo
        {
            overflow: auto;
            border: 1px solid silver;
            /*min-height: 100px;*/
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="panel">
        <div class="panel-heading">
            SON TEST TREEVIEW
        </div>
        <div class="panel-body">
            <div class="input-group">
	            <input type="text" class="form-control" placeholder="Search node .." id="search">
	            <span class="input-group-btn">
		            <button class="btn btn-default" type="button" id="btn-search">Go!</button>
	            </span>
                
            </div><!-- /input-group -->
            <br />
            <div class="form-group">
                <button id="showme" class="btn btn-primary" type="button">Selected</button>
                
                <asp:ScriptManager ID="scr1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
                <button id="showme1" class="btn btn-primary" type="button" onclick="getNode()">Selected1</button>
                <asp:TextBox ID="txtSelected" runat="server" Visible="true" CssClass="form-control"></asp:TextBox>
            </div>
            <br />
            <%--<asp:TreeView ID="tv1" runat="server"></asp:TreeView>
            <div id="jstree2" class="demo" style="margin-top:2em;"></div>--%>
		    <div id="ajax" class="demo"></div>		
        </div>
        <div class="panel-footer">
            <button class="btn btn-primary" runat="server" id="btnTest"><i class="fa fa-plus"></i>&nbsp;Test</button>
            <asp:DropDownList ID="drlTest" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="drlTest_SelectedIndexChanged">
                <asp:ListItem Value="1" Text="abc" Selected="True"></asp:ListItem>
                <asp:ListItem Value="2" Text="bcd"></asp:ListItem>
                <asp:ListItem Value="3" Text="cde"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/jstree.min.js"></script>
    <script>
	$(function () {
		$('#ajax').jstree({
		    'plugins': ["checkbox", "search"],
            "search": {
                "case_insensitive": true,
		        "show_only_matches": true
		    },
		    'core': {
		        'data': {
		            "themes": {
		                "responsive": true
		            },
		            "url": "TreeViewCustomer.ashx?IDTest=<%=strTest%>",
		            "dataType": "json"
		        }
		    }
        });
        var to = null;
        $('#search').keyup(function () {
            if (to) { clearTimeout(to); }
            to = setTimeout(function () {
                var v = $('#search').val();
                $('#ajax').jstree(true).search(v);
            }, 250);
        });
		
		//$("#ajax").on("select_node.jstree",
        //     function (evt, data) {
        //         alert(data.node.text);
        //     }
        //);
	});
	$(document).on('click', '#showme', function () {
	    var result = $('#ajax').jstree('get_selected'); 
	    console.log(result);
	    console.log(result[0]);
	    var tree = jQuery.jstree._reference('#ajax');
	    var children = tree._get_children(selected);
	    console.log(children);
	    //console.log(checked_ids_meta);
	});
	function getNode()
	{
	    var result = $('#ajax').jstree('get_selected');
	    document.getElementById("<%=txtSelected.ClientID%>").value = result;
        PageMethods.SendMessage(document.getElementById("<%=txtSelected.ClientID%>").value, OnSuccess);
	}
    function OnSuccess(response, userContext, methodName) {
        //alert(response);
        console.log(response);
    }
	</script>
</asp:Content>

