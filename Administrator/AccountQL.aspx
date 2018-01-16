<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="AccountQL.aspx.cs" Inherits="Administrator_AccountQL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="css_more" Runat="Server">
    <style>
        .dataTable > thead > tr > th[class*="sort"]::before{display: none}
        .dataTable > thead > tr > th[class*="sort"]::after{display: none}
    </style>
    <link href="assets/css/plugins/treeview/style.min.css" rel="stylesheet" />
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="Ajax" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <ol class="breadcrumb page-breadcrumb">
        <li><a href="#">Administrator</a></li>
        <li class="active">Cấu hình tài khoản quản lý</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>TÀI KHOẢN QUẢN LÝ</h1>
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
                <asp:ScriptManager runat="server" EnablePageMethods="true" ID="ScriptManager1" />
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
                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Left">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnEdit" runat="server" CommandName="editRecord" CommandArgument='<%# Eval("NguoiDungID") %>' ToolTip="Sửa" CssClass="fa fa-lg fa-edit"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnDelete" runat="server" CommandName="deleteRecord" CommandArgument='<%# Eval("NguoiDungID") %>' ToolTip="Xóa" CssClass="fa fa-lg fa-trash"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnResetPass" runat="server" CommandName="PhanQuyenRecord" CommandArgument='<%# Eval("NguoiDungID") %>' ToolTip="Phân quyền nhắn tin" CssClass="fa fa-lg fa-tasks"></asp:LinkButton>
                        </ItemTemplate>
                        </asp:TemplateField>
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
                    <h4 class="modal-title" id="myModalLabel">CẬP NHẬT TÀI KHOẢN</h4>
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
                        <label for="cboDoanhNghiep" class="col-sm-4 control-label">Doanh nghiệp:</label>
                        <div class="col-sm-8">
                        <asp:DropDownList ID="cboDoanhNghiep" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="cboNhomquyen" class="col-sm-4 control-label">Nhóm người dùng:</label>
                        <div class="col-sm-8">
                        <asp:DropDownList ID="cboNhomquyen" runat="server" CssClass="form-control"></asp:DropDownList>
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
    <%-- Popup phân quyền --%>
    <asp:HiddenField ID="hfPopupRole" runat="server" />
    <Ajax:ModalPopupExtender ID="mpeRole" runat="server" PopupControlID="pnlRole" TargetControlID="hfPopupRole"
        CancelControlID="btnHuyRole" BackgroundCssClass="modalBackground">
    </Ajax:ModalPopupExtender>
    <asp:Panel ID="pnlRole" runat="server" CssClass="modal-dialog" Style="display: none">
			<div class="modal-content">
                <div class="modal-header">
					<b>PHÂN QUYỀN NHẮN TIN</b>               
                </div>
                <div class="modal-body form-horizontal" id="RformValidator">
                    <div class="form-group">
                        <asp:Label ID="lblXacNhanQuyen" runat="server" CssClass="col-md-5 control-label"></asp:Label>
                        <div class="col-md-7">
                            <div id="ajax"></div>
                        </div>
                    </div>                         
                    <div class="form-group">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-6">
                            <button id="btnLuu" runat="server" class="btn btn-sm btn-primary" onclick="PhanQuyenNT()"><i class="fa fa-save"></i>&nbsp;Lưu</button>
                            <asp:Button ID="btnHuyRole" runat="server" CssClass="btn btn-sm btn-danger" Text="Đóng" CausesValidation="false" />
                            <asp:HiddenField ID="hfSelected" runat="server" />
                        </div>
                    </div>
                </div>
            </div>                 
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jsmore" Runat="Server">
    <script src="assets/js/bootstrapvalidator.min.js"></script>
    <script src="assets/js/jstree.min.js"></script>
    <script type="text/javascript">
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
		            "url": "PhanQuyenCanBo.ashx?catid=1&doanhnghiepid=<%=doanhnghiepid%>&nguoidungid=<%=nguoidungid%>",
		            "dataType": "json"
		        }
		    }
        });
        function PhanQuyenNT()
        {
            var result = $('#ajax').jstree('get_selected');
            document.getElementById("<%=hfSelected.ClientID%>").value = result;
            PageMethods.PhanQuyenNT(document.getElementById("<%=hfSelected.ClientID%>").value, OnSuccess);
        }
        function OnSuccess(response, userContext, methodName) {
            alert(response);
        }
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
            $('#MainContent_GvUser_wrapper .table-caption').text('DANH SÁCH TÀI KHOẢN');
            $('#MainContent_GvUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>

