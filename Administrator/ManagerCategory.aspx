<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="ManagerCategory.aspx.cs" Inherits="Administrator_ManagerCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <link href="assets/css/plugins/sweetalert/sweetalert.css" rel="stylesheet" />
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
    </style>
    <script src="assets/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function alertMessage(iTitle, iType, iMesage) {
            swal({
                title: "" + iTitle + "",
                text: "" + iMesage + "",
                type: "" + iType + ""
            });
        }
    </script>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="Default.aspx">Dashboard</a></li>
        <li class="active">Catagory</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Catagory</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
        <button type="button" id="btnInsert" class="btn btn-primary" runat="server" onserverclick="btnInsert_ServerClick"><i class="fa fa-plus"></i>&nbsp;Thêm mới</button>
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="gvCategory" CssClass="table table-striped table-bordered"
                        runat="server" AutoGenerateColumns="False" OnRowCommand="gvCategory_RowCommand"
                        DataKeyNames="CategoryID" >
                    <Columns>
                        <asp:BoundField DataField="CategoryID" HeaderText="ID" Visible="true" >
                            <ItemStyle Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CategoryName" HeaderText="Category Name" HeaderStyle-CssClass="control-label bolder blue" >
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CategoryPosition" HeaderText="Vị trí" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:BoundField DataField="ProductsQuanlity" HeaderText="Số lượng sản phẩm" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:BoundField DataField="Dateadded" HeaderText="Ngày tạo"  HeaderStyle-CssClass="control-label bolder blue"/>
                        <asp:BoundField DataField="DateUpdated" HeaderText="Ngày cập nhật"  HeaderStyle-CssClass="control-label bolder blue"/>
                        <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-minier btn-primary"
                                                ButtonType="Button" Text="Edit" HeaderText="">
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-minier btn-danger"
                                                ButtonType="Button" Text="Delete" HeaderText="">
                        </asp:ButtonField>
                    </Columns>
                    <EmptyDataTemplate>Không có dữ liệu</EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
    <%-- Popup Danh mục  --%>
    <asp:HiddenField ID="hfPopupUpdate" runat="server" />
    <asp:HiddenField ID="hfID" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeUpdate" runat="server" PopupControlID="pnlUpdate" TargetControlID="hfPopupUpdate"
        CancelControlID="btnUClose" BackgroundCssClass="modalBackground" X="370" Y="0">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlUpdate" runat="server" CssClass="modal-dialog" Style="display: none">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title" id="myModalLabel">Thông tin category</h4>
                </div>
                <div id="UFormValidator" class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="txtCategoryName" class="col-sm-4 control-label">Tên Catalog:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtCategoryPosition" class="col-sm-4 control-label">Vị trí:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtCategoryPosition" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtQuanlity" class="col-sm-4 control-label">Số lượng sản phẩm:</label>
                        <div class="col-sm-4">
                        <asp:TextBox ID="txtQuanlity" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <asp:Button ID="btnUSave" CssClass="btn btn-primary" runat="server" Text="Save changes" OnClick="btnUSave_Click" />
                            <asp:Button ID="btnUClose" runat="server" CssClass="btn btn-danger" Text="Close" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                
    </asp:Panel>
    <%-- Popup xác nhận --%>
    <asp:HiddenField ID="hfPopupDelete" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeDelete" runat="server" PopupControlID="pnlDelete" TargetControlID="hfPopupDelete"
        CancelControlID="btnXoaHuy" BackgroundCssClass="modalBackground" X="370" Y="0">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlDelete" runat="server" CssClass="modal-dialog" Style="display: none">
			<div class="modal-content">
                <div class="modal-header">
					<h4>Xác nhận</h4>               
                </div>
                <div class="modal-body" id="formValidator">

                    <div style="padding-left: 20px; padding-right: 20px">

                        <div class="form-group">
                            <asp:Label ID="lbxacnhanxoa" runat="server" />           
                        </div>
                                                    
                        <div class="form-group">
                            <asp:Button ID="btnXoadongy" CssClass="btn btn-sm btn-primary" runat="server" Text="Đồng ý" OnClick="btnXoadongy_Click" />
                            <asp:Button ID="btnXoaHuy" runat="server" CssClass="btn btn-sm btn-danger" Text="Đóng" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                 
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/bootstrapvalidator.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#UFormValidator').bootstrapValidator({
                    submitButtons: '<%=btnUSave.ClientID%>',
                    message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh'
                },
                fields: {
                    <%=txtCategoryName.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'The category name is required'
                            }
                        }
                    }
                }
            });
            $('#<%=btnUSave.ClientID%>').click(function(){
                var validatorObj = $('#UFormValidator').data('bootstrapValidator');
                validatorObj.validate();
                return validatorObj.isValid();
            });
        });
        loadTable();
        function loadTable() {
            $('#MainContent_gvCategory').prepend($("<thead></thead>").append($('#MainContent_gvCategory').find("tr:first"))).dataTable({
                pageLength: 10
            });
            $('#MainContent_gvCategory_wrapper .table-caption').text('List Category');
            $('#MainContent_gvCategory_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>

