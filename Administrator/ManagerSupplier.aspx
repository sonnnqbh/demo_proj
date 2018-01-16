<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="ManagerSupplier.aspx.cs" Inherits="Administrator_ManagerSupplier" %>

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
        <li class="active">Supplier</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Nhà cung cấp sản phẩm</h1>
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
                <asp:GridView ID="gvSupplier" CssClass="table table-striped table-bordered"
                        runat="server" AutoGenerateColumns="False" OnRowCommand="gvCategory_RowCommand"
                        DataKeyNames="SupplierID" >
                    <Columns>
                        <asp:BoundField DataField="SupplierID" HeaderText="ID" Visible="true" >
                            <ItemStyle Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SupplierName" HeaderText="Tên NCC" HeaderStyle-CssClass="control-label bolder blue" >
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SupplierAddress" HeaderText="Địa chỉ" HeaderStyle-CssClass="control-label bolder blue" >
                            <ItemStyle Width="200px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SupplierAccount" HeaderText="Tài khoản" HeaderStyle-CssClass="control-label bolder blue" >
                        </asp:BoundField>
                        <asp:BoundField DataField="SupplierLevel" HeaderText="Cấp độ"  HeaderStyle-CssClass="control-label bolder blue"/>
                        <asp:BoundField DataField="SupplierPhone" HeaderText="Số điện thoại"  HeaderStyle-CssClass="control-label bolder blue"/>
                        <asp:BoundField DataField="SupplierEmail" HeaderText="Email"  HeaderStyle-CssClass="control-label bolder blue"/>
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
                    <h4 class="modal-title" id="myModalLabel">Thông tin Nhà cung cấp</h4>
                </div>
                <div id="UFormValidator" class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="txtSupplierName" class="col-sm-4 control-label">Tên nhà cung cấp:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtSupplierName" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtSupplierAddress" class="col-sm-4 control-label">Địa chỉ:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtSupplierAddress" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtSupplierLevel" class="col-sm-4 control-label">Cấp độ:</label>
                        <div class="col-sm-2">
                        <asp:TextBox ID="txtSupplierLevel" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtSupplierPhone" class="col-sm-4 control-label">Số điện thoại:</label>
                        <div class="col-sm-8">
                        <asp:TextBox ID="txtSupplierPhone" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtSupplierEmail" class="col-sm-4 control-label">Email:</label>
                        <div class="col-sm-8">
                        <asp:TextBox ID="txtSupplierEmail" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtSupplierAccount" class="col-sm-4 control-label">Tài khoản thanh toán:</label>
                        <div class="col-sm-8">
                        <asp:TextBox ID="txtSupplierAccount" runat="server" CssClass="form-control" />
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
                    <%=txtSupplierName.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Tên nhà cung cấp không được để trống!'
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
            $('#MainContent_gvSupplier').prepend($("<thead></thead>").append($('#MainContent_gvSupplier').find("tr:first"))).dataTable({
                pageLength: 10
            });
            $('#MainContent_gvSupplier_wrapper .table-caption').text('Danh sách nhà cung cấp sản phẩm');
            $('#MainContent_gvSupplier_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>

