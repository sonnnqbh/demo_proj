<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="RoleDetail.aspx.cs" Inherits="Administrator_RoleDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/treeview/style.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
      <li><a href="#">Adminstrator</a></li>
      <li><a href="#">Quản lý người dùng</a></li>
      <li class="active">Cấp quyền cho nhóm</li>
    </ol>
    <div class="page-header">
      <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
          <h1><i class="page-header-icon ion-ios-pulse-strong"></i>CẤP QUYỀN</h1>
        </div>

        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
      </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            <asp:ScriptManager ID="scr1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
            <button id="btnLuu" runat="server" class="btn btn-primary" onclick="getNode()"><i class="fa fa-save"></i>&nbsp;Lưu nhóm quyền</button>
        </div>
        <div class="panel-body form-horizontal">
            <div class="form-group">
                <label for="txtTenQuyen" class="col-md-2 control-label">Tên nhóm quyền:</label>
                <div class="col-md-4">
                    <asp:DropDownList ID="cboNhomquyen" runat="server" AutoPostBack="True" CssClass="form-control" 
                        onselectedindexchanged="cboNhomquyen_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:HiddenField ID="hfSelected" runat="server" />
                </div>
                <div class="col-md-6">
                    <div id="ajax"></div>
                </div>
            </div>
        </div>
    </div>"
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
            "checkbox": {
                "three_state": true
            },
		    'core': {
		        'data': {
		            "themes": {
		                "responsive": true
		            },
		            "url": "LoadTreeForRole.ashx?catid=1&nhomquyenid=<%=nhomquyenid%>",
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
        });
        function getNode()
        {
            var result = $('#ajax').jstree('get_selected');
            document.getElementById("<%=hfSelected.ClientID%>").value = result;
            PageMethods.SendMessage(document.getElementById("<%=hfSelected.ClientID%>").value, OnSuccess);
        }
        function OnSuccess(response, userContext, methodName) {
            alert(response);
        }
	</script>
</asp:Content>

