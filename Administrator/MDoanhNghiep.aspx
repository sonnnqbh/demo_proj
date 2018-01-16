<%@ Page Title="" Language="C#" MasterPageFile="~/Administrator/Administrator.master" AutoEventWireup="true" CodeFile="MDoanhNghiep.aspx.cs" Inherits="Administrator_MDoanhNghiep" %>

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
        <li class="active">Danh sách doanh nghiệp</li>
    </ol>
    <div class="page-header">
        <div class="row">
        <div class="col-md-4 text-xs-center text-md-left text-nowrap">
            <h1><i class="page-header-icon ion-ios-pulse-strong"></i>Danh sách doanh nghiệp</h1>
        </div>
        <hr class="page-wide-block visible-xs visible-sm" />
        <!-- Spacer -->
        <div class="m-b-2 visible-xs visible-sm clearfix"></div>
        </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            THÔNG TIN DOANH NGHIỆP
        </div>"
        <div class="panel-body form-horizontal" id="UFormValidator">
            <div class="form-group">
                <label for="txtTenDN" class="col-sm-2 control-label">Tên doanh nghiệp:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control" />
                </div>
                <label for="txtDiaChi" class="col-sm-2 control-label">Địa chỉ:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtDienThoai" class="col-sm-2 control-label">Điện thoại:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtDienThoai" runat="server" CssClass="form-control" />
                </div>
                <label for="txtEmail" class="col-sm-2 control-label">Email:</label>
                <div class="col-sm-4">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtcontractid" class="col-sm-2 control-label">CONTRACTID:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtcontractid" runat="server" CssClass="form-control" />
                </div>
                <label for="txtlabelid" class="col-sm-2 control-label">LABELID:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtlabelid" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtcontractid0" class="col-sm-2 control-label">CONTRACTID QC:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtcontractid0" runat="server" CssClass="form-control" />
                </div>
                <label for="txtlabelid0" class="col-sm-2 control-label">LABELID QC:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtlabelid0" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txttemplateid" class="col-sm-2 control-label">TEMPLATEID:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txttemplateid" runat="server" CssClass="form-control" />
                </div>
                <label for="txtparam" class="col-sm-2 control-label">Param:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtparam" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txttemplateid0" class="col-sm-2 control-label">TEMPLATEID QC:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txttemplateid0" runat="server" CssClass="form-control" />
                </div>
                <label for="txtparam0" class="col-sm-2 control-label">Param QC:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtparam0" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtApiUser" class="col-sm-2 control-label">APIUSER:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtApiUser" runat="server" CssClass="form-control" />
                </div>
                <label for="txtApiPass" class="col-sm-2 control-label">APIPASS:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtApiPass" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtGionhantindk" class="col-sm-2 control-label">Giờ nhắn tin định kỳ:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtGionhantindk" runat="server" CssClass="form-control" />
                </div>
                <label for="txtgionhantinsn" class="col-sm-2 control-label">Giờ nhắn tin SN:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtgionhantinsn" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtGionhantindk" class="col-sm-2 control-label">Trạng thái:</label>
                <div class="col-sm-2">
                    <label class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" runat="server" id="chkhoatdong" />
                    <span class="custom-control-indicator"></span>
                    Hoạt động
                    </label>
                </div>
                <div class="col-sm-2">
                    <label class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" runat="server" id="chAllowMessageSign" />
                    <span class="custom-control-indicator"></span>
                    Nhắn tin có dấu
                    </label>
                </div>
                <label for="txtGhiChu" class="col-sm-2 control-label">Ghi chú:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtnoidungtinnhancs" class="col-sm-2 control-label">Nội dung tin nhắn chăm sóc::</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtnoidungtinnhancs" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
                <label for="txtsongayntcs" class="col-sm-2 control-label">Số ngày chăm sóc:</label>
                <div class="col-sm-4">
                <asp:TextBox ID="txtsongayntcs" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtnoidungtinnhansn" class="col-sm-2 control-label">Nội dung tin nhắn sinh nhật:</label>
                <div class="col-sm-10">
                <asp:TextBox ID="txtnoidungtinnhansn" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
            </div>
            <div class="form-group">
                <label for="txtnoidungtinnhandk" class="col-sm-2 control-label">Nội dung tin nhắn định kỳ:</label>
                <div class="col-sm-10">
                <asp:TextBox ID="txtnoidungtinnhandk" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>
            </div>
            <div class="panel-footer">
                <div class="form-group">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">
                        <asp:HiddenField ID="hfPopupUpdate" runat="server" />
                        <asp:Button ID="btnUSave" CssClass="btn btn-primary" runat="server" Text="Lưu" OnClick="btnUSave_Click" />
                        <button type="button" id="btnBoQua" class="btn btn-warning" runat="server" onserverclick="btnBoQua_ServerClick"><i class="fa fa-plus"></i>&nbsp;Xóa trắng</button>
                        <button type="button" id="btnXoa" class="btn btn-danger" runat="server" onserverclick="btnXoa_ServerClick"><i class="fa fa-times"></i>&nbsp;Xóa</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel">
        <div class="panel-heading">
            DANH SÁCH DOANH NGHIỆP
        </div>
        <div class="panel-body form-horizontal">
            <div class="table-primary">
                <asp:ScriptManager runat="server" ID="ScriptManager1" />
                <asp:GridView ID="GvgroupUser" CssClass="table table-striped table-bordered"
                    runat="server" AutoGenerateColumns="False" OnRowCommand="GvgroupUser_RowCommand"
                    DataKeyNames="id" >
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" >
                    <ItemStyle Width="20px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TenDN" HeaderText="Tên doanh nghiệp/tổ chức" ><ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="diachi" HeaderText="Địa chỉ" ><ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dienthoai" HeaderText="Số điện thoại" ><ItemStyle Width="100px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Email" HeaderText="Email" ><ItemStyle Width="100px" />
                    </asp:BoundField>
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
                    <%=txtTenDN.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập tên doanh nghiệp!'
                            }
                        }
                    },
                    <%=txtDiaChi.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập địa chỉ!'
                            }
                        }
                    },
                    <%=txtDienThoai.UniqueID%>: {
                        validators: {
                            notEmpty: {
                                message: 'Chưa nhập số điện thoại!'
                            }
                        }
                    },
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
            $('#MainContent_GvgroupUser').prepend($("<thead></thead>").append($('#MainContent_GvgroupUser').find("tr:first"))).dataTable({
                pageLength: 10,
                "language": {
                    "sProcessing":   "Đang xử lý...",
                    "sLengthMenu":   "_MENU_ dòng/trang",
                    "sZeroRecords":  "Không tìm thấy dòng nào phù hợp",
                    "sInfo":         "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ trang",
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
            $('#MainContent_GvgroupUser_wrapper .table-caption').text('Danh sách doanh nghiệp');
            $('#MainContent_GvgroupUser_wrapper .dataTables_filter input').attr('placeholder', 'Tìm kiếm...');
        }
    </script>
</asp:Content>

