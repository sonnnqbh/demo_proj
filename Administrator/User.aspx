<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="Administrator_User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
    </style>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="#">Administrator</a></li>
        <li class="active">Người dùng</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Người dùng</h1>
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
                <asp:GridView ID="GvUser" CssClass="table table-striped table-bordered"
                        runat="server" AutoGenerateColumns="False" OnRowCommand="GvUser_RowCommand"
                        DataKeyNames="Nguoidungid" >
                    <Columns>
                        <asp:BoundField DataField="NguoiDungID" HeaderText="ID" Visible="False" >
                        <ItemStyle Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TenDangNhap" HeaderText="Tên đăng nhập" >
                            <ItemStyle Width="300px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="MatKhau" HeaderText="Mật khẩu" />
                        <asp:ButtonField CommandName="editRecord" ControlStyle-CssClass="btn btn-minier btn-primary"
                                                ButtonType="Button" Text="Sửa" HeaderText="">
                        </asp:ButtonField>
                        <asp:ButtonField CommandName="deleteRecord" ControlStyle-CssClass="btn btn-minier btn-danger"
                                                ButtonType="Button" Text="Xóa" HeaderText="">
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
        CancelControlID="btnUClose" BackgroundCssClass="modalBackground">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlUpdate" runat="server" CssClass="modal-dialog" Style="display: none">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title" id="myModalLabel">CẬP NHẬT NGƯỜI DÙNG</h4>
                </div>
                <div id="UFormValidator" class="modal-body form-horizontal">
                    <div class="form-group">
                        <label for="txtTendangnhap" class="col-sm-4 control-label">Tên đăng nhập:</label>
                        <div class="col-sm-8">
                            <asp:TextBox ID="txtTendangnhap" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtMatKhau" class="col-sm-4 control-label">Mật khẩu:</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cboNhomquyen" class="col-sm-4 control-label">Nhóm người dùng:</label>
                        <div class="col-sm-8">
                        <asp:DropDownList ID="cboNhomquyen" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cboDoanhNghiep" class="col-sm-4 control-label">Doanh nghiệp:</label>
                        <div class="col-sm-8">
                        <asp:DropDownList ID="cboDoanhNghiep" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="form-group">
                            <asp:Button ID="btnUSave" CssClass="btn btn-primary" runat="server" Text="Lưu" OnClick="btnUSave_Click" />
                            <asp:Button ID="btnUClose" runat="server" CssClass="btn btn-danger" Text="Close" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>                
    </asp:Panel>
    <%-- Popup xác nhận --%>
    <asp:HiddenField ID="hfPopupDelete" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeDelete" runat="server" PopupControlID="pnlDelete" TargetControlID="hfPopupDelete"
        CancelControlID="btnXoaHuy" BackgroundCssClass="modalBackground">
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
                    <%=txtTendangnhap.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập tên đăng nhập!'
                            }
                        }
                    },
                    <%=txtMatKhau.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập mật khẩu!'
                            }
                        }
                    },
                    <%=cboNhomquyen.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa chọn nhóm người dùng!'
                            }
                        }
                    },

                    <%=cboDoanhNghiep.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa chọn doanh nghiệp!'
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
            $('#MainContent_GvUser').prepend($("<thead></thead>").append($('#MainContent_GvUser').find("tr:first"))).dataTable({
                pageLength: 10,
                "language": {
                    "sProcessing":   "Đang xử lý...",
                    "sLengthMenu":   "_MENU_ dòng/trang",
                    "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
                    "sInfo":         "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ mục",
                    "sInfoEmpty":    "Đang xem 0 đến 0 trong tổng số 0 mục",
                    "sInfoFiltered": "(được lọc từ _MAX_ mục)",
                    "sInfoPostFix":  "",
                    "sSearch":       "Search:",
                    "sUrl":          "",
                    "oPaginate": {
                        "sFirst":    "Đầu",
                        "sPrevious": "Trước",
                        "sNext":     "Tiếp",
                        "sLast":     "Cuối"
                    }
                }
            });
            $('#MainContent_GvUser_wrapper .table-caption').text('Danh sách người dùng');
            $('#MainContent_GvUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>

